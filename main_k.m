k = 1:40;
no_vectors = 10;
no_remove = 0;
method = 2;
size_train = 60000;
size_test = 10000;

tic
[ images_train, images_test, labels_train, labels_test ] = read_data( size_train,size_test );
display(strcat('Time to read data = ',num2str(toc)))

tic
[ images_train, images_test ] = edit_data( images_train,images_test );
display(strcat('Time to edit data = ',num2str(toc)))

tic
score = zeros(1,length(k));
for j = 1:length(k)
    [ features_train, features_test ] = compute_features( images_train, images_test, method, no_vectors, no_remove );
    display(strcat('Time to compute features = ',num2str(toc)))

    tic
    score(j) = classify( features_train, features_test, labels_train, labels_test, k(j) ); 
    display(strcat('Time to perform classification = ',num2str(toc)))

    disp(strcat('Computation complete! Performance score = ', num2str(score)));
    
end

figure(1)
plot(k,score,'-o')
ylabel('Performance score')
xlabel('k (number of neighbours)')
