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
        print(f'Signal:\n{sig}\n')
        print(f'Kernel:\n{kerr}\n')

    # Initializing the final result
    conv = np.zeros(shape=len(sig)+2*int(len(kerr)/2), dtype=sig.dtype)

    
    kerr = kerr[::-1]
    for i in range(offset,len(sig_padded)-offset):
        vi = 0
        for j in range(len(kerr)):
            vi += sig_padded[i-offset+j]*kerr[j]
        conv[i] = vi
    return conv


def convolution2d(img, kerr, verbose=False):
    h_img  = img.shape[0]
    l_img  = img.shape[1]
    h_kerr = kerr.shape[0]
    l_kerr = kerr.shape[1]

    if h_img < h_kerr or l_img < l_kerr:
        print('The kernel must be smaller than the image!')
        raise Exception('Invalid image or kernel shape')

    if h_kerr%2 == 0 or l_kerr%2 == 0:
        print('The kernel must be of odd shape!')
        raise Exception(f'Wrong kernel shape: ({h_kerr},{l_kerr})')

    offset_h = int(h_kerr/2)
    offset_l = int(l_kerr/2)

    # Padding (mandatory)
    img_pad = np.zeros(shape=(img.shape[0] + 2*offset_h,
                              img.shape[1] + 2*offset_l),
                       dtype=img.dtype)
    h_img_pad = img_pad.shape[0]
    l_img_pad = img_pad.shape[1]
    
    img_pad[offset_h:h_img_pad-offset_h,
            offset_l:l_img_pad-offset_l] = img

    if verbose:
        print(f'Image:\n{img}\n')
        print(f'Kernel:\n{kerr}\n')

    # Initializing the final result
    conv = np.zeros(shape=img_pad.shape,dtype=img.dtype)

    flipped_kerr = kerr[::-1,::-1]
    for i in range(offset_h,h_img_pad-offset_h):
        for j in range(offset_l,l_img_pad-offset_l):
            vij = 0
            for h in range(h_kerr):
                for k in range(l_kerr):
                    vij += img_pad[i-offset_h+h,
                                   j-offset_l+k] * kerr[h,k]
            conv[i,j] = vij
    return conv
            
