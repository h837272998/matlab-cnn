function ima2 = myPreproccess(ima)
%���룺ima    =>������ͼ��
%�����ima2  =>Ԥ�����Ķ�ֵͼ��
%         newstats   =>��ͨ�������
%         count  =>��ͨ������
    if (size(ima,3) ~= 1)
            ima        = rgb2gray(ima);  %�ҶȻ�
    end
    %ima = myGussianLowPassFilter(ima,160); ���ﲻ��ƽ������
    ima            = 255 - ima;
    ima2 = myOtsu(ima);%�����fa 
    %������ ��ʴ-������
    %ima2 = imerode(ima2,se);
    %[Label_ima,num]= bwlabel(ima2,8);%8��ͨ����
    %newstats = regionprops(Label_ima, 'BoundingBox');%8��ͨ������ ������Ӧ�������С����[x y x_w y_w]
    