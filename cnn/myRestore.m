function  section_ima= myRestore(thesection,Label_ima,ima,rr)
% 输入：thesection：投影的分块
%       Label_ima：直线膨胀的区域的区域分割图
%       ima：原图（没有进过太大处理的）
%       rr:膨胀直线的长度
% 输出：section_ima：完好的投影分割图像
%寻找一个直线膨胀后的连通区域在原图像的位置
    newstats = regionprops(Label_ima, 'BoundingBox');%8连通区域标记 包含相应区域的最小矩形[x y x_w y_w]
        y = ceil(thesection(1,3)/2+thesection(1,1));
       [r c] =  size(Label_ima);
       for x =1:r
           if Label_ima(x,y)~=0
               coun = Label_ima(x,y);
               break;
           end
       end
        temp = newstats(coun).BoundingBox;
        section_ima = ima(ceil(temp(2))+1:ceil(temp(2))+temp(4)-1,ceil(temp(1))-1:ceil(temp(1))+temp(3)+1);
  