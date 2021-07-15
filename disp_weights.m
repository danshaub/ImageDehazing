function [R, W, I] = disp_weights(I_hazy, I_gt, clip_range, file_name, show_figures)
    [R, W, I] = amef(I_hazy, clip_range);
    
    mkdir('./weights/' + file_name);
    imwrite(R, ("./weights/" + file_name + "/_dh.jpg"));
    imwrite(I_hazy, ("./weights/" + file_name + "/_hz.jpg"));
    imwrite(I_gt, ("./weights/" + file_name + "/_gt.jpg"));
    
    if(show_figures)
        name = "AMEF with clip range " + string(clip_range);
        figure('Name', name,'NumberTitle','off');

        subplot(1,3,1);
        imshow(I_hazy);
        title("Hazy");

        subplot(1,3,2);
        imshow(I_gt);
        title("Ground Truth");

        subplot(1,3,3);
        imshow(R);
        title("Dehazed");

        name = "Underexposed Images and weights with clip range " + string(clip_range);
        figure('Name', name,'NumberTitle','off');
    end
    
    for i = 1:6
        if(show_figures)
            subplot(2,3,i);
            montage({I(:,:,:,i), W(:,:,i)});
            title("XXX");
        end
        imwrite(I(:,:,:,i), ("./weights/" + file_name + "/u_" + string(i) + ".jpg"));
        imwrite(W(:,:,i), ("./weights/" + file_name + "/w_" + string(i) + ".jpg"));
    end
end