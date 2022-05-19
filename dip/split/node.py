import numpy as np

class Node:
    def __init__(self, pixels,
                 l1=None, r1=None, l2=None, r2=None,
                 threshold=None, min_length=8):
        self.pixels = pixels
        self.height = self.pixels.shape[0]
        self.length = self.pixels.shape[1]
        self.l1 = l1
        self.r1 = r1
        self.l2 = l2
        self.r2 = r2

        self.min_length = min_length
        self.threshold = threshold

    def divide_in_four(self):
        half_h = int(self.height/2)
        half_l = int(self.length/2)
        pixl1 = self.pixels[:half_h, :half_l]
        pixr1 = self.pixels[:half_h, half_l:self.length]
        pixl2 = self.pixels[half_h:self.height, :half_l]
        pixr2 = self.pixels[half_h:self.height, half_l:self.length]
        
        self.l1 = Node(pixels=pixl1,
                       threshold=self.threshold,
                       min_length=self.min_length)
        self.r1 = Node(pixels=pixr1,
                       threshold=self.threshold,
                       min_length=self.min_length)
        self.l2 = Node(pixels=pixl2,
                       threshold=self.threshold,
                       min_length=self.min_length)
        self.r2 = Node(pixels=pixr2,
                       threshold=self.threshold,
                       min_length=self.min_length)

    def variance(self):
        return np.var(self.pixels)

    def average(self):
        return np.average(self.pixels)

    def split(self, verbose=False):
        # evaluate variance
        normalized_var = self.variance()/self.height*self.length
        if verbose:
            print('Area dimension: ', self.pixels.shape)
            print('Normalized variance: ', normalized_var)
            
        if normalized_var > self.threshold \
           and self.height > self.min_length \
           and self.length > self.min_length:
           
            self.divide_in_four()
            self.l1.split()
            self.r1.split()
            self.l2.split()
            self.r2.split()
        else:
            # average of the pixels
            # color the area
            self.pixels[::] = self.average()
            return
