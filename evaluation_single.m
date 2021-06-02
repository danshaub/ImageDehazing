image = imread('images/CAFire.jpeg');

Icap = cap(image);
Iamef = amef(image, 0.010);

subplot(1,3,1);
imshow(image);
subplot(1,3,2);
imshow(Icap);
subplot(1,3,3);
imshow(Iamef);