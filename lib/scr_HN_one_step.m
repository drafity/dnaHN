% scr_HN_one_step: this function optimize parameters of current_epoch HEs
% HE : Hyperedge (w_size x (xdim*2+3))
% HE(:,1:xdim-1) are features, HE(:,2*xdim) are class, HE(:,2*xdim+1) are weights
% HE(:,2*xdim+2) are index in one structure epoch, HE(:,2*xdim+3) are natural_born index
% w_size: number of HE

%%%%%%%%%%%%%%%%%%%%%%%%%%% remain top N HE
% top_n = 120;
% if size(HE,1) > top_n
%     [Y,I] = sort(HE(:,xdim*2+1),1,'descend');
%     HE = HE(I,:);
%     HE = HE(1:top_n,:);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%% weight initialize
initial_weight = 0;
% if size(HE,1) > 0 
%     HE = HE(HE(:,xdim*2+1)>0,:);
%     HE(:,xdim*2+1) = ones(size(HE,1),1)*initial_weight;
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%% make_HE
% tic; disp('[ make_new_HN ]');
smooth_const = 0.001;
mutual_info_use = false; % true, false
% if structure_l == 1 & i == 1
% example we make 1000 order-6 HEs, and 1000 order-7 HEs
% [HE_, count_new] = make_HE(train_x, 3, count_ever,initial_weight, 1000, type_index, smooth_const, mutual_info_use);
[HE_, count_new] = make_HE(train_x, 3, count_ever,initial_weight, nHE, type_index, smooth_const, mutual_info_use,active_set);
count_ever = count_ever + count_new;
[HE_, count_new] = make_HE(train_x, 4, count_ever,initial_weight, nHE, type_index, smooth_const, mutual_info_use,active_set);
count_ever = count_ever + count_new;
[HE_, count_new] = make_HE(train_x, 5, count_ever,initial_weight, nHE, type_index, smooth_const, mutual_info_use,active_set);
count_ever = count_ever + count_new;

HE = [HE; HE_];

% [HE_, count_new] = make_HE(train_x, 3, count_ever,initial_weight, 1000, type_index, smooth_const, mutual_info_use);
% count_ever = count_ever + count_new;
% HE = [HE; HE_];
% [HE_, count_new] = make_HE(train_x, 7, count_ever,initial_weight, 100, type_index, smooth_const, mutual_info_use);
% count_ever = count_ever + count_new;
% HE = [HE; HE_];
% toc; 
% end

% tic; disp('[ unique_HE ]'); unique_HE; toc;
HE(:,xdim*2+2) = [1:size(HE,1)];

%%%%%%%%%%%%%%%%%%%%%%%%%%% train HN
%%%%%%%%%%%%%%%%%%%%%%%%%%% CHOOSE HN Classifier
% tic; disp('[ parameter_tune_HN ]');

% Classifier 1: Evolutionary Hypernetwork Classifier
% parameter_step = 1;
% negative_penalty_retio = 2;
% [HE, w_save, accuracy_save, henum_save] = ...
%     train_HN_classic(1, count_ever, count_new, HE, train_x, test_x, type_index, negative_penalty_retio);

% Classifier 2: Probabilistic Hypernetwork Classifier 
parameter_step = 1;
negative_penalty_retio = -1; % dummy
[HE, w_save, accuracy_save, henum_save] = ...
    train_HN_prob(parameter_step, count_ever,count_new, HE, train_x, test_x, type_index, 0.1/i);

% TODO 3: Implement other HN classifier (e.g. Jung Woo Ha's New HN Classifier)

% toc;

% if parameter_step > 1
%     figure; plot(w_save); title('Weights'); xlabel('parameter step');
%     figure; plot(accuracy_save); title('Accuracy'); legend('Train','Test'); xlabel('parameter step');
%     figure; plot(henum_save); title('Number of Hyperedge with positive weight'); 
%     xlabel('parameter step'); ylabel('Number of Hyperedge with positive weight');
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%% test HN

% tic; disp('[ test_HN ]');
% [hit miss test_accuracy recall precision f_measure] = hitmissf(HE, test_x, type_index);
% [hit miss train_accuracy] = hitmissf(HE, train_x, type_index);
% fprintf('structure_epoch: %d, train_accuracy: %.3f, test_accuracy: %.3f\n', ...
%     structure_l, train_accuracy, test_accuracy);
% toc; % fprintf('\n');
% 
% save_hitmiss_log = [save_hitmiss_log;train_accuracy, test_accuracy];
% save_henum_log = [save_henum_log;size(HE,1)];