clc;
clear;
close all;

f = imread('fruit.tif');
[M, N] = size(f);
F = fft2(double(f));
F_shift = fftshift(F);

F_pad = fft2(double(f), 2*M, 2*N);
F_pad_shift = fftshift(F_pad);

LPF = zeros(2*M,2*N);
D0 = 200;

for u = 1:2*M
    for v = 1:2*N
        D2 = (u-M)^2 + (v-N)^2;
        LPF(u,v) = exp(-1*D2/(2*D0*D0)); 
    end
end

HPF = 1 - LPF;

G_LPF_shift = F_pad_shift .* LPF;
G_LPF = ifftshift(double(G_LPF_shift));
g_LPF = ifft2(double(G_LPF));
Re_g_LPF = real(g_LPF(1:M,1:N));

G_HPF_shift = F_pad_shift .* HPF;
G_HPF = ifftshift(double(G_HPF_shift));
g_HPF = ifft2(double(G_HPF));
Re_g_HPF = real(g_HPF(1:M,1:N));

figure(1)
imshow(mat2gray(log10(1+ abs(F_shift))));

figure(2)
imshow(LPF);

figure(3)
imshow(HPF);

figure(4)
imshow(mat2gray(Re_g_LPF));

figure(5)
imshow(mat2gray(Re_g_HPF));