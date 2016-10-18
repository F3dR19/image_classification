function [images_train, images_test] = edit_data( images_train_orig, images_test_orig )
% Readjusts data by centering them
%	
%	Input:
%		- images_train_orig = original matrix containing train images
%		- images_test_orig = original matrix containing test images
%
% Output:
%		- images_train = matrix containing zero-averaged train images 
%		- images_test = matrix containing zero-averaged test images (average of train data taken) 

% center images by subtracting average	
mean = sum( images_train_orig, 2 ) / size( images_train_orig, 2 );

images_train = double( images_train_orig ) - mean( :, ones( 1, size( images_train_orig, 2 ) ) );

%images_train = images_train_orig - repmat( mean, [ 1, size( images_train_orig, 2 ) ] );

% center test data with train means
images_test = double( images_test_orig ) - mean( :, ones( 1, size( images_test_orig, 2 ) ) );
%images_test = images_test_orig - repmat( mean, [ 1, size( images_test_orig, 2 ) ] );	


end