function [ reduced_images_train, reduced_images_test ] = projection( images_train, images_test, k )

% create covariance matrix
sigma = images_train * images_train';

% extract the k largest eigenvalues and the corresponding eigenvectors
[ eigvectors, eigvalues ] = eigs( sigma, k );


%reduced_images = flipud(reduced_images);
%reduced_images = reduced_images(1:k,:);

reduced_images_test = eigvectors' * images_test;
reduced_images_train = eigvectors' * images_train;


%reduced_images_test = eigvalues.^(-1/2) * eigvectors' * images_test;
%reduced_images_train = eigvalues.^(-1/2) * eigvectors' * images_train;




end