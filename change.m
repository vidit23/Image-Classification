%% This script is used to resize all the image in the nine folders
srcFiles = dir('/home/vidit/Features/img/WTB_Side/*.jpg');
for i = 1 : length(srcFiles)
  filename = strcat('/home/vidit/Features/img/WTB_Side/',srcFiles(i).name);
  I = imread(filename);
  
  % Reduce the size of the image using scale_factor
  scale_factor = 0.3; 
  image1 = imresize(I, scale_factor, 'bilinear');
  
  % Saving the image with the same name (Overwriting)
  imwrite(image1,filename);
end