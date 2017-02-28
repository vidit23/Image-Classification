%% This is the main code to classify an image into one of the nine categories

% Load Image Sets
rootFolder = fullfile(pwd, 'img/');

% Save all data
fileSave = 'imgHndFnt.mat';

% Construct an array of image sets based on the categories from the folder
imgSets = imageSet(fullfile(rootFolder), 'recursive');

% { imgSets.Description } % display all labels on one line
% [imgSets.Count]         % show the corresponding count of images

% Prepare Training and Validation Image Sets

% Each folder has different number of images, to equate all
minSetCount = min([imgSets.Count]); 
imgSets = partition(imgSets, minSetCount, 'randomize');

% Separate the sets into training and validation data.
[trainingSets, validationSets] = partition(imgSets, 0.7, 'randomize');

% Create a Visual Vocabulary and Train an Image Category Classifier
% Bag of features is a technique to use the bag of word model on images
% We use the surf feature extractor to get all the features
% We use top 1% of the strongest features and K-means clustering

bag = bagOfFeatures(trainingSets,'VocabularySize',100,'Verbose',true,'StrongestFeatures',0.01);

% We build a SVM classifier based on the bag of features
categoryClassifier = trainImageCategoryClassifier(trainingSets, bag);

% We evaluate the model using the validation set
confMatrixValidation = evaluate(categoryClassifier, validationSets);

% Compute average accuracy
errorVal = mean(diag(confMatrixValidation));

% To test the model we can give images
% Give the location of the image you want to classify in predictedImgPath

predictedImgPath = '/home/vidit/Features/IMG_6328.jpg';

% predictedImgPath = trainingSets(1, 2).ImageLocation{1, 1};
img = imread(predictedImgPath);
[labelIdx, scores] = predict(categoryClassifier, img);

% Display the string label
predictedLabel = categoryClassifier.Labels(labelIdx);

figure, imshow(img), title(predictedImgPath), text(size(img, 1)/2,size(img, 2)/2,predictedLabel, 'FontSize', 20, ...
    'Color', 'blue');

save(fileSave);