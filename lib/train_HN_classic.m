function [ HE, w_save, accuracy_save, henum_save ] = ...
    train_HN_classic( epoch, count_ever, count_new, HE, data, test_x, type_index, negative_penalty_ratio)
% train_HN_classic: Copy of Jung-Woo Ha's HN Classifier explained in IEEE TEC paper
% negative penalty ratio: We add weight +1 when each matched HE predict class correctly
% ,whereas we subtract -negative_penalty_ratio when each matched HE predict class not correctly
xdim = size(data,2);
w_save = zeros(epoch,count_ever);
accuracy_save = zeros(epoch,2);
henum_save = zeros(epoch,1);

    dw = zeros(size(HE,1),1);
    for i = 1:size(data,1) 
        he_xy_ = HE;

        idx = zeros(size(he_xy_,1),1);
        for j = 1:(size(data,2)) 
            idx = idx | (he_xy_(:,j) ~= data(i,j) & he_xy_(:,j) ~= 0);
        end
        idx = idx | (he_xy_(:,xdim) ~= 0);

        he_xy_ = he_xy_(~idx,:);

        he_xyN = cell(1,size(type_index{xdim}(1,:),2));
        for k = 1:size(type_index{xdim}(1,:),2) 
            he_xyN{1,k} = he_xy_(he_xy_(:,xdim+xdim) == type_index{xdim}(1,k),:);
        end
        for k = 1:size(type_index{xdim}(1,:),2)
                if data(i,xdim) == type_index{xdim}(1,k)       
                        cc = 1; 
                else                    
                        cc = -negative_penalty_ratio;
                end
                dw(he_xyN{1,k}(:,xdim*2+2)) = dw(he_xyN{1,k}(:,xdim*2+2)) + cc; 
        end
    end

    HE(:,xdim*2+1) = HE(:,xdim*2+1) + dw; 
    HE = HE(HE(:,xdim*2+1)>0,:); 
    HE(:,xdim*2+2) = [1:size(HE,1)];
    w_save(1,HE(:,xdim*2+3)) = HE(:,xdim*2+1);

    [hit_sum, miss_sum, train_accuracy] = hitmissf( HE, data, type_index);
    accuracy_save(1,1) = train_accuracy;
    [hit_sum, miss_sum, test_accuracy ] = hitmissf( HE, test_x, type_index);
    accuracy_save(1,2) = test_accuracy;
%     fprintf('step: %d, train_accuracy: %.3f, test_accuracy: %.3f\n',1, train_accuracy, test_accuracy);
    
    henum_save(1) = size(HE(HE(:,xdim*2+1)>0,:),1);
    
end

