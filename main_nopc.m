% Script to compare perfomance of classification methods given different
% number of PCA vectors for projection (no_vectors)

clear all
close all
clc

method_features = 'PCAs'; % options: 'intensity', 'PCA', 'PCAs', 'LDA'
no_vectors = 8;
no_remove = 0:7;

method_classification = {'knn','standardize'}; % options{1}: 'knn', 'svm', 'kmeans' | options{2}: 'standardize', 'nan'
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
score = zeros(1,length(no_vectors));
for j = 1:length(no_vectors)
    [ features_train, features_test ] = compute_features( images_train, images_test, labels_train, method_features, no_vectors(j), no_remove );
    display(strcat('Time to compute features = ',num2str(toc)))

    tic
    score(j) = classify( features_train, features_test, labels_train, labels_test, k, method_classification ); 
    display(strcat('Time to perform classification = ',num2str(toc)))

    disp(strcat('Computation complete! Performance score = ', num2str(score)));
    
end

figure(1)
plot(no_vectors,score,'-o')
ylabel('Performance score')
xlabel('Number of principal components (eigenvectors)')
title(strcat('Classification: ',method_classification{1},', Features: ',method_features,', ',method_classification{2}))
saveas(1,strcat('Plot_no_vectors_',method_classification{1},'_',method_features,'_',method_classification{2}),'png')