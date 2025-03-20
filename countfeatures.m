
I1=im2double(Ireal);
I1 = rgb2gray(I1);
I2=im2double(Iscan);
I2 = rgb2gray(Iscan);
corners = detectMSERFeatures(I1);
  [features1, valid_corners1] = extractFeatures(I1, corners);
  figure; imshow(I1); hold on
  plot(valid_corners1);
  c=length(corners)
 