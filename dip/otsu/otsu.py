import numpy as np
import cv2
import matplotlib.pyplot as plt
import sys
import traceback

def histogram(img, L=256):
    rows = img.shape[0]
    cols = img.shape[1]
    hist = np.zeros(shape=L, dtype=int)
    for i in range(rows):
        for j in range(cols):
            hist[img[i,j]] += 1
    return hist

def normalized_histogram(img, L=256):
    hist = histogram(img, L=L)
    norm_hist = hist / (img.shape[0]*img.shape[1])
    return norm_hist

def cumulative_histogram(img, L=256):
    cum_hist = np.zeros(shape=L, dtype=float)
    norm_hist = normalized_histogram(img, L=L)
    cum_hist[0] = norm_hist[0]
    for i in range(1, len(norm_hist)):
        cum_hist[i] = cum_hist[i-1] + norm_hist[i]
    # print('Cum hist: ', cum_hist)
    return cum_hist

def cumulative_mean(img, k, L=256):
    norm_hist = normalized_histogram(img, L=L)
    cumulative_mean = 0
    for i in range(k):
        cumulative_mean += i*norm_hist[i]
    return cumulative_mean

def average_intensity(img, L=256):
    return cumulative_mean(img, k=L, L=L)

def global_variance(img, L=256, norm_hist=[]):
    glob_var = 0
    glob_mean = average_intensity(img, L=L)
    if norm_hist is None:
        norm_hist = normalized_histogram(img, L=L)
    for i in range(L):
        glob_var += np.power(i - glob_mean, 2)*norm_hist[i]
    return glob_var

def mean_intensity_lower(img, k, L=256):
    cum_hist = cumulative_histogram(img, L=L)
    P_1 = cum_hist[k]
    cum_mean = cumulative_mean(img, k, L=L)
    return cum_mean / P_1

def mean_intensity_upper(img, k, L=256):
    norm_hist = normalized_histogram(img, L=L)
    cum_hist = cumulative_histogram(img, L=L)
    P_2 = 1 - cum_hist[k]
    cum_mean = 0
    for i in range(k,L):
        cum_mean += i*norm_hist[i]
    return cum_mean / P_2

def between_class_variance(img, k, L=256):
    cum_hist = cumulative_histogram(img, L=L)
    P_1 = cum_hist[k]
    P_2 = 1 - cum_hist[k]
    m1 = mean_intensity_lower(img, k, L=L)
    m2 = mean_intensity_upper(img, k, L=L)
    return P_1*P_2*np.power(m1-m2, 2)

def fst_between_class_variance(img, k, L=256,
                               all_cum_means=[],
                               glob_mean=0,
                               cum_hist=[]):
    m = all_cum_means[k]
    if glob_mean == 0:
        glob_mean = average_intensity(img, L=L)
    if cum_hist is None:
        cum_hist = cumulative_histogram(img, L=L)
    P_1 = cum_hist[k]
    if P_1 == 0 or P_1 == 1:
        raise Exception(f"Invalid between-class variance: P_1 = {P_1}")
    else:
        return (np.power(glob_mean*P_1 - m, 2))/(P_1*(1-P_1))

def threshold_effectiveness(img, k, L=256,
                            all_cum_means=[],
                            glob_var=0,
                            glob_mean=0,
                            cum_hist=[]):
    if glob_var == 0:
        glob_var = global_variance(img, L=L)
    bcv = fst_between_class_variance(img, k, L=L,
                                     all_cum_means=all_cum_means,
                                     glob_mean=glob_mean,
                                     cum_hist=cum_hist)
    return bcv / glob_var

def find_optimal_threshold(img, L=256, verbose=False):
    all_cum_means = np.zeros(shape=L)
    norm_hist = normalized_histogram(img, L=L)
    all_cum_means[0] = 0
    for i in range(1, L):
        all_cum_means[i] = all_cum_means[i-1] + i*norm_hist[i]
    glob_var = global_variance(img, L=L, norm_hist=norm_hist)
    cum_hist = cumulative_histogram(img, L=L)
    glob_mean = all_cum_means[L-1]
    thresholds = np.zeros(shape=L, dtype=float)
    for i in range(L):
        try:
            thresholds[i] = threshold_effectiveness(img, k=i, L=L,
                                                    all_cum_means=all_cum_means,
                                                    glob_var=glob_var,
                                                    glob_mean=glob_mean,
                                                    cum_hist=cum_hist)
            if verbose:
                print('Intensity pixel:\t', i)
                print('Threshold effectiveness:\t', thresholds[i])
        except Exception as e:
        #    traceback.print_exc()
            print(e)
            thresholds[i] = -1
        #thresholds[i] = threshold_effectiveness(img, k=i, L=L)
    optimal_threshold = np.argmax(thresholds)
    if verbose:
        print('Optimal threshold:\t', optimal_threshold)
    return optimal_threshold

def otsu(img, L=256, verbose=False):
    result = np.zeros(shape=img.shape, dtype=img.dtype)
    optimal_threshold = find_optimal_threshold(img, L=L, verbose=verbose)
    pos = np.where(img > optimal_threshold)
    result[pos] = 255
    return result, optimal_threshold


if len(sys.argv) < 2:
    print('Usage: python otsu <image_name> [--verbose] [--write]')
    sys.exit()

IMG_NAME = sys.argv[1]

VERBOSE = False
if len(sys.argv) >= 3:
    if sys.argv[2] == '--verbose':
        VERBOSE = True

WRITE = False
if len(sys.argv) >= 4:
    if sys.argv[3] == '--write':
        WRITE = True
    
img = cv2.imread(IMG_NAME, 0)
# img.dtype = np.uint8
#img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

print(img)

res, optim_threshold = otsu(img.copy(), L=256, verbose=VERBOSE)

if WRITE:
    cv2.imwrite('otsu_threshold.png', res)

fig, axs = plt.subplots(1,2,sharey=True)
axs[0].imshow(cv2.cvtColor(img.copy(), cv2.COLOR_BGR2RGB))
axs[0].set_title('Original')
axs[0].set_xticks([])
axs[0].set_yticks([])
axs[1].imshow(cv2.cvtColor(res.copy(), cv2.COLOR_BGR2RGB))
axs[1].set_title(f'Threshold = {optim_threshold}')
axs[1].set_xticks([])
axs[1].set_yticks([])
fig.suptitle('Algorithm: OTSU')
plt.show()
