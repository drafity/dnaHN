clear all;
load '../data/Var_2class.mat'
total_error=[];

for t_it = 1:5
	clearvars -except t_it total_error train_x__ test_x__;
    rand('state',sum(100*clock))
    randn('state',sum(100*clock))
    %learning rate
    disp('Value of eta')
    eta = 0.1
    disp('Tthreshold value of the ratio of misclassified input patterns')
    threshold_epsilon = 0.1
    disp('Total epoch')
    n = 1000


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

    % Choose batch size and epochs.
    batchSize = 20;

    [hiddenWeights, outputWeights, error, correctlyClassified] = mod_trainStochasticSquaredErrorTwoLayerPerceptron(activationFunction, dActivationFunction, numberOfHiddenUnits, S, targetValues, n, batchSize, learningRate, S_t, label_t);

    % Choose decision rule.
    acc = correctlyClassified / size(test_x__,1);

    total_error = [total_error; acc];
end

sample_t_e_r = total_error(:,1:50:n);

x = 1:50:n;
t1 = shadedErrorBar(x,sample_t_e_r,{@mean,@std},'lineprops','-b','patchSaturation',0.33) %r
hold on;
h1 = plot(x, mean(sample_t_e_r),'b','LineWidth',2) %r

grid on;

xlabel('epoch')
ylabel('test accuracy')
legend(h1,'random weight NN')