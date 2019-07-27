function ima2 = myPreproccess(ima)
%输入：ima    =>待处理图像
%输出：ima2  =>预处理后的二值图像
%         newstats   =>连通区域矩阵
%         count  =>连通域数量
    if (size(ima,3) ~= 1)
            ima        = rgb2gray(ima);  %灰度化
    end
    %ima = myGussianLowPassFilter(ima,160); 这里不需平滑处理
    ima            = 255 - ima;
    ima2 = myOtsu(ima);%大津算fa 
    %开运算 腐蚀-》膨胀
    %ima2 = imerode(ima2,se);
    %[Label_ima,num]= bwlabel(ima2,8);%8连通区域
    %newstats = regionprops(Label_ima, 'BoundingBox');%8连通区域标记 包含相应区域的最小矩形[x y x_w y_w]
    