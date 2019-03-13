clear all;
load './HN_result/class2_error_5.mat'
hn_c2e5 =lol;
load './HN_result/class10_error_5.mat'
hn_c10e5 = lol;

load './NN_result/class2_0weight_error_5.mat'
nn_c2w0e5 = acc;
load './NN_result/class2_rand_weight_error_5.mat'
nn_c2wre5 = acc;
load './NN_result/class10_0weight_error_5.mat'
nn_c10w0e5 = acc;
load './NN_result/class10_randweight_error_5.mat'
nn_c10wre5 = acc;


load './pt_result/class2_0weight_error_5.mat'
pt_c2w0e5 = error;
load './pt_result/class2_randweight_error_5.mat'
pt_c2wre5 = error;
load './pt_result/class10_0weight_error_5.mat'
pt_c10w0e5 = error;
load './pt_result/class10_randweight_error_5.mat'
pt_c10wre5 = error;


figure; hold on;
grid on;
grid minor;

plot(hn_c2e5(:,2),'-+b','MarkerSize',10, 'LineWidth',2);
plot(hn_c2e5(:,1),'-+r','MarkerSize',10, 'LineWidth',2);
plot(nn_c2w0e5, '--og','MarkerSize',10, 'LineWidth',2);
plot(nn_c2wre5, '--ok','MarkerSize',10, 'LineWidth',2);
plot(pt_c2w0e5, '-.xc','MarkerSize',10, 'LineWidth',2);
plot(pt_c2wre5, '-.xm','MarkerSize',10, 'LineWidth',2);

xlabel('epoch')
ylabel('test accuracy')
legend('ensemble HN','single HN','0 weight NN', 'random weight NN','0 weight Perceptron','random weight Perceptron')
title('2-Class Performance','FontSize',18);

figure; hold on;
grid on;
grid minor;
plot(hn_c10e5(:,2),'-+b','MarkerSize',10, 'LineWidth',2);
plot(hn_c10e5(:,1),'-+r','MarkerSize',10, 'LineWidth',2);
plot(nn_c10w0e5, '--og','MarkerSize',10, 'LineWidth',2);
plot(nn_c10wre5, '--ok','MarkerSize',10, 'LineWidth',2);
plot(pt_c10w0e5, '-.xc','MarkerSize',10, 'LineWidth',2);
plot(pt_c10wre5, '-.xm','MarkerSize',10, 'LineWidth',2);
xlabel('epoch')
ylabel('test accuracy')
legend('ensemble HN','single HN','0 weight NN', 'random weight NN','0 weight Perceptron','random weight Perceptron')
title('10-Class Performance','FontSize',18);
