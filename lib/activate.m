function [ activate_ans_one, activated_HE_one ] = activate( HE, test_data_one, type_index )
%ACTIVATE Summary of this function goes here
%   Detailed explanation goes here
    xdim = size(test_data_one,2);
    he_xy_ = HE;
    idx = zeros(size(he_xy_,1),1);
    for j = 1:(size(test_data_one,2)-1) % 원래는 size(test_data_one,2) 여야 함.. 0때문에 문제가 꼬이는데.. 나중에 수정요.
        idx = idx | (he_xy_(:,j) ~= test_data_one(1,j) & he_xy_(:,j) ~= 0);
    end
%     for k = 1:size(he_xy_,1)
%         idx(k,1) = (sum(he_xy_(k,1:xdim) == 0 | he_xy_(k,1:xdim) == test_data_one(1,:)) == xdim);
%     end
    he_xy_ = he_xy_(~idx,:);
    activated_HE_one = he_xy_(:,xdim*2+3);

    he_xy_ = he_xy_(he_xy_(:,xdim) == 0,:);

    max = -1; 
    activate_ans_one = -2;
    for typei = 1:size(type_index{xdim}(1,:),2)
        he_xyN{typei} = he_xy_(he_xy_(:,xdim+xdim) == type_index{xdim}(1,typei),:);
        rN{typei} = sum(he_xyN{typei}(:,xdim*2+1));
        if rN{typei} > max
            max = rN{typei};
            activate_ans_one = type_index{xdim}(1,typei);
        end
    end 
end

