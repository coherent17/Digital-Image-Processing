# DIP 

[TOC]

## Project

### Project1 : Image Enhancement In Spatial Domain
https://github.com/coherent17/Digital-Image-Processing/tree/main/Project1

### Project2 : Image Enhancement In Frequency Domain
https://github.com/coherent17/Digital-Image-Processing/tree/main/Project2

### Project3 : Alpha-Trimmed Filter & Inverse Filtering
https://github.com/coherent17/Digital-Image-Processing/tree/main/Project3

### Project4 : Color-Image Sharpening
https://github.com/coherent17/Digital-Image-Processing/tree/main/Project4

### Project5 : Canny Edge Detection
https://github.com/coherent17/Digital-Image-Processing/tree/main/Project5


## In Class Question:

### In-class QA for September 12

:::spoiler {state="open"}Describe the function, f(x, y), for an image.
:::info
x, y is the doordinate of the image, and f(x, y) refer to the intensity(gray level) of the image.
:::

:::spoiler {state="open"}When we process a digital image, which term(s) do we modify?
:::info
f(x, y), the intensity of the image.
:::

:::spoiler {state="open"}Write one of the major functions of low-level processing in DIP.
:::info
Reduce noise and improve image quality.
:::

### In-class QA for September 19

:::spoiler {state="open"}i(x, y)=0, what does it mean?
:::info
No light, totally dark, totally black no matter what color/brightness the object is
:::

:::spoiler {state="open"}Explain the meaning of r(x,y) = 0?
:::info
Nothing reflected , totally dark, black.
:::

:::spoiler {state="open"}Explain the meaning of r(x,y) = c?
:::info
The reflectance of the entire object is the same; only one gray tone with intensity c.
:::

:::spoiler {state="open"}Consider an image of size 512x512 with 256 gray levels, how many KB of memory capacity are required to store this image?
:::info
(512x512x8)/8 = 2^18 B = 2^8 2^10 B = 2^8 KB = 256KB
:::

:::spoiler {state="open"}Plot the pixels on the 2D plane satisfying the following conditions. Clearly specify the coordinates on the plane. 1. City block disatnce D4 <=2, 2. Chessboard distance D8 <=2.
:::info
![](https://i.imgur.com/1ZdaVXH.png)
:::

### In-class QA for September 26

:::spoiler {state="open"}Give one example of applications of image subtraction widely used in medical imageing.
:::info
Difference image between the imgaes after/before injection of contrast medium.
:::

:::spoiler {state="open"}Assume H{} is a linear operator. Define the linearity property by mathematic formulas.
:::info
1. additivity: given H{f1}=g1 and H{f2}=g2, H{f1+f2}=g1+g2
2. homogeneity (scaling): given H{f} = g, H{af} = ag
:::

:::spoiler {state="open"}Which intensity transformation curve can produce an output image lighter than the input image?
:::info
log-transformation function (s = cLog(1+r)) or power-law transformation with power < 1 (output intensity s = cr^γ, γ <1)
![](https://i.imgur.com/0BBeQFn.png)
![](https://i.imgur.com/C0cNGsp.png)
:::

:::spoiler {state="open"}Many display instruments have the power law distortion problemm. How to solve it?
:::info
Gamma correction (using power-law intensity transformation)
:::

:::spoiler {state="open"}For the dark camellia image, we may apply power-law with power (γ) < 1 to make it brighter. If γ is too small, what region of the image becomes indescernible (loses its original pattern)?
:::info
Original bright regions (circled below)
![](https://i.imgur.com/ooOz4ff.png)
:::

:::spoiler {state="open"}Consider an image in FigA, identify the intensity transformation curve, s=T(r), from the set of curves in FigB to produce each of the output images in FigsC - F.
:::info
![](https://i.imgur.com/8oWbeKz.png)
c: more contrast
d: become brighter
e: become darker
f: negative
:::


### In-class QA for October 3

:::spoiler {state="open"}Describe the limitation of histogram equalization.
:::info
Histogram equalization (HE) is a fixed scheme producing only one fixed output image. When the input image has a histogram distributing over the entire range of intensity, HE can hardly improve the contrast.
:::

:::spoiler {state="open"}What is the basic scheme for developing histogram-spec algorithm?
:::info
Histogram equalization.
:::

:::spoiler {state="open"}For a smooth local area with constant gray level, what should the local variance be?
:::info
0
:::

:::spoiler {state="open"}For the method of local processing, Why a lower bound (k2σG) is necessary for local std σs(x,y)?
:::info
We don't want to make any change on the subimage with almost constant intensity.
:::

:::spoiler {state="open"}The table below lists the number of pixels of each gray level for a 3-bit input image. 1. Determine the intensity transformation function s=T( r ) for histogram equalization. 2. Determine the output histogram after applying histogram equalization to the input image with the histogram shown below.
![](https://i.imgur.com/2uooIf0.png)

:::info
![](https://i.imgur.com/tfK9WWZ.png)
:::

### In-class QA for October 17

:::spoiler {state="open"}Describe the pro and cons of using a large box kernel (eg, 21x21).
:::info
Pro: better reduce noise power.
Cons: seriously blur smaller patterns so that they become indistinguishable.
:::

:::spoiler {state="open"}What is the drawback of using zero padding in spatial filtering?
:::info
Dark boader lines may be generated when the imgae near boarder is very bright.
:::

:::spoiler {state="open"}What is the 3x3 mask that generates the same output images as the input image?
:::info
![](https://i.imgur.com/RIaFAln.png)
:::

:::spoiler {state="open"}What is the Gy image of the iarplane image (A or B)?
:::info
![](https://i.imgur.com/FxTbvnj.png)
Ans: B extracted vertical edges
:::

:::spoiler {state="open"}What is the size M of Gaussian kernel with standard deviation 1.5?
:::info
M=9
:::

:::spoiler {state="open"}Briefly describe the term "iostropic" in designing the spatial mask.
:::info
In mask design, isotropic indicates "rotation-invariant"; that is, when applying an isotropic mask to a rotated image, the result will be the same as which rotating (at the same angle) tha isotropic-mask processed image.
:::

### In-class QA for October 24

:::spoiler {state="open"}What is the highest frequency (in Hz) that can be expressed by a discrete time series sampled at fs Hz sampling rate?
:::info
fs/2 Hz
:::

:::spoiler {state="open"}What is the effect of spatial translation on DFT Fourier magnitude?
:::info
No change (same as the Fourier magnitude of original image before spatial translation)
:::

:::spoiler {state="open"}Consider the pattern f(x,y) below. The right image g(x,y) is generated by the 8x8 inverse DFT of {F(u,v)W8^(x0u+y0v)}, where F(u,v) is the 8x8 DFT of f(x,y). What are x0 and y0?
:::info
![](https://i.imgur.com/qjs646X.png)
x0 = 3, y0 = 4
:::


### In-class QA for October 31

:::spoiler {state="open"}Why do we use 2Mx2N DFT for an MxN image when implementing filter in frequency domain?
:::info
To avoid wraparound error caused by circular concolution.
:::

:::spoiler {state="open"}Briefly describe the major factor causing ringing effect in the output (filtered) image.
:::info
Vigorous oscillation of sidelobes of a filter's impulse response; for example, impulse response of an ideal lowpass filter, a sinc function.
:::

:::spoiler {state="open"}Describe the relation between order n and the transition band of Butterworth.
:::info
Increasing order n reduces the width of transition band. As n approched infinity, Butterworth filter approximates the ideal filter.
:::

:::spoiler {state="open"}Given f(x,y) and h(x,y) below, compute the linear convolution.
:::info
![](https://i.imgur.com/xH3a5dO.png)
![](https://i.imgur.com/Qv2kQpq.png)
:::

:::spoiler {state="open"}Given f(x,y) and h(x,y) below, compute the 3x3 circular convolution.
:::info
![](https://i.imgur.com/vDPpM2g.png)
![](https://i.imgur.com/0jKeqNz.png)
:::


### In-class QA for November 7

:::spoiler {state="open"}What is important scheme in Homomorphic filtering that enables us to treat illumination and reflectance factors separately?
:::info
Apply logarithm to input image.
:::

:::spoiler {state="open"}Why don't we use the bandreject filter to remove the periodic interference?
:::info
We may also eliminate substantial frequency components of teh important features of the original image within the stopband (a ring) of a bandreject filter.
:::

:::spoiler {state="open"}What is assumption for the degradation process (system)?
:::info
LSI (linear shift-invariant)
:::

:::spoiler {state="open"}What is assumption for the additive noise?
:::info
random and uncorrelated with the image
:::

:::spoiler {state="open"}Identify the type of noise in the image below.
:::info
![](https://i.imgur.com/nl0WGO6.png)
Salt noise.
:::


### In-class QA for November 14

:::spoiler {state="open"}What problem will occur if the median filter is applied too many times to an image with salt-and-pepper noise?
:::info
The image will be blurred.
:::

:::spoiler {state="open"}Among three order-statistic filters (min, max, and median), which one will generate a darkest output when it is used to process the image contaminated by salt-and-pepper noise?
:::info
Min filter
:::

:::spoiler {state="open"}Explain the concern of applying inverse filtering to the entire (u,v) plane.
:::info
The inverse filter has a large magnitude response in high-frequency region that may seriously distort the image, especially when noise appears, that will lead to corruption of the image.
:::


:::spoiler {state="open"}Describe the initial criterion used by developing the Weiner filter.
:::info
Minimization of expectation of square absolute error between actual and estimated noise-free image.
:::

### In-class QA for December 5
:::spoiler {state="open"}![](https://i.imgur.com/xaGrpwE.png)

:::info
1. (Fig B, Fig C, Fig D) = (G, B, R)
2. Saturation (S)
3. Complement
:::

## Final Midterm

### Q1
:::spoiler {state="open"}
![](https://i.imgur.com/WI7u4Yz.png)
:::info
![](https://i.imgur.com/2qVZD9M.png)
![](https://i.imgur.com/vwWeQE3.png)

:::

### Q2
:::spoiler {state="open"}
![](https://i.imgur.com/xiX2GDu.png)
:::info
![](https://i.imgur.com/DyTJAjt.png)
:::

### Q3
:::spoiler {state="open"}
![](https://i.imgur.com/rgkICfo.png)
:::info
![](https://i.imgur.com/9ar5ha1.png)
:::


### Q4
:::spoiler {state="open"}
![](https://i.imgur.com/AUsV8gQ.png)
:::info
![](https://i.imgur.com/OhQJ7H8.png)
:::


### Q5
:::spoiler {state="open"}
![](https://i.imgur.com/At77N4C.png)
:::info
![](https://i.imgur.com/UkNEPam.png)
![](https://i.imgur.com/HbL7Wcp.png)
:::

### Q6
:::spoiler {state="open"}
![](https://i.imgur.com/qbYdJSr.png)
:::info
![](https://i.imgur.com/8DMwOBT.png)
:::

### Q7
:::spoiler {state="open"}
![](https://i.imgur.com/D1nRnk0.png)
:::info
![](https://i.imgur.com/teGoaju.png)
:::
