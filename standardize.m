function [ features_train_out, features_test_out ] = standardize( features_train, features_test )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

mean_train = sum( features_train, 2 ) / size( features_train, 2 );
std_train = std( features_train, 0, 2 );
if (any(std_train==0))
    fprintf('Cannot standardize features. Zero standard deviation!')
    features_train_out = features_train;
    features_test_out = features_test;
else
    features_train_out = (features_train - repmat( mean_train, [ 1, size( features_train, 2 ) ] ))./...
        repmat( std_train, [ 1, size( features_train, 2 ) ] );    
    features_test_out = (features_test - repmat( mean_train, [ 1, size( features_test, 2 ) ] ))./...
        repmat( std_train, [ 1, size( features_test, 2 ) ] );
end


end
