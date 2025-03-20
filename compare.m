function compare(Ireal,Iscaned)
        I1=im2double(Ireal);
        I1 = rgb2gray(I1);
        I2=im2double(Iscaned);
        I2 = rgb2gray(Iscaned);
        corners1 = detectMSERFeatures(I1);
%         [features1, valid_corners1] = extractFeatures(I1, corners);
%         figure; imshow(I1); hold on
%         plot(valid_corners1);
        c=length(corners1)
        corners2 = detectMSERFeatures(I2);
%         [features1, valid_corners2] = extractFeatures(I2, corners);
%         figure; imshow(I2); hold on
%         plot(valid_corners2);
        d=length(corners2)
        t=0.75*c
        if(d>t)
            h=msgbox("The note is Real")
        else
            h=msgbox("The note is fake")
        end
 