%����ѵ��ͼƬԤ�������з�װ��
function mycnnPrestrain(number,ndata)
%train_y=zeros(number*30,number); % ��ʼ������
%train_x = zeros(number*30,784); 
for kk=0:number-2
    
    m =strcat('train/',int2str(kk),'.jpg');
    ima=imread(m);
    ima = myPreproccess(ima);%Ԥ����
    %������
%     ima = myerode(ima,'square',1);
%     ima = mydilate(ima,'square',2);
    %ֱ������
    ima1 = mydilate(ima,'lin',10,90);
    [Label_ima,num]= bwlabel(ima1,8);%8��ͨ����
    newstats = regionprops(Label_ima, 'BoundingBox');%8��ͨ������ ������Ӧ�������С����[x y x_w y_w]
    ima2 = ima;
    if num~=30  %ÿ��ѵ��30
        disp(['ѵ����Ŀ����',num2str(kk+1),'  ',num2str(num)]);
    end
    for n = 1:num
        temp = newstats(n).BoundingBox;
        if (temp(3)<10) && (temp(4)<12)
            disp(['��ǰѵ����Ŀ����',num2str(kk+1),' -1']);
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
%             % ȡ������˳����batchsize�������Ͷ�Ӧ�ı�ǩ  kk1 kk2 kk3 
%             batch_x(:,:,l) = train_x(:, :, kk(l));
%             batch_y(l,:) = train_y(kk(l),:); 
%         end
% train_x =batch_x ;
% train_y = batch_y;
save myPT train_x train_y data;    % �洢�γɵĲ���������(����������Ŀ������)
disp('�����������ɳɹ���');
