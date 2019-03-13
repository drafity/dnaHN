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
 

load './data/Var_2class.mat'

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
        W(i,j)= 0;
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

s_error = smooth(error);
plot(1:n, s_error,'ms-')


  xlabel('Number of Epochs','FontSize',16,'FontWeight','bold', 'FontName','Time new roman');
  ylabel('Number of misclassifications','FontSize',16,'FontWeight','bold');
  title('Number of Epochs vs Number of misclassifications (Perceptron training algorithm)','FontSize',18);