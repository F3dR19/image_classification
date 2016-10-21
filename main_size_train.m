clear all
close all
clc

k = 7;
no_vectors = 11;
no_remove = 0;
method_features = 2;
method_classification = 'svm';
size_train = 100*(8:25);
size_test = 10000;

figure(1)
hold on
for seed = 1:6
    rng(seed)
    tic
    score = zeros(1,length(size_train));
    for j = 1:length(size_train)
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
