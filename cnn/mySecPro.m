function [thesection num] = mySecPro(iy)  %ͶӰ�鼶����
% ���룺iy��ĳ�����ͶӰ��
% �����thesection��ÿ�����������λ��
%           num����������
pre = 0; %�жϽ���
num = 0;  %����
thesection = [0,0,0];
%���ͶӰ���մ�ֱ����ֿ鴦��
for i = 1:length(iy);
    if iy(1,i)~= 0 && pre ==0
        num = num + 1;
        thesection(num,1) = i; %ÿ�����ʼ��ֱ����
        pre = 1;
    else if iy(1,i)==0 && pre~=0
        thesection(num,3) = i-1-thesection(num,1); %ÿ��Ĵ�ֱ����
        pre = 0;
        end
    end
end

if num~= 0 &&thesection(num,3) == 0
    thesection(num,3) = length(iy)-thesection(num,1)-1;
end