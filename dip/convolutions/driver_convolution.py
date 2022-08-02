import numpy as np
import convolution as cvl

img = np.arange(1,26).reshape(5,5)
img.dtype=int
kerrdx = np.array([[-1,0,1],
                   [-2,0,2],
                   [-1,0,1]])
kerrdx.dtype=int
kerrdy = np.array([[-1,-2,-1],
                   [ 0, 0, 0],
                   [ 1, 2, 1]])
kerrdy.dtype=int

dx = cvl.convolution2d(img,kerrdx,verbose=True)
print(f'\nDx:\n{dx}\n')
dy = cvl.convolution2d(img,kerrdy,verbose=True)
print(f'\nDy:\n{dy}\n')

print('\nWith Fourier:\n')
t_img = np.fft.fft2(img)

def padd_kerr(kerr, img_h, img_l):
    res = np.zeros(shape=(img_h,img_l),
                   dtype=kerr.dtype)
    res[:kerr.shape[0],:kerr.shape[1]] = kerr
    return res

kerrdx = padd_kerr(kerrdx,img.shape[0],img.shape[1])
kerrdy = padd_kerr(kerrdy,img.shape[0],img.shape[1])
    
t_kdx = np.fft.fft2(kerrdx)
t_kdy = np.fft.fft2(kerrdy)

f_dx = np.fft.ifft2(t_img*t_kdx)
f_dy = np.fft.ifft2(t_img*t_kdy)

print(f'Dx:\n{f_dx}\n')
print(f'Dy:\n{f_dy}\n')
