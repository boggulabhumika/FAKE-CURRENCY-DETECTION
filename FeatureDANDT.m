%------------function for feature detection and extraction------
function S = FeatureDANDT(featureimg, handles)
%-----feature detection and extraction---------
global s
global feature_lst
feature_bw = rgb2gray(featureimg);
boxImage = histeq(feature_bw);

sceneImage = s;
%detect features
boxPoints = detectSURFFeatures(boxImage);
scenePoints = detectSURFFeatures(sceneImage);

[boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

boxPairs = matchFeatures(boxFeatures, sceneFeatures);


matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);
%figure;
%showMatchedFeatures(boxImage, sceneImage, matchedBoxPoints, ...
%    matchedScenePoints, 'montage');
%title('Putatively Matched Points (Including Outliers)');

[tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');

%figure;
%showMatchedFeatures(boxImage, sceneImage, inlierBoxPoints, ...
%    inlierScenePoints, 'montage');
%title('Matched Points (Inliers Only)');

boxPolygon = [1, 1;...                           % top-left
        size(boxImage, 2), 1;...                 % top-right
        size(boxImage, 2), size(boxImage, 1);... % bottom-right
        1, size(boxImage, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon
   
newBoxPolygon = transformPointsForward(tform, boxPolygon);

feature_lst = [feature_lst, newBoxPolygon];

%crop detected feature gandhi
xLeft = min(newBoxPolygon(:, 1));
xRight = max(newBoxPolygon(:, 1));
yTop = min(newBoxPolygon(:, 2));
yBottom = max(newBoxPolygon(:, 2));
height = abs(yBottom - yTop);
width = abs(xRight - xLeft);
S = imcrop(s, [xLeft, yTop, width, height]);