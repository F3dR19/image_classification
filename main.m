clear all
close all
clc

size_train = 10;
size_test = 10;

[ images_train, images_test, labels_train, labels_test ] = read_data( size_train, size_test );

[ images_train, images_test ] = edit_data( images_train, images_test );

[ reduced_images_train, reduced_images_test ] = projection( images_train, images_test, 15 );

[ classifications ] = distance( reduced_images_test, reduced_images_train, labels_train, 10 );

[ score ] = classification_score( classifications, labels_test )

