clear
imageDatasets = dir('Datasets/Images');

[num, ~] = size(imageDatasets);

d = string(datetime(now,'ConvertFrom','datenum'));
d = regexprep(d, ' |:|-', '_');

eval = fopen("./results/eval_" + d + ".csv", 'w');
fprintf(eval, 'Dataset,Filename,Size(Pixels),Method,MSE,SSIM,Time\r\n');

for i = 3:num
    set_name = imageDatasets(i).name;
    dataset = dir(imageDatasets(i).folder + "/" + imageDatasets(i).name);

    if imageDatasets(i).name == "HTTS-RW" || ...
        imageDatasets(i).name == "OTS" || ...
        imageDatasets(i).name == "SOTS-IN" || ...
        imageDatasets(i).name == "SOTS-OUT" || ...
        imageDatasets(i).name == "O-HAZY-NTIRE-2018" || ...
        imageDatasets(i).name == "I-HAZY-NTIRE-2018" || ...
        imageDatasets(i).name == "RTTS"
        continue;
    end


    images_gt = dir(dataset(3).folder + "/" + dataset(3).name);
    images_hz = dir(dataset(4).folder + "/" + dataset(4).name);

    mkdir("./results/CAP/" + set_name)
    mkdir("./results/AMEF/" + set_name)
    mkdir("./results/AMEF_MOD/" + set_name)

    
    total_ssim = 0;
    total_mse = 0;
    total_ssim_mod = 0;
    total_mse_mod = 0;
    num_images = 0;
    for j = 3:size(images_hz,1)
        gt = imread(images_gt(j).folder + "/" + images_gt(j).name);
        hz = imread(images_hz(j).folder + "/" + images_hz(j).name);
        
        [x, y] = size(gt);
        image_size = string(x * y);
        
        gt_double = im2double(gt);
        hz_double = im2double(hz);

        [~, name, ~] = fileparts(images_gt(j).name);

        name = regexprep(name, ['_GT' '$'], '');
        
        mse_HAZY = immse(hz_double, gt_double);
        ssim_HAZY = ssim(hz_double, gt_double);
        
        start = tic;
        dh_CAP = cap(hz);
        end_CAP = toc(start);
        
        dh_CAP = im2double(dh_CAP);
        imwrite(dh_CAP, ("./results/CAP/" + set_name + "/" + name + "_dh.jpg"));
        mse_CAP = immse(dh_CAP, gt_double);
        ssim_CAP = ssim(dh_CAP, gt_double);
        
        
        start = tic;
        [dh_AMEF, ~, ~] = amef(hz, 0.010);
        end_AMEF = toc(start);
        
        imwrite(dh_AMEF, ("./results/AMEF/" + set_name + "/" + name + "_dh.jpg"));
        mse_AMEF = immse(dh_AMEF, gt_double);
        ssim_AMEF = ssim(dh_AMEF, gt_double);
        
        total_ssim = total_ssim + ssim_AMEF;
        total_mse = total_mse + mse_AMEF;
        
        start = tic;
        [dh_AMEF_mod, W_NEW, ~] = amef_modified(hz, 0.010);
        end_AMEF_mod = toc(start);
        
        imwrite(dh_AMEF_mod, ("./results/AMEF_MOD/" + set_name + "/" + name + "_dh.jpg"));
        mse_AMEF_mod = immse(dh_AMEF_mod, gt_double);
        ssim_AMEF_mod = ssim(dh_AMEF_mod, gt_double);
        
        total_ssim_mod = total_ssim_mod + ssim_AMEF_mod;
        total_mse_mod = total_mse_mod + mse_AMEF_mod;
        
        num_images = num_images + 1;

        
        fprintf(eval, '%s,%s,%s,HAZY,%f,%f\r\n',set_name, name, image_size, mse_HAZY, ssim_HAZY);
        fprintf(eval, '%s,%s,%s,CAP,%f,%f,%f\r\n',set_name, name, image_size, mse_CAP, ssim_CAP, end_CAP);
        fprintf(eval, '%s,%s,%s,AMEF,%f,%f,%f\r\n',set_name, name, image_size, mse_AMEF, ssim_AMEF, end_AMEF);
        fprintf(eval, '%s,%s,%s,AMEF_MOD,%f,%f,%f\r\n',set_name, name, image_size, mse_AMEF_mod, ssim_AMEF_mod, end_AMEF_mod);
        disp(name)
    end
    avg_ssim = total_ssim/num_images;
    avg_mse = total_mse/num_images;
    avg_ssim_mod = total_ssim_mod/num_images;
    avg_mse_mod = total_mse_mod/num_images;
end

fclose(eval);