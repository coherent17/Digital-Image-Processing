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
GLPF_100 = zeros(M,N);
GLPF_150 = zeros(M,N);
GLPF_200 = zeros(M,N);
GLPF_250 = zeros(M,N);

BLPF_100_3 = zeros(M,N);
BLPF_150_3 = zeros(M,N);
BLPF_200_3 = zeros(M,N);
BLPF_250_3 = zeros(M,N);

for u = 1:M
    for v = 1:N
        D2 = (u-M/2)^2 + (v-N/2)^2;
        GLPF_100(u,v) = exp(-1*D2/(2*100*100)); 
        GLPF_150(u,v) = exp(-1*D2/(2*150*150)); 
        GLPF_200(u,v) = exp(-1*D2/(2*200*200)); 
        GLPF_250(u,v) = exp(-1*D2/(2*250*250)); 
        BLPF_100_3(u,v) = 1/(1+0.6*(D2/(100*100))^2);
        BLPF_150_3(u,v) = 1/(1+0.6*(D2/(150*150))^2);
        BLPF_200_3(u,v) = 1/(1+0.6*(D2/(200*200))^2);
        BLPF_250_3(u,v) = 1/(1+0.6*(D2/(250*250))^2);
    end
end

%image pass inverse filter
threshold = 0.1;    %deal with divide by zero
devonvolution_GLPF_100 = ifft2(ifftshift(fftshift(fft2(denoise_image))./(GLPF_100+threshold)));
devonvolution_GLPF_150 = ifft2(ifftshift(fftshift(fft2(denoise_image))./(GLPF_150+threshold)));
devonvolution_GLPF_200 = ifft2(ifftshift(fftshift(fft2(denoise_image))./(GLPF_200+threshold)));
devonvolution_GLPF_250 = ifft2(ifftshift(fftshift(fft2(denoise_image))./(GLPF_250+threshold)));

devonvolution_BLPF_100 = ifft2(ifftshift(fftshift(fft2(denoise_image))./(BLPF_100_3+threshold)));
devonvolution_BLPF_150 = ifft2(ifftshift(fftshift(fft2(denoise_image))./(BLPF_150_3+threshold)));
devonvolution_BLPF_200 = ifft2(ifftshift(fftshift(fft2(denoise_image))./(BLPF_200_3+threshold)));
devonvolution_BLPF_250 = ifft2(ifftshift(fftshift(fft2(denoise_image))./(BLPF_250_3+threshold)));

%original image
figure(1);
imshow(f);

%image histogram to determine the noise model
figure(2);
[pixelCount, grayLevels] = imhist(f);
bar(grayLevels, pixelCount);
grid on;
xlim([-1 grayLevels(end)+1]);

figure(3);
imshow(uint8(denoise_image));

figure(4)
subplot(2,4,1)
imshow(uint8(real(devonvolution_GLPF_100)));

subplot(2,4,2)
imshow(uint8(real(devonvolution_GLPF_150)));

subplot(2,4,3)
imshow(uint8(real(devonvolution_GLPF_200)));

subplot(2,4,4)
imshow(uint8(real(devonvolution_GLPF_250)));

subplot(2,4,5)
imshow(uint8(real(devonvolution_BLPF_100)));

subplot(2,4,6)
imshow(uint8(real(devonvolution_BLPF_150)));

subplot(2,4,7)
imshow(uint8(real(devonvolution_BLPF_200)));

subplot(2,4,8)
imshow(uint8(real(devonvolution_BLPF_250)));