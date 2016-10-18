function [ images_train, images_test, labels_train, labels_test ] = read_data( size_train, size_test )
% Picks images for training and testing
%
% Input:
%		size_train = Number of images to pick for training
%		size_test = Number of images to pick for testing
% 
% Output:
%		images_train = matrix with a train image in each column
%		images_test = matrix with a test image in each column
%		labels_train = labels for train images (the digit they represent)
%		labels_test = labels for test images (the digit they represent)
%


% Check of inputs:
if( size_train > 60000 )
	size_train = 60000;
	disp('Warning: a maximum of 60000 images are available for training. Size scaled accordingly')
end

if( size_test > 10000 )
	size_test = 10000;
	disp('Warning: a maximum of 10000 images are available for testing. Size scaled accordingly')
end

% convert data from bits to some meaningful format
addpath( 'read' )
[ I, labels_train, I_test, labels_test ] = readMNIST( 60000, 10000 );

% initialise matrices
images_train = zeros( 28*28, size_train );
images_test = zeros( 28*28, size_test );

% compute permutation of data (so to pick images randomly)
perm_train = randperm( 60000, size_train );
perm_test = randperm( 10000, size_test );


% collect data and store them in matrices
for i = 1:size_train
	images_train( :, i ) = reshape( I{ perm_train(i) }, 1, numel(I{ perm_train(i) }) );
end

for i = 1:size_test
	images_test( :, i ) = reshape( I_test{ perm_test(i) }, 1, numel(I_test{ perm_test(i) }) );	
end

% adjust the labels with the permutations
labels_train = labels_train( perm_train );
labels_test = labels_test( perm_test );


end