# Matlab_2D_DFT_Image_Filtering
A discrete Fourier transform F(u, v) of an input image f(x, y) implementation in Matlab. 
In this project, we were asked to implement the discrete Fourier transform F(u, v) of 
an input image f(x, y) of size M*N and then apply the ideal low pass filter H(u, v) 
to smoothing the image. Firts we needed to zero-pad our original image to generate a 
new image of size P*Q, where P=2M-1 and Q=2N-1, multiply the original image by (-1)^(x+y) 
so that the low frequency of F(u, v) is centered at the center of our domain. This repository 
includes the source code (Matlab) of the project.
