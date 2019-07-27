function [thesection num] = mySecPro(iy)  %投影块级分析
% 输入：iy：某方向的投影；
% 输出：thesection：每个划分区域的位置
%           num：总区域数
pre = 0; %判断介质
num = 0;  %块数
thesection = [0,0,0];
%获得投影后按照垂直方向分块处理。
for i = 1:length(iy);
    if iy(1,i)~= 0 && pre ==0
        num = num + 1;
        thesection(num,1) = i; %每块的起始垂直坐标
        pre = 1;
    else if iy(1,i)==0 && pre~=0
        thesection(num,3) = i-1-thesection(num,1); %每块的垂直长度
        pre = 0;
        end
    end
end

if num~= 0 &&thesection(num,3) == 0
    thesection(num,3) = length(iy)-thesection(num,1)-1;
end