clear all
close all
clc

method_features = 'intensity'; % options: 'intensity', 'PCA', 'PCAs', 'LDA'
no_vectors = 11;
no_remove = 0;
method_classification = {'kmeans','standardize'}; % options{1}: 'knn', 'svm', 'kmeans'
                                                  % options{2}: 'standardize', 'nan'
k = 7;
size_train = 60000;
size_test = 10000;

tic
[ images_train, images_test, labels_train, labels_test ] = read_data( size_train,size_test );
display(strcat('Time to read data = ',num2str(toc)))

tic
[ images_train, images_test ] = edit_data( images_train,images_test );
display(strcat('Time to edit data = ',num2str(toc)))

tic
[ features_train, features_test ] = compute_features( images_train, images_test, labels_test, method_features, no_vectors, no_remove );
display(strcat('Time to compute features = ',num2str(toc)))

tic
score = classify( features_train, features_test, labels_train, labels_test, k, method_classification ); 
display(strcat('Time to perform classification = ',num2str(toc)))

disp(strcat('Computation complete! Classification score = ', num2str(score)));