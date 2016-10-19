function [ score ] = classify( features_train, features_test, labels_train, labels_test, k ) 
% Classifies test images and computes classification score
%
%
% Input:
% 	features_train = reduced train images (ie, projection on eigenvectors)
% 	features_test = reduced test images (ie, projection on eigenvectors)
% 	labels_train = ground truth (ie, the digit each train image is supposed to represent)
% 	labels_test = ground truth (ie, the digit each test image is supposed to represent)
% 	k =  number of closest neighbours to consider for classification
%
%	Output:
%		score = classification score:  number of hits / number of test images
%

% Search for the k closest neighbour (in euclidean sense)
[ neighbours ] = knnsearch(features_train', features_test','K',k,...
    'NSMethod','kdtree','Distance','euclidean');

% find the most recurring label of the closest neighbours (that's how the classification is done, basically)
classifications = mode( labels_train( neighbours ), 2 );

% score is evaluated as hit / total
score = sum( classifications == labels_test ) / numel( classifications );

end