import numpy as np
import cv2
from PIL import Image

def save_picture(filename, source):
  image = Image.fromarray(np.uint8(source))
  image.save('./'+filename, dpi=(200, 200))

def constrast_stretching(source):
  min = np.min(source)
  max = np.max(source)
  L = 256
  source = (source - min) / (max - min) * (L - 1)
  return source.astype(np.uint8)

def DIP(filename, gamma):

	#original
	original = cv2.imread(filename + '.tif', cv2.IMREAD_GRAYSCALE)
	save_picture(filename+'_(a).jpg', constrast_stretching(original))

	#Laplacian
	kernel = np.array([[-1, -1, -1],
					   [-1,  8, -1],
			           [-1, -1, -1]], dtype = np.double)
	Laplacian = cv2.filter2D(original, ddepth = 16, kernel=kernel)
	save_picture(filename+'_(b).jpg', np.abs(constrast_stretching(Laplacian)))

	#Laplacian sharpen
	kernel = np.array([[-1, -1, -1],
					   [-1,  9, -1],
					   [-1, -1, -1]], dtype = np.double)
	Laplacian_sharpen = cv2.filter2D(original, ddepth = 16, kernel=kernel)
	save_picture(filename+'_(c).jpg', constrast_stretching(Laplacian_sharpen))

	#Sobel gradient
	kernel = np.array([[-1, -2, -1],
					   [0,   0,  0],
					   [1,   2,  1]], dtype = np.double)
	gx = cv2.filter2D(original, ddepth=16, kernel=kernel)

	kernel = np.array([[-1, 0, 1],
					   [-2, 0, 2],
					   [-1, 0, 1]], dtype = np.double)
	gy = cv2.filter2D(original, ddepth=16, kernel=kernel)

	Sobel_gradient = cv2.addWeighted(np.abs(gx), 0.5, np.abs(gy),0.5,0)
	save_picture(filename+'_(d).jpg', constrast_stretching(Sobel_gradient))

	#smooth gradient
	kernel = np.ones([5, 5]) / 25
	smooth_gradient = cv2.filter2D(Sobel_gradient, ddepth=16, kernel=kernel)
	save_picture(filename+'_(e).jpg', constrast_stretching(smooth_gradient))

	#extracted feature
	extracted_feature = cv2.multiply(np.sqrt(smooth_gradient).astype(np.uint8),np.sqrt(Laplacian).astype(np.uint8))
	save_picture(filename+'_(f).jpg', constrast_stretching(extracted_feature))

	g = cv2.addWeighted(original, 0.5, extracted_feature,0.5,0, dtype = 16)
	save_picture(filename+'_(g).jpg', constrast_stretching(g))

	#power law
	h = np.array(255*(g / 255) ** gamma)
	save_picture(filename+'_(h).jpg', constrast_stretching(h))

if __name__ == "__main__": 
	DIP('kid blurred-noisy', gamma = 1.4)
	DIP('fruit blurred-noisy', gamma = 1.2)