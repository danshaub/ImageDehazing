clear

I = imread ('../images/98.bmp');
I = double(I) / 255;

[Ig, Vr] = gradient_profile_prior(I);

A = max(I, [], 3);

figure(1);
subplot(2,3,1);
imshow(I);
subplot(2,3,2);
imshow(Ig);
subplot(2,3,3);
imshow(A);

