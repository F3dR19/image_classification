function [ reduced_images_train, reduced_images_test ] = compute_features( images_train, images_test, method, k, j )

if (method==2)
    % create covariance matrix
    sigma = images_train * images_train';

    % extract the k largest eigenvalues and the corresponding eigenvectors
    [ eigvectors, ~ ] = eigs( sigma, k+j );
    
    reduced_images_train = eigvectors' * images_train;
    reduced_images_test = eigvectors' * images_test;
    
elseif (method==3)
    % create covariance matrix
    sigma = images_train * images_train';
    
    % extract the k largest eigenvalues and the corresponding eigenvectors
    [ eigvectors, eigvalues ] = eigs( sigma, k+j );
    
    % remove first few
    eigvectors_rem = eigvectors(:,(1:k)+j);
    eigvalues_rem = eigvalues(:,(1:k)+j);
    
    reduced_images_train = eigvalues_rem.^(-1/2) * eigvectors_rem' * images_train;
    %reduced_images = flipud(reduced_images);
    %reduced_images = reduced_images(1:k,:);
    reduced_images_test = eigvalues_rem.^(-1/2) * eigvectors_rem' * images_test;
else
    reduced_images_train = images_train;
    reduced_images_test = images_test;
end

end