# References for this test generation: 
# https://dsp.stackexchange.com/questions/42517/gaussian-noise-generation-for-a-given-snr
# https://github.com/hichamjanati/pyldpc/


"""
Coding - Decoding simulation of an image
========================================
This example shows a simulation of the transmission of an image as a
binary message through a gaussian white noise channel with an LDPC coding and
decoding system.
"""


import numpy as np
from pyldpc import coding_matrix, ldpc_images, decode, get_message
from pyldpc.utils_img import gray2bin, rgb2bin, bin2gray
from pyldpc.utils import check_random_state
from matplotlib import pyplot as plt
import warnings
from PIL import Image
import verilog_decoder
from time import time
    


def encode_img(tG, img_bin, snr, seed=None):
    """Encode a binary image and adds Gaussian white noise.

    Parameters
    ----------
    tG: array (n, k). Coding matrix. `k` is the number of bits to be coded.
        `n` is the length of the codewords.
    img_bin: array (height, width, depth). Binary image.
    snr : float. Signal to noise ratio of the channel.
    seed: int. random state initialization.

    Returns
    -------
    coded_img: array (n, n_blocks) image in the codeword space
    noisy_img: array (height, width, k) visualization of the noisy image

    """
    seed = check_random_state(seed)
    n, k = tG.shape

    height, width, depth = img_bin.shape
    if depth not in [8, 24]:
        raise ValueError("The expected dimension of a binary image is "
                         "(width, height, 8) for grayscale images or "
                         "(width, height, 24) for RGB images; got %s"
                         % list(img_bin.shape))
    img_bin = img_bin.flatten()
    n_bits_total = img_bin.size
    n_blocks = n_bits_total // k
    residual = n_bits_total % k
    if residual:
        n_blocks += 1
    resized_img = np.zeros(k * n_blocks)
    resized_img[:n_bits_total] = img_bin

    codeword = encode(tG, resized_img.reshape(k, n_blocks), snr, seed)
    noisy_img = (codeword.flatten()[:n_bits_total] < 0).astype(int)
    noisy_img = noisy_img.reshape(height, width, depth)

    if depth == 8:
        noisy_img = bin2gray(noisy_img)
    else:
        noisy_img = bin2rgb(noisy_img)

    return codeword, noisy_img


def decode_img(tG, H, codeword, snr, img_shape):
    """Decode a received noisy image in the codeword.

    Parameters
    ----------
    tG: array (n, k) coding matrix G
    H: array (m, n) decoding matrix H
    img_coded: array (n, n_blocks) image recieved in the codeword
    snr: float. signal to noise ratio assumed of the channel.
    img_shape: tuple of int. Shape of the original binary image.
    maxiter: int. Max number of BP iterations to perform.
    n_jobs: int. Number of parallel jobs.

    Returns
    -------
    img_decode: array(width, height, depth). Decoded image.

    """
    n, k = tG.shape
    _, n_blocks = codeword.shape

    depth = img_shape[-1]
    if depth not in [8, 24]:
        raise ValueError("The expected dimension of a binary image is "
                         "(width, height, 8) for grayscale images or "
                         "(width, height, 24) for RGB images; got %s"
                         % list(img_shape))
    if len(codeword) != n:
        raise ValueError("The left dimension of `codeword` must be equal to "
                         "n, the number of columns of H.")

    systematic = True

    if not (tG[:k, :] == np.identity(k)).all():
        warnings.warn("""In LDPC applications, using systematic coding matrix
                         G is highly recommanded to speed up decoding.""")
        systematic = False

    codeword_solution = verilog_decoder.decode(H, codeword, snr)
    if systematic:
        decoded = codeword_solution[:k, :]
    else:
        decoded = np.array([get_message(tG, codeword_solution[:, i])
                           for i in range(n_blocks)]).T
    decoded = decoded.flatten()[:np.prod(img_shape)]
    decoded = decoded.reshape(*img_shape)

    if depth == 8:
        decoded_img = bin2gray(decoded)
    else:
        decoded_img = bin2rgb(decoded)

    return decoded_img



##################################################################
# Let's see the image we are going to be working with
eye = Image.open("data/eye.png")
# convert it to grayscale and keep one channel
eye = np.asarray(eye.convert('LA'))[:, :, 0]

# Convert it to a binary matrix
eye_bin = gray2bin(eye)
print("Eye shape: (%s, %s)" % eye.shape)
print("Binary Eye shape: (%s, %s, %s)" % eye_bin.shape)

d_v = 3
d_c = 6
L = 32
n = L*d_c*d_c
seed = 42

##################################################################
# First we create a small LDPC code i.e a pair of decoding and coding matrices
# H and G. H is a regular parity-check matrix with d_v ones per row
# and d_c ones per column

# H, G = make_ldpc(n, d_v, d_c, seed=seed, systematic=False, sparse=True)
H = verilog_decoder.get_H()
G = coding_matrix(H, sparse=True)
print(H.shape, G.shape)
##################################################################
# Now we simulate the transmission with Gaussian white noise
# and recover the original image via belief-propagation.

snr = 20
eye_coded, eye_noisy = ldpc_images.encode_img(G, eye_bin, snr, seed=seed)

print("Coded eye shape", eye_coded.shape)

t = time()
eye_decoded = decode_img(G, H, eye_coded, snr, eye_bin.shape)
t = time() - t
print("Eye | Decoding time: ", t)
error_decoded_eye = abs(eye - eye_decoded).mean()
error_noisy_eye = abs(eye_noisy - eye).mean()


##################################################################
# With RGB images, we proceed similarly
print("\n\n")
tiger = np.asarray(Image.open("data/tiger.jpg"))
# Convert it to a binary matrix
tiger_bin = rgb2bin(tiger)
print("Tiger shape: (%s, %s, %s)" % tiger.shape)
print("Tiger Binary shape: (%s, %s, %s)" % tiger_bin.shape)


tiger_coded, tiger_noisy = ldpc_images.encode_img(G, tiger_bin, snr, seed=seed)

print("Coded Tiger shape", tiger_coded.shape)

t = time()
tiger_decoded = ldpc_images.decode_img(G, H, tiger_coded, snr, tiger_bin.shape)
t = time() - t
print("Tiger | Decoding time: ", t)

error_decoded_tiger = abs(tiger - tiger_decoded).mean()
error_noisy_tiger = abs(tiger_noisy - tiger).mean()


titles_eye = ["Original", "Noisy | Err = %.3f %%" % error_noisy_eye,
              "Decoded | Err = %.3f %%" % error_decoded_eye]
titles_tiger = ["Original", "Noisy | Err = %.3f %%" % error_noisy_tiger,
                "Decoded | Err = %.3f %%" % error_decoded_tiger]
all_imgs = [[eye, eye_noisy, eye_decoded], [tiger, tiger_noisy, tiger_decoded]]
f, axes = plt.subplots(2, 3, figsize=(12, 8))
for ax_row, titles, img_list, cmap in zip(axes, [titles_eye, titles_tiger],
                                          all_imgs, ["gray", None]):
    for ax, data, title in zip(ax_row, img_list, titles):
        ax.imshow(data, cmap=cmap)
        ax.set_title(title, fontsize=20)
        ax.set_xticks([])
        ax.set_yticks([])
plt.tight_layout()
plt.show()