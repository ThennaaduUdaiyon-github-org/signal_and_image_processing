clc; clear all; close all;

% Image without missing portions
img_clean = imread('Deepam_bw.jpg');

img_mask = imread('scribble.png');

figure
imshow(img_clean)
title('Original image')

figure 
imshow(img_mask)
title('Mask to be added')

% Applying the mask to the image 
[u,mask,input] = create_image_and_mask(img_clean, img_mask);

figure
imshow(u)

% Parameters for Inpainting 
lambda        = 10;
tol           = 1e-5;
maxiter       = 500;
dt            = 0.1;

% Calling the inpainting function ...
tic
inpainting_harmonic(u,mask,lambda,tol,maxiter,dt);
toc


