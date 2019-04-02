% scr_HN code: Implemented by Sang-Woo Lee
% Some learning algorithms are copy of Jung-Woo Ha's HN Classifier
% 2014.02.21
% train_x : train data (train_data_size x xdim) 
% test_x : test data (test_data_size x xdim)
% xdim: dimension of data

clear all;
rand('state',sum(100*clock))
randn('state',sum(100*clock))

%%%%%%%%%%%%%%%%%%%%%%%%%%% CHOOSE Data

% load('C:\Users\ÀÌ»ó¿ì\Dropbox\DropCloud\[Sixth Harvest]\[DNA3 Project]\[180203] vernu2502\04\data\Var.mat')
% test_x_org = test_x__;
% train_x_org = train_x__;
% train_x_67 = train_x__(train_x__(:,101)==6 | train_x__(:,101)==7,:); 
% test_x_67 = test_x__(test_x__(:,101)==6 | test_x__(:,101)==7,:); 

% Data 4: MNIST Data 2502_04
% load './data/Orig.mat'
% 
% fea_train = fea(1:60000,1:784)/255;
% fea_test = fea(60001:70000,1:784)/255;
% % fea_train = fea_train(gnd(1:60000)==6 | gnd(1:60000)==7,:);
% % fea_test = fea_test(gnd(60001:70000)==6 | gnd(60001:70000)==7,:);
% % gnd = gnd(gnd==6|gnd==7);
% % train_x_0 = [fea_train(1:5000,:) gnd(1:5000)];
% % test_x_0 = [fea_test(1:1000,:) gnd(12183+1:12183+1000)];
% train_x_0 = fea_train;
% test_x_0 = fea_test;
% 
% train_x_ = [];
% test_x_ = [];
% for i = 5:24
%     train_x_ = [train_x_ train_x_0(:,28*(i-1)+5:28*(i-1)+24)];
%     test_x_ = [test_x_ test_x_0(:,28*(i-1)+5:28*(i-1)+24)];
% end
% 
% train_x__ = zeros(60000,100);
% test_x = zeros(10000,100);
% for i = 1:10
%     for j = 1:10
%         train_x__(:,(i-1)*10+j) = (sum(train_x_(:,(i-1)*40+(j-1)*2+1:(i-1)*40+(j-1)*2+2)')'+sum(train_x_(:,(i-1)*40+(j-1)*2+21:(i-1)*40+(j-1)*2+22)')')/4>0.5;
%         test_x(:,(i-1)*10+j) = (sum(test_x_(:,(i-1)*40+(j-1)*2+1:(i-1)*40+(j-1)*2+2)')'+sum(test_x_(:,(i-1)*40+(j-1)*2+21:(i-1)*40+(j-1)*2+22)')')/4>0.5;
%     end
% end
% train_x__ = [train_x__ gnd(1:60000,1)];
% test_x__ = [test_x gnd(60001:70000,1)];

% n = 6
% reshape(train_x__(n,1:100),10,10)
% train_x__(n,101)
% reshape(test_x__(n,1:100),10,10)
% test_x__(n,101)

clear all
load './data/Var_2502_04.mat'

% Data 4_: MNIST Data Variant

% load './data/Var.mat'
% ro = randperm(100);
% train_x__ = train_x__(:,[ro(1:25) 101]);
% test_x__ = test_x__(:,[ro(1:25) 101]);

% train_x__ = train_x__(:,[4:4:100 101]);
% test_x__ = test_x__(:,[4:4:100 101]);

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
structure_epoch = 10;
i_epoch = 5;
j_epoch = 3;
K = 10;
nHE = 100 *5;
% lol = zeros(structure_epoch,2*i_epoch);




ans_set = cell(i_epoch,j_epoch);
acc_mat = zeros(i_epoch,j_epoch+1,structure_epoch);

for structure_l = 1:structure_epoch

    HE_all = [];
    
    for c = 1:10
        train_x_{c} = train_x__(train_x__(:,end)==mod(c,10),:);
        idx{c} = randperm(size(train_x_{c},1));
    end
    
%     train_x_6 = train_x__(train_x__(:,end)==6,:);
%     train_x_7 = train_x__(train_x__(:,end)==7,:);

%     idx6 = randperm(size(train_x_6,1));
%     idx7 = randperm(size(train_x_7,1));
    
    temp_set = randperm(99);
    active_set_set = reshape(temp_set,3,33);
%     j_epoch = size(active_set_set,1);
    
    test_x = test_x__;
%     test_x = test_x__(test_x__(:,101)==6 | test_x__(:,101)==7,:);

    for j = 1:j_epoch
        active_set = active_set_set(j,:); % note! active_set should be disjoint!
        for i = 1:i_epoch
            fprintf('.');
            
            train_x = [];
            for c = 1:10
                train_x = [train_x; train_x_{c}(idx{c}((i-1)*K+1:(i-1)*K+K),:)];
            end

            %  train_x_6__ = train_x_6(idx6((i-1)*K+1:(i-1)*K+K),:);
            %  train_x_7__ = train_x_7(idx7((i-1)*K+1:(i-1)*K+K),:);
            %  train_x = [train_x_6__; train_x_7__];



            scr_HN_one_step

            [hit miss test_accuracy ans_vec] = hitmissf_2502_03(HE, test_x, type_index);
            ans_set{i,j} = ans_vec;
%             fprintf('HE_all test_accuracy: %.3f\n\n', test_accuracy);

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
    
%     lol(structure_l,i) = test_accuracy;
%     lol(structure_l,i+i_epoch) = test_accuracy;
   acc_mat(:,:,structure_l)
end

% acc_mat

negative_penalty_retio
lol_mat = mean(acc_mat,3);
lol = [mean(lol_mat(:,1:j_epoch)')' lol_mat(:,j_epoch+1)]
figure;
plot(lol)
xlabel('epoch')
ylabel('test accuracy')
legend('single HN','ensemble HN')
% title(num2str(negative_penalty_retio))


save([num2str(cputime) '_' num2str(negative_penalty_retio) '.mat'],'acc_mat')
%if structure_epoch > 1
%     figure; plot(save_hitmiss_log); title('Accuracy'); legend('Train','Test'); 
%     xlabel('structure epoch'); ylabel('accuracy');
%     figure; plot(save_henum_log); title('Number of Hyperedge'); 
%     xlabel('structure epoch');
% end
%%
% figure;
% plot([0.8825	0.922	0.92125	0.923	0.9255;0.95075	0.95075	0.97	0.97725	0.96975]')
% xlabel('epoch')
% ylabel('accuracy')
% legend('single HN','ensemble HN')
