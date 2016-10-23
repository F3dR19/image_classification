%% Script to compare perfomance of knn classification method for different number of neighbours k
% Varying variable is input as a vector

clear all
close all
clc

%% Choose parameters
method_features = 'LDA'; % options: 'intensity', 'PCA', 'PCAs', 'LDA'
no_vectors = 10;
no_remove = 0;

method_classification = {'knn','standardize'};  % options{1}: 'knn', 'svm', 'kmeans' | options{2}: 'standardize', 'nan'
k = 1:40;

size_train = 60000;
size_test = 10000;

%% Main classification program
tic
[ images_train, images_test, labels_train, labels_test ] = read_data( size_train,size_test );
display(strcat('Time to read data = ',num2str(toc)))

tic
[ images_train, images_test ] = edit_data( images_train,images_test );
display(strcat('Time to edit data = ',num2str(toc)))

tic
score = zeros(1,length(k));
for j = 1:length(k)
    [ features_train, features_test ] = compute_features( images_train, images_test, labels_train, method_features, no_vectors, no_remove );
    display(strcat('Time to compute features = ',num2str(toc)))

    tic
    score(j) = classify( features_train, features_test, labels_train, labels_test, k(j), method_classification ); 
    display(strcat('Time to perform classification = ',num2str(toc)))

    disp(strcat('Computation complete! Performance score = ', num2str(score(j))));
    
end

%% Plot performance scores and save plot
figure(1)
plot(k,score,'-o')
ylabel('Performance score')
xlabel('k (number of neighbours)')
title(strcat('Classification: ',method_classification{1},', Features: ',method_features,', ',method_classification{2}))
saveas(1,strcat('Plot_k_',method_classification{1},'_',method_features,'_',method_classification{2}),'png')