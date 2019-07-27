function [i2 i1] = myProjection(ima);
%输入：8连通区域分割后的二值图像
%输出：水平投影和垂直投影；
    ima2=ima.'; %图像行列转置
    i2=sum(ima2); %水平投影后的数组
    i1=sum(ima); %垂直投影后 的数组