import cv2
import numpy as np
import sys

from matplotlib import pyplot as plt

import convolution as cvl

if len(sys.argv) != 2:
    print('Usage: python driver_img_convolution.py image_name')
    sys.exit()

IMG_NAME = sys.argv[1]

imgor = cv2.imread(IMG_NAME,0)
img = cv2.resize(imgor, (200,200))

img.dtype=np.uint8

kerrdx = np.array([[-1,0,1],
                   [-2,0,2],
                   [-1,0,1]])

kerrdy = np.array([[-1,-2,-1],
                   [ 0, 0, 0],
                   [ 1, 2, 1]])

dx = cvl.convolution2d(img,kerrdx,verbose=True)
dx.dtype=np.uint8
dy = cvl.convolution2d(img,kerrdy,verbose=True)
dy.dtype=np.uint8

mod = np.sqrt(np.square(dy)+np.square(dx))

fig,axs = plt.subplots(2,2)
axs[0,0].imshow(dx, cmap='gray',interpolation='none')
axs[0,1].imshow(dy, cmap='gray',interpolation='none')
axs[1,0].imshow(img, cmap='gray',interpolation='none')
axs[1,1].imshow(mod, cmap='gray',interpolation='none')
# plt.xticks([]), plt.yticks([])

plt.show()
