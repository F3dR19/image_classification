clear all
close all
clc

size_train = 60000;
size_test = 10000;

[ images_train, images_test, labels_train, labels_test ] = read_data( size_train, size_test );



