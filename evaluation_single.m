function [res, dh_CAP, dh_AMEF] = evaluation_single(gt, hz, clip_range, save, name)
    [x, y] = size(gt);
    image_size = string(x * y);

    gt_double = im2double(gt);
    hz_double = im2double(hz);
    
    mse_HAZY = immse(hz_double, gt_double);
    ssim_HAZY = ssim(hz_double, gt_double);

    start = tic;
    dh_CAP = cap(hz);
    end_CAP = toc(start);

    dh_CAP = im2double(dh_CAP);
    mse_CAP = immse(dh_CAP, gt_double);
    ssim_CAP = ssim(dh_CAP, gt_double);


    start = tic;
    [dh_AMEF, ~, ~] = amef(hz, clip_range);
    end_AMEF = toc(start);

    mse_AMEF = immse(dh_AMEF, gt_double);
    ssim_AMEF = ssim(dh_AMEF, gt_double);
    
    res = {"Name","Size","MSE_HAZY","SSIM_HAZY","MSE_AMEF","SSIM_AMEF","Time_AMEF","MSE_CAP","SSIM_CAP","Time_CAP";
            name, image_size, mse_HAZY, ssim_HAZY, mse_AMEF, ssim_AMEF, end_AMEF, mse_CAP, ssim_CAP, end_CAP};
    
    if(save)
        mkdir("./results/_single/" + name);
        imwrite(gt, ("./results/_single/" + name + "/_gt.jpg"));
        imwrite(hz, ("./results/_single/" + name + "/_hz.jpg"));
        imwrite(dh_CAP, ("./results/_single/" + name + "/CAP.jpg"));
        imwrite(dh_AMEF, ("./results/_single/" + name + "/AMEF.jpg"));
    end
end

% image = imread('images/CAFire.jpeg');
% 
% Icap = cap(image);
% Iamef = amef(image, 0.010);
% 
% subplot(1,3,1);
% imshow(image);
% subplot(1,3,2);
% imshow(Icap);
% subplot(1,3,3);
% imshow(Iamef);