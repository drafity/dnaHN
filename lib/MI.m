function [ret] = MI(data,yi,type_index)
% MI: calculate mutual information of each features and class
% we can exchange this function to toolbox function

ret = zeros(size(data,2),1);
for xi=1:size(data,2)
N=size(data,1);

px = zeros(1,size(type_index{xi,1},2));
for i= 1:size(type_index{xi,1},2)
    idx1 = data(:,xi)==type_index{xi,1}(1,i);
    px(1,i) = sum(idx1)/N;	
end

py = zeros(1,size(type_index{yi,1},2));
for j= 1:size(type_index{yi,1},2)
    idx2 = data(:,yi)==type_index{yi,1}(1,j);
    py(1,j) = sum(idx2)/N;	
end

pxy = zeros(size(type_index{xi,1},2),size(type_index{yi,1},2));
for i= 1:size(type_index{xi,1},2)
    for j= 1:size(type_index{yi,1},2)
        idx1 = data(:,xi)==type_index{xi,1}(1,i);
        idx2 = data(:,yi)==type_index{yi,1}(1,j);
        idx = idx1 & idx2;
        pxy(i,j) = sum(idx)/N;
        if pxy(i,j) > 0 
            ret(xi,1) = ret(xi,1) + pxy(i,j)*log2(pxy(i,j)/(px(1,i)*py(1,j)));
        end
    end
end

end