function [ he_xy, count ] = make_HE( data, order, count_ever, initial_weight ,he_num, type_index, smooth_const, mutual_info_use,active_set )
% make_HE: a function which makes new Hyperedges
% we sample HE from data distribution
% we can also use mutual information by setting mutual_info_use flag as true 
%
% order: order of HEs which you want to make
% initial_weight: initial weight of HEs
% he_num: number of HEs which you want to make
% smooth const: a smooth constant used for selection probability of input feature in HE selection

xdim = size(data,2);
if nargin == 8
    active_set = [1:xdim-1];
end

mio = MI(data,xdim,type_index);
he_xy = zeros(he_num,xdim*2+2);
idx = 0;

for i=1:he_num
    idx = idx+1;
    if ~mutual_info_use
%         rp_one = randperm(xdim-1);
        rp_one = randperm(size(active_set,2));
        rp_one = active_set(rp_one);
    else
        remain_idx_parr = [1:xdim-1];
        rp_one = [];
        for j = 1:order
            remain_MI_prob = (mio(remain_idx_parr)+smooth_const)/(sum(mio(remain_idx_parr)+smooth_const));
            for k = 2:size(remain_idx_parr,2)
                remain_MI_prob(k) = remain_MI_prob(k) + remain_MI_prob(k-1);
            end
            rand_one = rand(1);
            find_arr = find(remain_MI_prob > rand_one);
            find_one = find_arr(1);
            rp_one = [rp_one remain_idx_parr(find_one)];
            remain_idx_parr = setdiff(remain_idx_parr,remain_idx_parr(find_one));
        end
    end

    clique_one = zeros(1,xdim*2);
    clique_one(1,rp_one(1:order)) = 1;
    clique_one(1,2*xdim) = 1;
    randperm_one = randperm(size(data,1));
    randperm_one = randperm_one(1);
    data_one = data(randperm_one,:);
    for k = 1:xdim
        he_xy(idx,k) = clique_one(1,k)*data_one(1,k);
        he_xy(idx,xdim+k) = clique_one(1,xdim+k)*data_one(1,k);
    end
end

he_xy(idx+1:end,:) = [];
he_xy = unique(he_xy,'rows');
he_xy(:,xdim*2+1) = initial_weight;
he_xy(:,xdim*2+3) = count_ever + [1:size(he_xy,1)];    

count = size(he_xy,1);    


end

