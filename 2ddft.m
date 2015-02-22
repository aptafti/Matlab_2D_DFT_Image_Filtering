% *************************************
% Image Processing
% Project Title : 2D DFT in Image Filtering
% Student      : Ahmad Pahlavan Tafti
%  *************************************


close all;
clear all;
clc;

% Initialization & Variables Declaration 
image = imread('test-img.pgm');
orgimage  = image;
[rows columns] = size(orgimage);
M = 2*rows+1; 
N = 2*columns+1; 
imgmultiply = zeros(M,N);
Preal = zeros(M,N);   
Pimg = zeros(M,N);    
orgimage_real = zeros(M,N);
filteredimg = zeros(rows,columns);
F = zeros(M,N);  
D0 = 300;
P = fix(M/2); 
Q = fix(N/2);

% Zero Padding
orgimage(rows:M,columns:N) = 0; 
 
% Multiply Original Image by (-1)^(x+y)
 for x = 1:M
    for y = 1:N
        imgmultiply(x,y) = (-1)^(x+y)*orgimage(x,y);
    end
 end
orgimage = imgmultiply;
 
 % Computing DFT For Rows And Columns
 tic;
 for  y = 1:N   
        for  u = 1:M
            Preal(u,y) = 0; 
            Pimg(u,y) = 0;  
            for  x = 1:M
                    Preal(u,y) = orgimage(x, y)*cos((2 * pi * u * x)/M)+ Preal(u,y);
                    Pimg(u,y) = (-1)*orgimage(x,y)*sin((2 * pi * u * x)/M)+ Pimg(u,y);                 
            end 
        end 
 end
orgimage = Preal + i*Pimg;  
 for  x = 1:M    
        for  v = 1:N
            Preal(x,v) = 0; 
            Pimg(x,v) = 0; 
            for  y = 1:N
                    Preal(x,v) = orgimage(x, y)*cos((2 * pi * v * y)/N)+ Preal(x,v);
                    Pimg(x,v) = (-1)*orgimage(x,y)*sin((2 * pi * v * y)/N)+ Pimg(x,v);                                       
            end 
        end 
  end
orgimage = Preal + i*Pimg;  
fprintf('DFT is Terminated Now!\n');
fprintf('Elapsed Time for DFT = %d Sec.\n', toc);
for u = 1:M
    for v = 1:N
        D = sqrt((u-P)^2+(v-Q)^2);  
        if D <= D0
            H = 1;
        else 
            H = 0;
        end
        F(u,v) = H*orgimage(u,v);           
        
    end
 end
F = real(F);            

% Computing Inverse DFT For Rows And Columns
tic; 
for  y = 1:N   
        for  u = 1:M
            orgimage_real(u,y) = 0;           
            for  x = 1:M
                    orgimage_real(u,y) = F(x, y)*cos((2 * pi * u * x)/M)+ orgimage_real(u,y);
            end 
        end 
end
F = orgimage_real;
for  x = 1:M    
      for  v = 1:N
          orgimage_real(x,v) = 0;         
          for  y = 1:N
                  orgimage_real(x,v) = F(x,y)*cos((2 * pi * v * y)/N)+ orgimage_real(x,v);                                    
           end 
      end 
        
end
orgimage_real = orgimage_real/(M*N);
fprintf('Inverse DFT is Terminated Now!\n');
fprintf('Elapsed Time for Inverse DFT = %d Sec.\n', toc);  
filteredimg(1:rows, 1:columns)= orgimage_real(1:rows, 1:columns);  
figure('Name','2D DFT in Image Filtering','NumberTitle','off'),
subplot(1,2,1), imshow(image), title('Original Image'),
subplot(1,2,2), imshow(filteredimg, []), title ('Filtered Image');
