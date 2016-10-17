function [ output_args ] = distance( reduced_images_test, reduced_images_train )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

n = size(reduced_images_train,2);
for j = 1:size(reduced_images_test,2)
	test_image = reduced_images_test(:,j);
	distances(j,:) = sum((reduced_images_train-repmat(test_image,1,n)).^2);
end
	
end

