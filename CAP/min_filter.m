function [prior] = min_filter(image, min_filter_region)
    prior = image;
    sz = size(image);

    pad_prior = padarray(prior, [min_filter_region min_filter_region], 'both') ;
    for x = 1 : sz(1)
        for y = 1 : sz(2)
            current = prior(x, y);
            for x_region = (x - min_filter_region):(x + min_filter_region)
                for y_region = (y - min_filter_region):(y + min_filter_region)
                    current = min(current, pad_prior(x_region + min_filter_region, y_region + min_filter_region));
                end
            end
            prior(x, y) = current;

        end
    end
end