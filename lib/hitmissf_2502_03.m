function [ hit_sum, miss_sum, accuracy, ans_vec ] = hitmissf_2502_03( HE, test_x, type_index )
% from hitmissf
test_data = test_x;
xdim = size(test_x,2);

HE = HE(HE(:,xdim*2+1)~=0,:);

hit_sum = 0;
miss_sum = 0;
ans_vec = zeros(size(test_data,1),1);


    hit = 0;
    miss = 0;
    for i = 1:size(test_data,1)
            max_ans = activate(HE, test_data(i,:), type_index);
            if test_data(i,xdim) == max_ans
                hit = hit + 1; 
            else
                miss = miss + 1;
            end
            ans_vec(i) = max_ans;
    end
    hit_sum = hit_sum + hit;
    miss_sum = miss_sum + miss;
    accuracy = hit_sum/(hit_sum+miss_sum);
    

end
