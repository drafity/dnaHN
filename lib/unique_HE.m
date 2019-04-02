prev_w_size = size(HE,1);
bol = zeros(size(HE,1),size(train_x,1));

for i=1:size(train_x,1)
    he_xy_ = HE;

    idx = zeros(size(he_xy_,1),1);
    for j = 1:(size(train_x,2)) 
        idx = idx | (he_xy_(:,j) ~= train_x(i,j) & he_xy_(:,j) ~= 0);
    end
    he_xy_ = he_xy_(~idx,:);
    
    idx2 = HE(:,2*xdim) == train_x(i,xdim);
    idx3 = HE(:,2*xdim) ~= train_x(i,xdim);
    idx_true = idx & idx2;    
    idx_false = idx & idx3;
    bol(:,i) = bol(:,i) + idx_true;
    bol(:,i) = bol(:,i) - idx_false; 
end
bol_unique = unique(bol,'rows');

[ans1, ans2] = unique(bol,'rows');
HE = HE(ans2,:); 

w_size = size(HE,1);
fprintf('Among %d Hyperedges, we find unique %d Hyperedges\n',prev_w_size,w_size);

