import numpy as np

def f(x):
    x = abs(x)
    if(x < 1e-5): return 3.75
    
    t = np.e**(-x)
    return min(np.log((1+t)/(1-t)), 3.75)


def round_to(num, target):
    return round(num/target)*target


# Calculate X_value from 6 bit number, 2 integer: 4 fractional
def calc_x_val(num: int):
    bits = [(num//(i>>1))%2 for i in [64,32,16,8,4,2]]
    return (bits[0]*2 + bits[1]) + (0.5*(bits[2] + 0.5*(bits[3] + 0.5*(bits[4] + 0.5*bits[5]))))


# Given a floating value from f(x), convert it into 4 bit number, 2 integer: 2 fractional
def calc_bits_from_Y_val(num: int) -> str :
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


def x_val_to_bin(num: int) -> str:
    return "{0:06b}".format(num)


for i in range(1<<6):
    curr_x_val = calc_x_val(i)
    curr_Y_val = f(curr_x_val)
    curr_str = f"6'b{x_val_to_bin(i)}: Y = 4'b{calc_bits_from_Y_val(curr_Y_val)};  // f({curr_x_val}) = {curr_Y_val} ~ {round_to(curr_Y_val, 0.25)}"
    print(curr_str)
