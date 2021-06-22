function [Ig, Vr] = gradient_profile_prior(I)
    I = rgb2gray(I);
    [Ix, Iy] = imgradientxy(I);

    Ig = sqrt(Ix .^ 2 + Iy .^ 2);
    Vr = atand(Iy ./ Ix);
end