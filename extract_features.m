function [images_train, images_test] = edit_data( images_train_orig, images_test_orig k )

% CHECK THE NUMBER OF IMAGES! IF THEY ARE LESS THEN THE NUMBER OF PIXELS,
% THE WHOLE PROBLEM IS REVERSED!! (OVERFITTING)

% center images by subtracting average	
mean = sum( images_train_orig, 2 ) / size( images_train_orig, 2 );
images_train = images_train_orig - repmat( mean, [ 1, size( images_train_orig, 2 ) ] );

images_test = images_test_orig - repmat( mean, [ 1, size( images_test_orig, 2 ) ] );
	


end