clear all
close all
clc

k = 10; no_vectors = 10; j = 4;
method = 2;
size_train = 60000;
size_test = 10000;

[ images_train, images_test, labels_train, labels_test ] = read_data(size_train,size_test);

[ images_train, images_test ] = edit_data(images_train,images_test);
tic
[ features_train, features_test ] = compute_features(images_train, images_test, method, no_vectors, j);

[ neighbours ] = knnsearch(features_train', features_test','K',k,...
    'NSMethod','kdtree','Distance','euclidean');

classifications  = mode(reshape(labels_train(neighbours(:)),size(neighbours)),2);

performance = sum(labels_test==classifications)/size_test
toc