function [i2 i1] = myProjection(ima);
%���룺8��ͨ����ָ��Ķ�ֵͼ��
%�����ˮƽͶӰ�ʹ�ֱͶӰ��
    ima2=ima.'; %ͼ������ת��
    i2=sum(ima2); %ˮƽͶӰ�������
    i1=sum(ima); %��ֱͶӰ�� ������