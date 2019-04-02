clear all;
load '../data/Var_2class.mat'
total_error=[];

for t_it = 1:1000
	clearvars -except t_it total_error train_x__ test_x__;
    rand('state',sum(100*clock))
    randn('state',sum(100*clock))
    %learning rate
    disp('Value of eta')
    eta = 0.1
    disp('Tthreshold value of the ratio of misclassified input patterns')
    threshold_epsilon = 0.1
    disp('Total epoch')
    n = 5

    instance_size = size(train_x__,2);
    class_size = 10;

    S = train_x__(:,1:instance_size-1)';
    label= train_x__(:,instance_size);

    S_t = test_x__(:,1:instance_size-1)';
    label_t= test_x__(:,instance_size);

    % Transform the labels to correct target values.
    targetValues = 0.*ones(10, size(label, 1));
    for idx = 1: size(label, 1)
        targetValues(label(idx) + 1, idx) = 1;
    end

    % Choose form of MLP:
    numberOfHiddenUnits = 200;

    % Choose appropriate parameters.
    learningRate = 0.1;

    % Choose activation function.
    activationFunction = @logisticSigmoid;
    dActivationFunction = @dLogisticSigmoid;

    % Choose batch size and epochs. Remember there are 60k input values.
    batchSize = 20;
    epochs = 1;

    for iter = 1 : n

    % fprintf('Train twolayer perceptron with %d hidden units.\n', numberOfHiddenUnits);
    % fprintf('Learning rate: %d.\n', learningRate);
    
    %change weight in trainStochasticSquaredErrorTwoLayerPerceptron
    %function
    [hiddenWeights, outputWeights, error] = trainStochasticSquaredErrorTwoLayerPerceptron(activationFunction, dActivationFunction, numberOfHiddenUnits, S, targetValues, iter, batchSize, learningRate);


    % Choose decision rule.

    [correctlyClassified, classificationErrors] = validateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, S_t, label_t);
    acc(iter) = correctlyClassified / size(test_x__,1);
end
    total_error = [total_error; acc];
end

a = mean(total_error);

H=errorbar(1:5,a,std(total_error),'r','LineWidth',2); 
hold on;
scatter(1:5,a,'r','LineWidth',2); 
grid on;
xlabel('epoch')
ylabel('test accuracy')
legend('random weight NN', '','0 weight NN','')

