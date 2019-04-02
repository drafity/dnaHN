clear all;
load '../data/Var_2502_04.mat'
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

    W = zeros(class_size,instance_size-1);
    x=zeros(instance_size-1,1);
    D=zeros(class_size,n);
    d=zeros(class_size,1);

    % Initialize Weights
    for i= 1:class_size
        for j=1:instance_size-1
            W(i,j)= rand(); % weight change to 0 or rand()
        end
    end
    for j=1:n
        D(label(j)+1,j)=1;
    end


    %weight update
    for iter=1:n
            t_sample = randi(size(label,1));  
            x=S(:,t_sample);
            v_bar=W*x; %answer prediction
            p=v_bar;
            %diff= D(:,k)-p'
            %prod=diff*x';
            %W=W+(eta*prod);
            W= W+ eta.*(D(:,iter)-p)*x';

        error(iter)=0;
        %error=0;
        for k=1:size(test_x__,1)
            x_t=S_t(:,k);
            v=W*x_t;
            [maximum, index]=max(v);
            corres_num=index-1;
            if (label_t(k)==corres_num)
                error(iter)=error(iter)+1;            
            end
        end
        error(iter) = error(iter) / size(test_x__,1);
    end

    total_error = [total_error; error];
end

a = mean(total_error);

H=errorbar(1:5,a,std(total_error),'r','LineWidth',2); % 0
hold on;
scatter(1:5,a,'r','LineWidth',2); %0
grid on;

xlabel('epoch')
ylabel('test accuracy')
legend('random weight Perceptron', '','0 weight Perceptron','')

