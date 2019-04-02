% scr_HN code: Implemented by Sang-Woo Lee
% Some learning algorithms are copy of Jung-Woo Ha's HN Classifier
% 2014.02.21
% train_x : train data (train_data_size x xdim) 
% test_x : test data (test_data_size x xdim)
% xdim: dimension of data

clear all;
rand('state',sum(100*clock))
randn('state',sum(100*clock))

clear all
load '../data/Var_2502_04.mat'

%%%%%%%%%%%%%%%%%%%%%%%%%%% Initialize Variable
xdim = size(train_x__,2);

type_index = cell(xdim,1);
for i = 1:xdim
    type_index{i} = unique(train_x__(:,i),'rows');
    type_index{i} = sort(type_index{i},1)';
end

count_ever = 0; % number of whole HE made in this experiments
HE = [];
save_hitmiss_log = [];
save_henum_log = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%% Learn HN
structure_epoch = 1000; % overall iteration
i_epoch = 5; % training iteration
j_epoch = 3; % ensenble iteration
K = 20;
nHE = 100 * 10;

ans_set = cell(i_epoch,j_epoch);
acc_mat = zeros(i_epoch,j_epoch+1,structure_epoch);

for structure_l = 1:structure_epoch

    HE_all = [];
    
    for c = 1:10
        train_x_{c} = train_x__(train_x__(:,end)==mod(c,10),:);
        idx{c} = randperm(size(train_x_{c},1));
    end
    
    temp_set = randperm(99);
    active_set_set = reshape(temp_set,3,33);
    
    test_x = test_x__;

    for j = 1:j_epoch
        active_set = active_set_set(j,:); % note! active_set should be disjoint!
        for i = 1:i_epoch
            fprintf('%d.',i);
            
            train_x = [];
            for c = 1:10
                train_x = [train_x; train_x_{c}(idx{c}((i-1)*K+1:(i-1)*K+K),:)];
            end

            scr_HN_one_step

            [hit miss test_accuracy ans_vec] = hitmissf_2502_03(HE, test_x, type_index);
            ans_set{i,j} = ans_vec;

        end
    HE = [];
    end
    
    for i = 1:i_epoch
        for j = 1:j_epoch
            acc_mat(i,j,structure_l) = sum(ans_set{i,j} == test_x(:,end))/size(test_x,1);
        end
        acc_mat(i,j_epoch+1,structure_l) = sum(mode([ans_set{i,1} ans_set{i,2} ans_set{i,3}]')' == test_x(:,end))/size(test_x,1);
    end
    fprintf('\n');
    
   acc_mat(:,:,structure_l)
end

%% 5iteration
negative_penalty_retio
lol_mat = mean(acc_mat,3);
lol_std_p = std(acc_mat,[],3);
lol = [mean(lol_mat(:,1:j_epoch)')' lol_mat(:,j_epoch+1)]
lol_std = [mean(lol_std_p(:,1:j_epoch)')' lol_std_p(:,j_epoch+1)]
figure;
hold on;
grid on;
H=errorbar(1:5,lol(:,1),lol_std(:,1),'r','LineWidth',2); % single
H=errorbar(1:5,lol(:,2),lol_std(:,2),'b','LineWidth',2); % ensemble

scatter(1:5,lol(:,1),'r','LineWidth',2); %single
scatter(1:5,lol(:,2),'b','LineWidth',2); %single

xlabel('epoch')
ylabel('test accuracy')
legend('single HN','ensemble HN')

