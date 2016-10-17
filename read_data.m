function [images, labels] = read_data( size_train, size_test, digits )

	addpath('read')
	[I,labels,I_test,labels_test] = readMNIST(60000);

	images = zeros( 28*28, size_train );
	images_test = zeros( 28*28, size_test );

	for i = 1:size(I_test,2)
		images(:,1) = reshape(I_test{i},1,numel(I_test{i}));
		
		%if(labels_test(i)) is in digits
		%images(i,:) = reshape(I_test{i},1,numel(I_test{i}));
		
	end
end