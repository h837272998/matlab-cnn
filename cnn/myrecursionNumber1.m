function [section len] = myrecursionNumber1(ima,cnn,mul,len,section);
% 输入：ima；待识别图像
%          cnn：神经网络
%          mul：当前递归次数，即分数的层数
%          section：前一递归识别后部分数组，初始0
% 输出：section：组合后的某一递归识别数组。
    
    rr = size(ima,1);   %获得深度，用于直线膨胀长度分析
    ima1 = mydilate(ima,'lin',35,90);
    [Label_ima,numx] = bwlabel(ima1 , 8);
    newstats = regionprops(Label_ima,'BoundingBox');%获得膨胀图像连通域属性
    [ix iy] = myProjection(ima);
    [thesection num] = mySecPro(iy);%获得水平投影的块数和属性
    section = zeros(3,1); %建立存储
    section(1:3,1) = mul*111;
    for ii = 1:num   %从水平投影处理 
        section_ima = ima(:,thesection(ii,1)-1:thesection(ii,1)+thesection(ii,3)+1);   %当前投影块（没有膨胀）
        [lab num] = bwlabel(section_ima);   %将投影块区域分割，判断是单独还是组合
        r = size(section,1);
        if num<3   % 单个字符 也是递归出口
            test_x = myRestore(thesection(ii,:),Label_ima,ima,rr); %在膨胀的区域中寻找原图像
            ima1 = mydilate(test_x,'lin',8,90);
            ima1 = myOtsu(ima1);
            [Label,num]= bwlabel(ima1,8);
            newstatsx = regionprops(Label, 'BoundingBox');
            t = newstatsx(1).BoundingBox;
%             figure();imshow(test_x);title('sss');
            test_x = test_x(ceil(t(2)):ceil(t(2))+t(4)-1,ceil(t(1)):ceil(t(1))+t(3))-1;
            test_x_t = test_x;
            test_x = out_28_28(test_x);
%          figure();imshow(test_x);title('ss');
            [ix1 iy1] = myProjection(test_x_t);
            [thesection2 num2] = mySecPro(ix1);
             if num2>1  %i情况
                thex = thesection2(1,3)*2+thesection2(2,3);%que
             else  %当个情况
                thex = thesection2(1,3);
             end 
             len(1,end+1) = thex;
             len(2,end) = thesection(ii,3);
            if len(1,end)~=0&&len(1,end-1)>len(1,end)*5/3&&len(2,end-1)>len(2,end)*4/3
                section(ceil(r/2)-1,end+1) = myOut(cnn,test_x/255);
             else
                section(ceil(r/2),end+1) = myOut(cnn,test_x/255);
             end
              figure();imshow(test_x/255);title('识别');
        else  %三个区域以上  分数情况或者除号
            %先判断除号
            [ix1 iy1] = myProjection(section_ima);
            [thesection2 num2] = mySecPro(ix1);
            thex = sum(thesection2(:,3));
             if (section(ceil(r/2),end)>0&&section(ceil(r/2),end)<11&&section(ceil(r/2),end)~=0)||...
                (section(ceil(r/2),end)>0&&section(ceil(r/2)-1,end)<11&&section(ceil(r/2)-1,end)~=0)%||...
                %thex<vg_x
            %除号判断。较依赖前面的识别结果 ....引发较大的计算错误
                test_x = myRestore(thesection(ii,:),Label_ima,ima,rr);
                test_x = myOtsu(test_x);
                test_x = mydilate(test_x,'disk',1);
                test_x = myerode(test_x,'disk',2);
                test_x = out_28_28(test_x);
                section(ceil(r/2),end+1) = myOut(cnn,test_x/255);
             %分数
                else
                 test_x = myRestore(thesection(ii,:),Label_ima,ima,rr);
                 %去除分号
                 L_ima = bwlabel(test_x,8);
                 [r c] = size(test_x);
                 for nn = 1:ceil(c/2)
                    t = find(test_x(:,nn)~=0);
                    if t~=0
                        kk= nn;
                        break;
                    end
                 end
                 [m n] = find(L_ima==L_ima(t(1),kk));
                 test_x(m,n) = 0; %去除
                 maxx = max(m);
                 minx = min(m);
                 thisx = ceil((maxx+minx)/2);
                 theOne = test_x(1:thisx, : );
                 theTwo = test_x(thisx:end,:);
                 theOne1 = mydilate(theOne,'lin',10,90);   %10的膨胀
                 theTwo1 = mydilate(theTwo,'lin',10,90);   %10的膨胀
                 [ix1 iy1] = myProjection(theOne1);  %投影
                 [ix2 iy2] = myProjection(theTwo1);  %投影
                 [thesection3 num3] = mySecPro(ix1);%按块识别处理
                 [thesection4 num4] = mySecPro(ix2);%按块识别处理
                 theOne = theOne(thesection3(1,1):thesection3(end,1)+thesection3(end,3),:);
                 section1 = myrecursionNumber1(theOne,cnn,abs(mul)+1,len);%递归
                 theTwo = theTwo(thesection4(1,1):thesection4(end,1)+thesection4(end,3),:);
                 section2 = myrecursionNumber1(theTwo,cnn,-(abs(mul)+1),len);%递归
                  %合并结果
                 section2 = [section2,section1(1:3,1)];
                 section = [section,section1,section2];
             end
        end
    end