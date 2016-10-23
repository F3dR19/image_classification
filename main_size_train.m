%% Script to compare perfomance of classification methods given different number of training images
% The script is run for different seeds
% Varying variable is input as a vector

clear all
close all
clc

%% Choose parameters
method_features = 'PCA'; % options: 'intensity', 'PCA', 'PCAs', 'LDA'
no_vectors = 11;
no_remove = 0;

method_classification = {'svm','standardize'}; % options{1}: 'knn', 'svm', 'kmeans' | options{2}: 'standardize', 'nan'
k = 7;

size_train = 100*(8:25);
size_test = 10000;

%% Main classification program with plotting
figure(1)
hold on
for seed = 1:6
		%initialize different seeds for random number generators, so to have
		%different choices of test images
    rng(seed)
    score = zeros(1,length(size_train));
    for j = 1:length(size_train)
				disp(strcat('####--Test with j=',num2str(j),' number of test images--####'))
				tic
				[ images_train, images_test, labels_train, labels_test ] = read_data( size_train(j),size_test );
        display(strcat('Time to read data = ',num2str(toc)))

        tic
        [ images_train, images_test ] = edit_data( images_train,images_test );
        display(strcat('Time to edit data = ',num2str(toc)))

        tic
        [ features_train, features_test ] = compute_features( images_train, images_test, labels_train, method_features, no_vectors, no_remove );
        display(strcat('Time to compute features = ',num2str(toc)))

        tic
        score(j) = classify( features_train, features_test, labels_train, labels_test, k, method_classification ); 
        display(strcat('Time to perform classification = ',num2str(toc)))

        disp(strcat('Computation complete! Classification score = ', num2str(score(j))));
    end

    plot(size_train,score,'-o')
end
hold off
ylabel('Performance score')
xlabel('Size of train set')
title(strcat('Classification: ',method_classification{1},', Features: ',method_features,', ',method_classification{2}))

% Save plot
saveas(1,strcat('Plot_size_train_',method_classification{1},'_',method_features,'_',method_classification{2}),'png')