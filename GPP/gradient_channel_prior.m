function outputImage = gradient_channel_prior(I)
    [Ix, Iy] = imgradientxy(I, 'prewitt');

    gradientMag = sqrt(Ix .^ 2 + Iy .^ 2);
    gradientDir = atan(Iy ./ Ix);
    
    gradientDir(isnan(gradientDir)) = 0;
    
    %atan is undefined for elements where both Iy and Ix are 0, so it
    %doesn't particularly matter what it is, since the magnitude is 0.
    
    Vr = gradientDir; %how is Vr different from gradientDir?
    alpha = 0; %Alpha is the angle between Vr and gradientDir
    %outputImage = abs(Vr) .* abs(gradientMag) * cos(alpha) + I; %Inner product = dot product in standard euclidean space
    %Taking the inner product would make sense if Vr wasn't directly based
    %off of gradientMag
    outputImage = abs(gradientMag) + I; %Inner product = dot product in standard euclidean space
    %TODO: Fix NaN coming from somewhere, when Ix is 0 (atan of NaN is NaN)
end