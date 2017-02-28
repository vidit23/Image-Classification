%% To compare to images using matlab functions

I1 = rgb2gray(imread('/home/vidit/Features/img/New_Department/IMG_6286.jpg'));
I2 = rgb2gray(imread('/home/vidit/Features/img/New_Department/IMG_6287.jpg'));

points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);

[features1,valid_points1] = extractFeatures(I1,points1);
dataFeatures = length(features1);
[features2,valid_points2] = extractFeatures(I2,points2);
testFeatures = length(valid_points2);

indexPairs = matchFeatures(features1,features2);
z = length(matchedPoints2);
matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

disp('Total number of features in test image');
disp(testFeatures);
disp('Total number of features in data image');
disp(dataFeatures);
disp('Ratio');
disp(dataFeatures/testFeatures);

figure;
showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2, 'montage');


[pro2d, matchPoints1, matchPoints2] = estimateGeometricTransform(matchedPoints1, matchedPoints2,'projective', 'MaxDistance', 10.0);
figure;
showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2, 'montage');
