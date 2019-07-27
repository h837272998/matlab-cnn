%将待训练图片预处理，进行封装。
function mycnnPrestrain(number,ndata)
%train_y=zeros(number*30,number); % 初始化向量
%train_x = zeros(number*30,784); 
for kk=0:number-2
    
    m =strcat('train/',int2str(kk),'.jpg');
    ima=imread(m);
    ima = myPreproccess(ima);%预处理
    %开操作
%     ima = myerode(ima,'square',1);
%     ima = mydilate(ima,'square',2);
    %直线膨胀
    ima1 = mydilate(ima,'lin',10,90);
    [Label_ima,num]= bwlabel(ima1,8);%8连通区域
    newstats = regionprops(Label_ima, 'BoundingBox');%8连通区域标记 包含相应区域的最小矩形[x y x_w y_w]
    ima2 = ima;
    if num~=30  %每张训练30
        disp(['训练数目错误',num2str(kk+1),'  ',num2str(num)]);
    end
    for n = 1:num
        temp = newstats(n).BoundingBox;
        if (temp(3)<10) && (temp(4)<12)
            disp(['当前训练数目纠正',num2str(kk+1),' -1']);
            continue;
        end
        theOne_img = ima2(ceil(temp(2)):ceil(temp(2))+temp(4),...
        ceil(temp(1)):ceil(temp(1))+temp(3));
        train_one = out_28_28(theOne_img);
%         figure();imshow(train_one);
        train_x(:,:,kk*30+n) = train_one(:,:);
     ty = kk*num+n;
     train_y(ty,kk+1) = 1;
%     switch kk    
%         case 0%0
%             train_y(ty,1)=1; 
%         case 1%1  
%         train_y(ty,2)=1;
%         case 2%2      
%     end
end
end

for i = 1:number-1
    data(i) = ndata(i,2);
end
% batch_x = train_x;
% batch_y = train_y;
%   kk = randperm(m);  
%         for l = 1 : m  
%             % 取出打乱顺序后的batchsize个样本和对应的标签  kk1 kk2 kk3 
%             batch_x(:,:,l) = train_x(:, :, kk(l));
%             batch_y(l,:) = train_y(kk(l),:); 
%         end
% train_x =batch_x ;
% train_y = batch_y;
save myPT train_x train_y data;    % 存储形成的测试样本集(输入向量和目标向量)
disp('测试样本生成成功！');
