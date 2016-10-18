function [ score ] = classify( features_train, features_test, labels_train, labels_test, k ) 

[ neighbours ] = knnsearch(features_train', features_test','K',k,...
    'NSMethod','kdtree','Distance','euclidean');


classifications = mode( labels_train( neighbours ), 2 );

score = sum( classifications == labels_test ) / numel( classifications );

end