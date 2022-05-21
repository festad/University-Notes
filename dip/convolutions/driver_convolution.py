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
