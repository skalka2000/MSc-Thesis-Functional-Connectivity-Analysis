function [trainData, testData] = split_train_test(data_matrix, train_ratio, seed)
% split_train_test Splits the dataset into training and testing sets.
% INPUT:
%   data_matrix: 2D matrix, each row is a subject, each column is a
%   feature.
%   train_ratio: proportion for training.
%   seed: random seed, ensures reproducibility.
% OUTPUT:
%   trainData: 2D matrix containing training data, each row is a subject, each column is a feature.
%   testData: 2D matrix containing testing data, each row is a subject, each column is a feature.
 
    % Ensure reproducibility
    rng(seed);
    
    % Get the number of observations
    n = size(data_matrix, 1);
    
    % Calculate number of training samples
    numTrain = round(n * train_ratio);
    
    % Randomly permute the indices and split
    permutedIndices = randperm(n);
    trainIndices = permutedIndices(1:numTrain);
    testIndices = permutedIndices(numTrain+1:end);
    
    % Partition the data
    trainData = data_matrix(trainIndices,:);
    testData = data_matrix(testIndices,:);
end