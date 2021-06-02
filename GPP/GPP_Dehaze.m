clear

I = imread ('../images/test.png');
I = rgb2gray(I);
I = double(I) / 255;

[Ig, Vr] = gradient_profile_prior(I);

gamma = 

figure(1);
subplot(2,1,1);
imshow(Ig);
subplot(2,1,2);
imshow(Vr);
