I = imread ('1381.jpg');
I = double(I) / 255;

%Evaluate gradient profile prior
gradientImage = gradient_channel_prior(rgb2gray(I));

%TODO: Atmospheric light estimation
atmosphericLight = max(I, [], 3); %NOTE: This isn't quite the actual estimation, but it's something to build off of

%TODO: Transmission map estimation
beta = .5;
Temp = gradient_channel_prior(rgb2gray(I)./atmosphericLight);
transmissionMap = 1 - beta * Temp; %Equation 19

%TODO: Clean up Transmission map with Guided L-0 based image filter
% lambda = 0.0002;
% B = lambda * 2;
% BMax = 105;
% k = 2;
% 
% while(B < BMax) %Deviation from their formalized algorithm because as written it wouldn't do anything
%     [Tx, Ty] = imgradientxy(transmissionMap, 'prewitt');
%     TMag = sqrt(Tx.^2 + Ty.^2);
%     if(TMag <= lambda/B)
%         deltak = 0;
%     else
%         deltak = TMag;
%     end
%    
%     %TODO: Calculate T(k+1) given T and deltak
%     
%     %TODO: Calculate T~(k+1) given T~ and deltak
%     
% end


%TODO: Apply modified restoration model given atmospheric light and
%transmission to calculate final image

finalImage = ((I - atmosphericLight)./transmissionMap) + atmosphericLight;

colormap(gray);
figure(1);
subplot(2,3,1);
imshow(I);
subplot(2,3,2);
imshow(gradientImage);
subplot(2,3,3);
imshow(atmosphericLight);
subplot(2,3,4);
imagesc(transmissionMap);

subplot(2,3,6);
imshow(finalImage);

