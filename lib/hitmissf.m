function [ hit_sum, miss_sum accuracy recall precision f_measure] = hitmissf( HE, test_x, type_index )
% hitmissf function measure performance of model
% caution: if only class is 0 and 1 we can use recall, precision, and f_measure
test_data = test_x;
xdim = size(test_x,2);

HE = HE(HE(:,xdim*2+1)~=0,:);

hit_sum = 0;
miss_sum = 0;
a = 0 ; b = 0; c = 0 ; d = 0;

    hit = 0;
    miss = 0;
    for i = 1:size(test_data,1)
            max_ans = activate(HE, test_data(i,:), type_index);
            if test_data(i,xdim) == max_ans
                if test_data(i,xdim)== 0
                    a = a+1;
                else
                    d = d+1;
                end
                hit = hit + 1; 
            else
                if test_data(i,xdim)==0
                    b = b+1;
                else
                    c = c+1;
                end
                miss = miss + 1;
            end
    end
    hit_sum = hit_sum + hit;
    miss_sum = miss_sum + miss;
    
    recall = d/(b+d);
    precision = d/(c+d);
    f_measure = 2*recall*precision/(recall+precision);
    accuracy = hit_sum/(hit_sum+miss_sum);
    

end
