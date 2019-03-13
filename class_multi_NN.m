clear all;
rand('state',sum(100*clock))
randn('state',sum(100*clock))
%learning rate
disp('Value of eta\n')
eta = 0.1;
disp('Tthreshold value of the ratio of misclassified input patterns \n')
threshold_epsilon = 0.1;
disp('Total iteration \n')
n = 5;
 

load './data/Var_2502_04.mat'

instance_size = size(train_x__,2);
class_size = 10;

S = train_x__(:,1:instance_size-1)';
label= train_x__(:,instance_size);

S_t = test_x__(:,1:instance_size-1)';
label_t= test_x__(:,instance_size);

% Transform the labels to correct target values.
targetValues = 0.*ones(10, size(label, 1));
for n = 1: size(label, 1)
    targetValues(label(n) + 1, n) = 1;
end
    
% Choose form of MLP:
numberOfHiddenUnits = 300;
    
% Choose appropriate parameters.
learningRate = 0.1;
    
% Choose activation function.
activationFunction = @logisticSigmoid;
dActivationFunction = @dLogisticSigmoid;
    
% Choose batch size and epochs. Remember there are 60k input values.
batchSize = 10;
epochs = 1;

for iter = 1 : 5
    
fprintf('Train twolayer perceptron with %d hidden units.\n', numberOfHiddenUnits);
fprintf('Learning rate: %d.\n', learningRate);
    
[hiddenWeights, outputWeights, error] = trainStochasticSquaredErrorTwoLayerPerceptron(activationFunction, dActivationFunction, numberOfHiddenUnits, S, targetValues, iter, batchSize, learningRate);
    
    
% Choose decision rule.
fprintf('Validation:\n');
    
[correctlyClassified, classificationErrors] = validateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, S_t, label_t);
    
fprintf('Classification errors: %d\n', classificationErrors);
fprintf('Correctly classified: %d\n', correctlyClassified);
acc(iter) = correctlyClassified / size(test_x__,1);
end

figure;
plot(1:5, acc,'ms-') 
