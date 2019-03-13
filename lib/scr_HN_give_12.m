clear all;
load './data/Orig.mat'
train_x_0 = fea(1:60000,1:784)/255;
test_x_0 = fea(60001:70000,1:784)/255;

train_x_ = [];
test_x_ = [];
for i = 5:24
    train_x_ = [train_x_ train_x_0(:,28*(i-1)+5:28*(i-1)+24)];
    test_x_ = [test_x_ test_x_0(:,28*(i-1)+5:28*(i-1)+24)];
end

train_x__ = zeros(60000,100);
test_x = zeros(10000,100);
for i = 1:10
    for j = 1:10
        train_x__(:,(i-1)*10+j) = (sum(train_x_(:,(i-1)*40+(j-1)*2+1:(i-1)*40+(j-1)*2+2)')'+sum(train_x_(:,(i-1)*40+(j-1)*2+21:(i-1)*40+(j-1)*2+22)')')/4;
        test_x(:,(i-1)*10+j) = (sum(test_x_(:,(i-1)*40+(j-1)*2+1:(i-1)*40+(j-1)*2+2)')'+sum(test_x_(:,(i-1)*40+(j-1)*2+21:(i-1)*40+(j-1)*2+22)')')/4;
    end
end
train_x__ = [train_x__ gnd(1:60000,1)];
test_x__ = [test_x gnd(60001:70000,1)];

train_x_6 = train_x__(train_x__(:,end)==6,:);
train_x_6 = train_x_6(1:5,:);
train_x_7 = train_x__(train_x__(:,end)==7,:);
train_x_7 = train_x_7(1:5,:);
test_x_6 = test_x__(test_x__(:,end)==6,:);
test_x_6 = test_x_6(1,:);
test_x_7 = test_x__(test_x__(:,end)==7,:);
test_x_7 = test_x_7(1,:);

X = [train_x_6; test_x_6; train_x_7; test_x_7];

temp_set = randperm(99);
active_set_set = reshape(temp_set,3,33);
X_{1} = X(:,active_set_set(1,:));
X_{2} = X(:,active_set_set(2,:));
X_{3} = X(:,active_set_set(3,:));

