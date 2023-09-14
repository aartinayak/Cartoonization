function  HW_04_Aarti_Nayak()

rgbImage = imread('/Users/aartinayak/Downloads/AartiNayak.jpg');

figure;

imshow(rgbImage); %The original image

grayscaleIm = rgb2gray(rgbImage); %Convert the image to gray scale image

gcanny_best = edge(grayscaleIm, [0.05, 0.11], 'canny'); %perform canny edge detection on the same.

x = gcanny_best;

figure;

imshow(x); %The edges of the image

wt = 1/20 ; % weight per pixel. 

numberOfClasses = 15; % number of image color clusters.

dims = size( rgbImage ); % get the size of the image.

Gfilt = fspecial( 'gauss', [6 6], 3 ); % create customized gaussian filter for noise removal.

rgbImage = imfilter( rgbImage, Gfilt, 'same', 'repl' ); % apply the filter on the image.

figure

imshow(rgbImage);

[xs, ys]     = meshgrid( 1:dims(2), 1:dims(1) ); %Allot the col and row values.


redChannel = rgbImage(:, :, 1); %Extract the red channel

greenChannel = rgbImage(:, :, 2); %Extract the green channel

blueChannel = rgbImage(:, :, 3); %Extract the blue channel

%Select the attributes needed
attributes  = [xs(:)*wt, ys(:)*wt, double(redChannel(:)), double(greenChannel(:)), double(blueChannel(:)) ];

[m, n] = kmeans(attributes,numberOfClasses); % Perform kmeans clustering

m = reshape(m,size(rgbImage,1),size(rgbImage,2)); %Since m is a 1D value, reshape it into a 2D matrix for the image

n=n/255; % fit the values between between 0 and 1

disp(n(:,3:end)); % Slice to extract the color channels.

clusteredIm = label2rgb(m,n(:,3:end)); %restore the rgb image.

figure;

imshow(clusteredIm); %color segmented image

clusteredIm = im2double(clusteredIm); %convert to double for subtraction

figure

imshow(clusteredIm - x); % superimpose edges and the image.

