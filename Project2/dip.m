clc;
clear;
close all;

filename = 'kid';
f = imread([filename,'.tif']);
[M, N] = size(f);

%(b)
F = fft2(double(f));
F_shift = fftshift(F);

%pading to avoid wraparound error
F_pad = fft2(double(f), 2*M, 2*N);
F_pad_shift = fftshift(F_pad);

%create Gaussian LPF and HPF
LPF = zeros(2*M,2*N);
D0 = 200;

for u = 1:2*M
    for v = 1:2*N
        D2 = (u-M)^2 + (v-N)^2;
        LPF(u,v) = exp(-1*D2/(2*D0*D0)); 
    end
end

HPF = 1 - LPF;

%Image pass LPF
G_LPF_shift = F_pad_shift .* LPF;
G_LPF = ifftshift(double(G_LPF_shift));
g_LPF = ifft2(double(G_LPF));
Re_g_LPF = real(g_LPF(1:M,1:N));


%Image pass HPF
G_HPF_shift = F_pad_shift .* HPF;
G_HPF = ifftshift(double(G_HPF_shift));
g_HPF = ifft2(double(G_HPF));
Re_g_HPF = real(g_HPF(1:M,1:N));

%get top25 abs(Fshift)
Abs_F_shift = abs(F_shift);
max_abs = zeros(25,1);
u = zeros(25,1);
v = zeros(25,1);
idx = 1;

while idx < 25
    sort_abs = sort(Abs_F_shift(:));
    max_value = max(sort_abs);
    [row,col] = find(Abs_F_shift == max_value);
    [length, a] = size(row);
    for j = 0:length - 1
        u(idx+j,1) = row(j+1,1) - 1;
        v(idx+j,1) = col(j+1,1) - 1;
        max_abs(idx+j,1) = max_value;
        Abs_F_shift(row(j+1,1),col(j+1,1)) = -inf;
    end
    idx = idx + length;
end

figure(1)
imshow(mat2gray(log10(1+ abs(F_shift))));
img1 = getimage(gcf);
imwrite(img1,['result/',filename,'_(600x600_DFT).tiff'], 'tiff', 'Resolution', 150)

figure(2)
imshow(LPF);
img2 = getimage(gcf);
imwrite(img2,['result/',filename,'_(1200x1200_LPF).tiff'], 'tiff', 'Resolution', 150)

figure(3)
imshow(HPF);
img3 = getimage(gcf);
imwrite(img3,['result/',filename,'_(1200x1200_HPF).tiff'], 'tiff', 'Resolution', 150)

figure(4)
imshow(mat2gray(Re_g_LPF));
img4 = getimage(gcf);
imwrite(img4,['result/',filename,'_(600x600_LPF_output).tiff'], 'tiff', 'Resolution', 150)

figure(5)
imshow(mat2gray(Re_g_HPF));
img5 = getimage(gcf);
imwrite(img5,['result/',filename,'_(600x600_HPF_output).tiff'], 'tiff', 'Resolution', 150)