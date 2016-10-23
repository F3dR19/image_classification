%% This is a script to  perform recognition (clustering) of images of digits
% It outputs a classification score (performance) and timings of different actions

clear all
close all
clc

%% Choose parameters
% Method of extracting features
method_features = 'PCA';   % options: 'intensity', 'PCA', 'PCAs', 'LDA'
% Additional method_features parameters (not needed for intensity)
no_vectors = 10;
no_remove = 0;

% Method of classification and standardization of computed features before classification
method_classification = {'knn','standardize'};  % options{1}: 'knn', 'svm', 'kmeans' | options{2}: 'standardize', 'nan'
% Additional method_classification parameters (needed for knn)
k = 10;

% Size of training and test sets, maximum of 60000 and 10000 respectively
size_train = 60000;
size_test = 100;

%% Main classification program
% Read data
tic
[ images_train, images_test, labels_train, labels_test ] = read_data( size_train,size_test );
display(strcat('Time to read data = ',num2str(toc)))

% Edit data
tic
[ images_train, images_test ] = edit_data( images_train,images_test );
display(strcat('Time to edit data = ',num2str(toc)))

% Compute image features
tic
[ features_train, features_test ] = compute_features( images_train, images_test, labels_train, method_features, no_vectors, no_remove );
display(strcat('Time to compute features = ',num2str(toc)))

% Classify images based on computed features
tic
score = classify( features_train, features_test, labels_train, labels_test, k, method_classification ); 
display(strcat('Time to perform classification = ',num2str(toc)))

% Print classification score
disp(strcat('Computation complete! Classification score = ', num2str(score)));