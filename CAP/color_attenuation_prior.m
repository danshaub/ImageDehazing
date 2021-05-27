image = imread ('../images/CAFire.jpeg');
grayscale = double(rgb2gray(image))/255;

hsv_image = rgb2hsv(image);

[sizex, sizey] = size(image);


theta_0 = 0.121779;
theta_1 = 0.959710;
theta_2 = -0.780245;
deviation = 0.041337;

depth = theta_0 + theta_1 * grayscale + theta_2 * hsv_image(:, :, 2);
imshow(depth);
figure;

t_min = min(max(exp(-depth) * .9, .1 ), .9);

image_scaled = double(image) / 255.0 ;


fuzzed_depth = min_filter(depth, 10);
order_depth = sort(fuzzed_depth(:), 'descend');
min_range = min(order_depth(1 : int64((sizex * sizey) * .001)));
A = max(max((fuzzed_depth > min_range) .* grayscale));

fprintf('Attenuation:%d \n' , A)

for i = 1:3
    image_scaled(:, :, i) = ((image_scaled(:, :, i) - A) ./ t_min) + A;
end

subplot(1, 2, 1)
imshow(image);
subplot(1, 2, 2);
imshow(uint8(image_scaled * 255));


