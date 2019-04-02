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
    n = 10000
    

    instance_size = size(train_x__,2);
    class_size = 2;

    S = train_x__(:,1:instance_size-1)';
    label= train_x__(:,instance_size);

    S_t = test_x__(:,1:instance_size-1)';
    label_t= test_x__(:,instance_size);


    W = zeros(class_size,instance_size-1);
    x=zeros(instance_size-1,1);
    D=zeros(class_size,n);
    d=zeros(class_size,1);

    if class_size == 2
        min_val = min(label);
        max_val = max(label);

        for iter = 1:size(label,1)
            if (label(iter) == min_val)
                label(iter) = 0;
            else
                label(iter) = 1;
            end
        end
        for iter = 1:size(label_t,1)
            if (label_t(iter) == min_val)
                    label_t(iter) = 0;
                else
                    label_t(iter) = 1;
            end
        end
    end



    % Initialize Weights W ¢æ R10 x feature size randomly 
    for i= 1:class_size
        for j=1:instance_size-1
            W(i,j)= rand();%change weight 0 or rand();
        end
    end
    for j=1:n
        D(label(j)+1,j)=1;
    end

    epoch=1;
    loop=1;

    %Multiclass Perceptron Training Algorithm 

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

sample_t_e_r = total_error(:,1:50:n);

x = 1:50:n;
t1 = shadedErrorBar(x,sample_t_e_r,{@mean,@std},'lineprops','-b','patchSaturation',0.33) %r
hold on;
h1 = plot(x, mean(sample_t_e_r),'b','LineWidth',2) %r
grid on;

xlabel('epoch')
ylabel('test accuracy')
legend(h1,'random weight Perceptron')
