clc;
clear;
close all;

filename = 'Kid2 degraded.tiff';
f = imread(filename);
[M, N] = size(f);
[pixelCount] = imhist(f);
P_a = pixelCount(1) / sum(pixelCount);
P_b = pixelCount(256) / sum(pixelCount);


%alpha trim
image_pad = padarray(f,[2,2], 'symmetric');
for i = 3 : 802
    for j = 3 : 802
        value = [image_pad(i-2,j-2),image_pad(i-2,j-1),image_pad(i-2,j),image_pad(i-2,j+1),image_pad(i-2,j+2),...
                      image_pad(i-1,j-2),image_pad(i-1,j-1),image_pad(i-1,j),image_pad(i-1,j+1),image_pad(i-1,j+2),...
                      image_pad(i,j-2),image_pad(i,j-1),image_pad(i,j),image_pad(i,j+1),image_pad(i,j+2),...
                      image_pad(i+1,j-2),image_pad(i+1,j-1),image_pad(i+1,j),image_pad(i+1,j+1),image_pad(i+1,j+2),...
                      image_pad(i+2,j-2),image_pad(i+2,j-1),image_pad(i+2,j),image_pad(i+2,j+1),image_pad(i+2,j+2)];
        value_sort = sort(value);
        mean_value = mean(value_sort(9:17));
        image_pad(i,j) = mean_value;
    end
end

denoise_image = zeros([M,N]);
denoise_image(1:M,1:N) = image_pad(3:802,3:802);

%Generate Gaussian LPF & Butterworth LPF:

beta = 1;
n = 5;
ButterWorth_D0 = 200;

GLPF_100 = zeros(2*M,2*N);
GLPF_150 = zeros(2*M,2*N);
GLPF_200 = zeros(2*M,2*N);
GLPF_250 = zeros(2*M,2*N);

BLPF = zeros(M,N);

for u = 1:2*M
    for v = 1:2*N
        D2 = (u-M)^2 + (v-N)^2;
        GLPF_100(u,v) = exp(-1*D2/(2*100*100));
        GLPF_150(u,v) = exp(-1*D2/(2*150*150));
        GLPF_200(u,v) = exp(-1*D2/(2*200*200));
        GLPF_250(u,v) = exp(-1*D2/(2*250*250));
        BLPF(u,v) = 1/(1+beta*(D2/(ButterWorth_D0*ButterWorth_D0))^n);
    end
end

%image pass inverse filter
eps = 1e-6;
devonvolution_GLPF_100_ = real(ifft2(ifftshift(fftshift(fft2(denoise_image, 2*M, 2*N)).*BLPF./(GLPF_100+eps))));
devonvolution_GLPF_150_ = real(ifft2(ifftshift(fftshift(fft2(denoise_image, 2*M, 2*N)).*BLPF./(GLPF_150+eps))));
devonvolution_GLPF_200_ = real(ifft2(ifftshift(fftshift(fft2(denoise_image, 2*M, 2*N)).*BLPF./(GLPF_200+eps))));
devonvolution_GLPF_250_ = real(ifft2(ifftshift(fftshift(fft2(denoise_image, 2*M, 2*N)).*BLPF./(GLPF_250+eps))));

%crop the image
devonvolution_GLPF_100 = devonvolution_GLPF_100_(1:M, 1:N);
devonvolution_GLPF_150 = devonvolution_GLPF_150_(1:M, 1:N);
devonvolution_GLPF_200 = devonvolution_GLPF_200_(1:M, 1:N);
devonvolution_GLPF_250 = devonvolution_GLPF_250_(1:M, 1:N);

%image histogram to determine the noise model
figure(1);
[pixelCount, grayLevels] = imhist(f);
bar(grayLevels, pixelCount);
xlim([-1 grayLevels(end)+1]);
title('Original image histgram',FontSize=24);
grid on;
img1 = getframe(gcf);
imwrite(img1.cdata, 'result/Original image histgram.png');

figure(2);
imshow(uint8(denoise_image));
img2 = getframe(gcf);
imwrite(img2.cdata, 'result/after_alpha_trim_filter_result.tiff', 'tiff', 'Resolution', 200);

figure(3)
imshow(uint8(devonvolution_GLPF_100));
img3 = getframe(gcf);
imwrite(img3.cdata, 'result/devonvolution_GLPF_100.tiff', 'tiff', 'Resolution', 200);

figure(4)
imshow(uint8(devonvolution_GLPF_150));
img4 = getframe(gcf);
imwrite(img4.cdata, 'result/devonvolution_GLPF_150.tiff', 'tiff', 'Resolution', 200);

figure(5)
imshow(uint8(devonvolution_GLPF_200));
img5 = getframe(gcf);
imwrite(img5.cdata, 'result/devonvolution_GLPF_200.tiff', 'tiff', 'Resolution', 200);

figure(6)
imshow(uint8(devonvolution_GLPF_250));
img6 = getframe(gcf);
imwrite(img6.cdata, 'result/devonvolution_GLPF_250.tiff', 'tiff', 'Resolution', 200);