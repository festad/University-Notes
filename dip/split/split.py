import numpy as np
import cv2
import matplotlib.pyplot as plt
import sys

from node import Node

VERBOSE            = True
THRESHOLD_NORM_VAR = 100

if len(sys.argv) < 2:
    print('Usage: python split <image name> [--write]')
    sys.exit()

def split(img, threshold=10, min_length=8, verbose=False):
    node = Node(img, threshold=threshold, min_length=min_length)
    node.split(verbose)
    return node.pixels

img = cv2.imread(sys.argv[1], 0) # 0 -> BLACK AND WHITE
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

splitted = split(img.copy(), threshold=THRESHOLD_NORM_VAR, min_length=4, verbose=VERBOSE)

if len(sys.argv) == 3:
    if sys.argv[2] == '--write':
        cv2.imwrite('img-org.png', img)
        cv2.imwrite('img-spl.png',splitted)


fig, axs = plt.subplots(1,2,sharey=True)

axs[0].imshow(img)
axs[0].set_title('Original')
axs[0].set_xticks([])
axs[0].set_yticks([])

axs[1].imshow(splitted)
axs[1].set_title('Splitted')
axs[1].set_xticks([])
axs[1].set_yticks([])

fig.suptitle('Algorithm: SPLIT')
plt.show()
