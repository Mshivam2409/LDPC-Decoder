# Python wrapper for testing verilog module of LDPC Decoder
import numpy as np
import os

def get_H():
    return np.load("permutations/H_np_array.npy")


def round_to(num, target):
    return round(num/target)*target


# Given a floating value, convert it into 4 bit number, 2 integer: 2 fractional
def calc_bits_from_float(num: int) -> str :
    # Clip number betwwen [-3.75 to 3.75]
    num = min(max(num, -3.75), 3.75)

    rounded_Y_val = round_to(num, 0.25)

    int_val = int(np.floor(rounded_Y_val))
    
    frac_val = rounded_Y_val - int_val
    frac_str = ""
    i = round(100*frac_val)

    if i == 0       :  frac_str = "00"
    elif i == 25 :  frac_str = "01"
    elif i == 50 :  frac_str = "10"
    elif i == 75 :  frac_str = "11"

    return ("{0:02b}".format(int_val)) + frac_str

# Function to find two's complement 
def findTwoscomplement(str): 
    n = len(str) 
  
    # Traverse the string to get first  
    # '1' from the last of string 
    i = n - 1
    while(i >= 0):
        if (str[i] == '1'):  break
        i -= 1
  
    # Continue traversal after the  
    # position of first '1'
    k = i - 1
    while(k >= 0): 
        # Just flip the values 
        str = list(str)
        str[k] = '1' if (str[k]=='0') else'0'
        str = ''.join(str) 
  
        k -= 1
  
    # return the modified string 
    return str


# llr to 5 bit binary data in two's complement form
def llr_to_binary_str(llr):
    bin_abs_val = calc_bits_from_float(abs(llr))
    if(llr<0): return findTwoscomplement("0" + bin_abs_val)
    else     : return ("0" + bin_abs_val)


def write_frame_to_file(L, K, frame, file_obj, snr):
    # https://dsp.stackexchange.com/questions/42517/gaussian-noise-generation-for-a-given-snr
    sigma = 10 ** (-snr / 20)

    for y in frame:
        # http://dde.binghamton.edu/filler/mct/lectures/25/mct-lect25-bawgnc.pdf
        llr = (2*y)/(sigma*sigma)
        file_obj.write(llr_to_binary_str(llr) + " ")

# def read_frame_from_file():


# codeword: array (n, n_blocks), n = L*K*K
def decode(H, codeword, snr, file="inp.txt"):
    K = 6
    L = H.shape[1]//(K*K)

    file_obj = open("inp.txt", "w")
    for col in range(codeword.shape[1]):
        curr_frame = codeword[:,col]
        write_frame_to_file(L, K, curr_frame, file_obj, snr)
        file_obj.write("\n")

    dummy=np.zeros(codeword.shape[0])
    write_frame_to_file(L,K,dummy,file_obj,snr)
    file_obj.write("\n")
    write_frame_to_file(L,K,dummy,file_obj,snr)
    number_of_codeframes=codeword.shape[1]+2

    file_obj.close()

    os.system("iverilog -g2012 -o test Decoder_tb.v")
    s="vvp test +FRAMES="+str(number_of_codeframes)
    os.system(s)


    return None

