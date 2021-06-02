clear
listing_gt = dir('Dense_Haze_NTIRE19/GT');
listing_hz = dir('Dense_Haze_NTIRE19/hazy');

[num, ~] = size(listing_gt);
num = num - 2;
sqr = 2; %ceil(sqrt(num/2));

% figure(1);
% for i = 3:6
%    img = imread(listing_gt(i).folder + "\" + listing_gt(i).name);
%    subplot(sqr, sqr, i-2);
%    imshow(img);
% end
% 
% figure(2);
% for i = 3:6
%    img = imread(listing_hz(i).folder + "\" + listing_hz(i).name);
%    subplot(sqr, sqr, i-2);
%    imshow(img);
% end
% 
% figure(3);
% for i = 3:6
%    img = imread(listing_hz(i).folder + "\" + listing_hz(i).name);
%    
%    img = cap(img);
%    
%    subplot(sqr, sqr, i-2);
%    imshow(img);
% end

figure(4);
for i = 3:6
   img = imread(listing_hz(i).folder + "\" + listing_hz(i).name);
   
   img = amef(img, 0.030);
   
   subplot(sqr, sqr, i-2);
   imshow(img);
end



% Icap = cap(image);
% Iamef = amef(image, 0.010);
% 
% subplot(1,3,1);
% imshow(image);
% subplot(1,3,2);
% imshow(Icap);
% subplot(1,3,3);
% imshow(Iamef);