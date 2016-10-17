function [ score ] = classification_score( classifications, labels )

score = sum( classifications == labels ) / numel( labels );


end