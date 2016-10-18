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


classify( features_train, features_test, labels_train, labels_test, k ) 

toc