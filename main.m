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

[ neighbours, d ] = knnsearch(features_train', features_test','K',k,...
    'NSMethod','exhaustive','Distance','euclidean');

classifications = zeros(size_test,1);
for n = 1:size_test
    classifications(n) = mode(labels_train(neighbours(n,:)));
end

performance = sum(labels_test==classifications)/size_test
toc