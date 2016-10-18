function [ score ] = distance( reduced_images_train, reduced_images_test, labels_train, labels_test, k )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

size_train = size( reduced_images_train, 2 );
size_test = size( reduced_images_test, 2 );

% size = (number of test images x number of train images )
% for each test image, contains distance to each train image
distances = zeros( size_test, size_train );

for j = 1:size_test
	% extract current test image
	test_image = reduced_images_test( :, j );
	% evaluate euclidean distance squared
	distances( j, : ) = sum( ( reduced_images_train - ...
        repmat( test_image, [ 1, size_train ] ) ).^2 );
end

% order distances from closest to furthest 
[ ~, indices ] = sort( distances, 2, 'ascend' );
% extract the most frequent recurring (mode) label of the closest k images 
classifications = mode( labels_train( indices( :, 1:k ) ), 2 );
score = sum( classifications == labels_test ) / numel( classifications );

end

