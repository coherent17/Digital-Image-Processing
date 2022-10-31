import numpy as np
import matplotlib.pyplot as plt
import cv2
import pandas as pd

#helper function to plot the image
def plot(img):
	plt.figure(figsize = (8, 8))
	plt.imshow(img, cmap = 'gray')
	plt.axis('on')
	plt.show()

def top25(Fshift):
    M, N = Fshift.shape
    coordinate = np.dstack(np.unravel_index(np.argsort(Fshift.ravel()), (M, N)))
    top_25_coordinate = (coordinate[0][-25:])[::-1]
    return top_25_coordinate

def log(top_25_coordinate, F_shift):
    for i in range(25):
        u = top_25_coordinate[i][0]
        v = top_25_coordinate[i][1]
        print('(u, v) = (%d %d) with abs(DFT) = %f' %(u, v, F_shift[u,v]))

def DIP(name):

	#readfile:
	f = cv2.imread(name + '.tif', 0)
	M, N = f.shape

	#for question (b)
	F = np.fft.fft2(f)
	Fshift = np.fft.fftshift(F)
	plot(np.log1p(np.abs(Fshift)))
	top_25_coordinate = top25(Fshift)


	#padding to avoid wraparound error
	f_pad = cv2.copyMakeBorder(f, 0, M, 0, N, cv2.BORDER_CONSTANT , value = 0)
	F_pab = np.fft.fft2(f_pad)
	F_pad_shift = np.fft.fftshift(F_pab)

	#construct Gaussian low pass filter
	LPF = np.zeros((2*M, 2*N))
	D0 = 200		#cut off frequency

	for u in range(2*M):
		for v in range(2*N):
			D_2 = (u-M)**2 + (v-N)**2
			LPF[u,v] = np.exp(-1*D_2/(2*D0*D0))
	plot(LPF)

	#construct Gaussian high pass filter
	HPF = 1 - LPF
	plot(HPF)
	

	#output of LPF
	G_LPF_shift = F_pad_shift * LPF
	G_LPF = np.fft.ifftshift(G_LPF_shift)
	g_LPF = np.real(np.fft.ifft2(G_LPF))[:M, :N]
	plot(g_LPF)

	#output of HPF
	G_HPF_shift = F_pad_shift * HPF
	G_HPF = np.fft.ifftshift(G_HPF_shift)
	g_HPF = np.real(np.fft.ifft2(G_HPF))[:M, :N]
	plot(g_HPF)
 
 
	log(top_25_coordinate, Fshift)

if __name__ == "__main__":
    DIP('kid')
    DIP('fruit')