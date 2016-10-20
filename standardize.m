function [ features_train_out, features_test_out ] = standardize( features_train, features_test )
% Standardizes (normalizes) train and test set of data given means and
% standard deviations of train data
%
% Input:
%   features_train = matrix of image features for train images
%   features_test = matric of image features for test images
%
% Output:
%   features_train_out = standardized features_train against train data
%   features_test_out = standardized features_test against train data
%

% Compute mean and standard deviation of rows of features_train
mean_train = sum( features_train, 2 ) / size( features_train, 2 );
std_train = std( features_train, 0, 2 );

% Standardize input matrices if possible, otherwise output input matrices
if (any(std_train==0))
    fprintf('Cannot standardize features. Zero standard deviation!\n')
    features_train_out = features_train;
    features_test_out = features_test;
else
    features_train_out = (features_train - repmat( mean_train, [ 1, size( features_train, 2 ) ] ))./...
        repmat( std_train, [ 1, size( features_train, 2 ) ] );    
    features_test_out = (features_test - repmat( mean_train, [ 1, size( features_test, 2 ) ] ))./...
        repmat( std_train, [ 1, size( features_test, 2 ) ] );
end


end

