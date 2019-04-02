function [ processed_data ] = preprocessing( raw_data )
%PREPROCESSING : make multinomial input to binary

raw_xp = raw_data > 8;
raw_xm = raw_data <= 8;
processed_data = raw_xp - raw_xm;
processed_data(:,65) = raw_data(:,65);

end

% train_x0 = train_x(train_x(:,65)==0,:);
% train_x3 = train_x(train_x(:,65)==3,:);
% train_x3(:,65)=9;
% train_x = [train_x0; train_x3];

%train_x = train_x(train_x(:,65)==0 | train_x(:,65)==1,:);
%train_x(train_x(:,65)==1,65) = 9;
