function [ score ] = classify( features_train, features_test, labels_train, labels_test, k, method ) 
% Classifies test images and computes classification score
%
%
% Input:
% 	features_train = reduced train images (ie, projection on eigenvectors)
% 	features_test = reduced test images (ie, projection on eigenvectors)
% 	labels_train = ground truth (ie, the digit each train image is supposed to represent)
% 	labels_test = ground truth (ie, the digit each test image is supposed to represent)
% 	k =  number of closest neighbours to consider for classification
%
%	Output:
%		score = classification score:  number of hits / number of test images
%

if ( strcmp( method{2}, 'standardize' ) )
     % Standardize features in train & test sets
    [ features_train, features_test ] = standardize( features_train, features_test );
end

if ( strcmp( method{1}, 'knn' ) )
    % Search for the k closest neighbour (in euclidean sense)
    [ neighbours ] = knnsearch( features_train', features_test', 'K' , k,...
        'NSMethod', 'kdtree', 'Distance', 'euclidean' );

    % find the most recurring label of the closest neighbours (that's how the classification is done, basically)
    classifications = mode( labels_train( neighbours ), 2 );

    % score is evaluated as hit / total
    score = sum( classifications == labels_test ) / numel( classifications );
    
elseif ( strcmp( method{1}, 'svm' ) )
    % Fit SVM model
    SVMmodel = fitcecoc( features_train', labels_train' );
    
    % Predict classification with the model
    [ classifications, ~ ] = predict( SVMmodel, features_test' );
    
    % Evaluate score
    score = sum( classifications == labels_test ) / numel( classifications );

elseif ( strcmp( method{1}, 'kmeans' ) )
    % Digits to find
    numbers = unique( labels_train );

    % Number of clusters desired is the number of digits to find
    k = size( numbers, 1 );
    
    % Find centroids of clusters via k-mean algorithm
    [ classifications_train, centroids ] = kmeans( features_train' , k );
    
    % Find cluster labels (most frequent digits in the cluster)
    idx = classifications_train == 1:k;
    cluster_labels = zeros( 1, k );
    for l = 1:k
        cluster_labels( l ) = mode( labels_train( idx( :, l ) ) );
    end
    
    % Given cluster centroids find the nearest centroid for test images 
    [ neighbours ] = knnsearch( centroids, features_test', 'K', 1, ...
        'NSMethod', 'exhaustive', 'Distance', 'euclidean' );
    
    % Map each found cluster number (nearest neighbour) -> cluster label (digit)
    idx = neighbours == 1:k;
    classifications = neighbours;
    for l = 1:k
        classifications( idx( :,l ) ) = cluster_labels( l );
    end
    
    % Evaluate score by the proportion of correcty identified digits
    score = sum( classifications == labels_test ) / numel( classifications );

else
	
	error('classify:invalidMethod', 'Specified method not recognised / not supported. Abort');

end
    
end