clear
imageDatasets = dir('Datasets/Images');

[num, ~] = size(imageDatasets);

eval = fopen("./results/eval.csv", 'w');
fprintf(eval, 'Dataset,Filename,Method,MSE,SSIM\r\n');

for i = 3:num
    set_name = imageDatasets(i).name;
    dataset = dir(imageDatasets(i).folder + "/" + imageDatasets(i).name);

    if imageDatasets(i).name == "HTTS-RW" || ...
        imageDatasets(i).name == "OTS" || ...
        imageDatasets(i).name == "SOTS-IN" || ...
        imageDatasets(i).name == "SOTS-OUT" || ...
        imageDatasets(i).name == "RTTS"
        continue;
    end


    images_gt = dir(dataset(3).folder + "/" + dataset(3).name);
    images_hz = dir(dataset(4).folder + "/" + dataset(4).name);

    mkdir("./results/CAP/" + set_name)
    mkdir("./results/AMEF/" + set_name)

    for j = 3:3 %size(images_hz,1)
        gt = imread(images_gt(j).folder + "/" + images_gt(j).name);
        hz = imread(images_hz(j).folder + "/" + images_hz(j).name);
        
        gt_double = im2double(gt);

        [~, name, ~] = fileparts(images_gt(j).name);

        name = regexprep(name, ['_GT' '$'], '');

        dh_CAP = cap(hz);
        dh_CAP = im2double(dh_CAP);
        imwrite(dh_CAP, ("./results/CAP/" + set_name + "/" + name + "_dh.jpg"));
        mse_CAP = immse(dh_CAP, gt_double);
        ssim_CAP = ssim(dh_CAP, gt_double);
        
        dh_AMEF = amef(hz, 0.010);
        imwrite(dh_AMEF, ("./results/AMEF/" + set_name + "/" + name + "_dh.jpg"));
        mse_AMEF = immse(dh_AMEF, gt_double);
        ssim_AMEF = ssim(dh_AMEF, gt_double);
        
        fprintf(eval, '%s,%s,CAP,%f,%f\r\n',set_name, name, mse_CAP, ssim_CAP);
        fprintf(eval, '%s,%s,AMEF,%f,%f\r\n',set_name, name, mse_AMEF, ssim_AMEF);
        
        disp(name)
    end
end

fclose(eval);