function [ reduced_images_train, reduced_images_test ] = projection( images_train, images_test, method )

% create covariance matrix
sigma = images_train * images_train';

% extract the k largest eigenvalues and the corresponding eigenvectors
[ eigvectors, eigvalues ] = eigs( sigma, k );

if (method==1)
    reduced_images_train = eigvectors' * images_train;
else
    reduced_images_train = eigvalues.^(-1/2) * eigvectors' * images_train;

    %reduced_images = flipud(reduced_images);
    %reduced_images = reduced_images(1:k,:);

    reduced_images_test = eigvalues.^(-1/2) * eigvectors' * images_test;
end



end