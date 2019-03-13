function [ HE, w_save, accuracy_save, henum_save ] = ...
    train_HN_prob( epoch, count_ever, count_new, HE, data, test_x, type_index, update_rate)
% train_HN_prob: Sang-Woo Ha's batch version HN classifier explained in KIISE13 paper
% update_rate: we multiply update_rate and diffrential of objective
%   function (and function of epoch) to optimize model


xdim = size(data,2);
w_save = zeros(epoch,count_ever);
accuracy_save = zeros(epoch,2);
henum_save = zeros(epoch,1);

for t = 1:epoch
    dw = zeros(size(HE,1),1);
    for i = 1:size(data,1) 
        he_xy_ = HE;

        idx = zeros(size(he_xy_,1),1);
        for j = 1:(size(data,2)) 
            idx = idx | (he_xy_(:,j) ~= data(i,j) & he_xy_(:,j) ~= 0);
        end
        idx = idx | (he_xy_(:,xdim) ~= 0);

        he_xy_ = he_xy_(~idx,:);

        
        r = zeros(1,size(type_index{xdim}(1,:),2));
        he_xyN = cell(1,size(type_index{xdim}(1,:),2));
        Z = 0;
        for k = 1:size(type_index{xdim}(1,:),2) 
            he_xyN{1,k} = he_xy_(he_xy_(:,xdim+xdim) == type_index{xdim}(1,k),:);
            r(k) = exp(sum(he_xyN{1,k}(:,xdim*2+1))); 
            Z = Z + r(k);
        end
        for k = 1:size(type_index{xdim}(1,:),2)
                if data(i,xdim) == type_index{xdim}(1,k)       
                    cc = 1-r(k)/Z; 
                else                    
                    cc = -r(k)/Z; 
                end
                dw(he_xyN{1,k}(:,xdim*2+2)) = dw(he_xyN{1,k}(:,xdim*2+2)) + cc; 
        end
    end
    stdo = std(dw)*t;


    HE(:,xdim*2+1) = HE(:,xdim*2+1) + dw*update_rate/stdo; 
    HE(:,xdim*2+2) = [1:size(HE,1)];
    w_save(t,HE(:,xdim*2+3)) = HE(:,xdim*2+1);

    [hit_sum, miss_sum, train_accuracy] = hitmissf( HE, data, type_index);
    accuracy_save(t,1) = train_accuracy;
    [hit_sum, miss_sum, test_accuracy ] = hitmissf( HE, test_x, type_index);
    accuracy_save(t,2) = test_accuracy;
    fprintf('step: %d, train_accuracy: %.3f, test_accuracy: %.3f\n',t, train_accuracy, test_accuracy);
    
    henum_save(t) = size(HE(HE(:,xdim*2+1)>0,:),1); 

end


end

