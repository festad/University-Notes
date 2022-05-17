import cv2
import matplotlib.pyplot as plt
import numpy as np

def convolution(sig, kerr, verbose=False):
    if len(sig) < len(kerr):
        tmp = sig
        sig = kerr
        kerr = tmp

    if len(kerr)%2 == 0:
        print('The kernel has to be of odd length!')
        raise Exception(f'Wrong kernel size: {len(kerr)}')

    offset = int(len(kerr)/2)

    # Padding (mandatory)
    sig_padded = np.zeros(shape=len(sig)+2*offset, dtype=sig.dtype)
    sig_padded[offset:len(sig_padded)-offset] = sig

    if verbose:
        print(f'Signal: ', sig)
        print(f'Kernel: ', kerr)

    # Initializing the final result
    conv = np.zeros(shape=len(sig)+2*int(len(kerr)/2), dtype=sig.dtype)

    
    kerr = kerr[::-1]
    for i in range(offset,len(sig_padded)-offset):
        vi = 0
        for j in range(len(kerr)):
            vi += sig_padded[i-offset+j]*kerr[j]
        conv[i] = vi
    return conv
