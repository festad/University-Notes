import numpy as np
import cv2
import matplotlib.pyplot as plt
import sys

from node import Node

if len(sys.argv) != 2:
    print('Usage: python split <image name>')
    sys.exit()

def split(img, threshold=10, min_length=8):
    node = Node(img, threshold=threshold, min_length=min_length)
    node.split()
    return node.pixels

img = cv2.imread(sys.argv[1], 0) # 0 -> BLACK AND WHITE

splitted = split(img.copy(), threshold=2, min_length=64)

fig, axs = plt.subplots(1,2,sharey=True)
axs[0].imshow(img)
axs[0].title('Original')
axs[1].imshow(splitted)
axs[1].title('Splitted')
plt.title('Algorithm: SPLIT')
plt.show()
