function  section_ima= myRestore(thesection,Label_ima,ima,rr)
% ���룺thesection��ͶӰ�ķֿ�
%       Label_ima��ֱ�����͵����������ָ�ͼ
%       ima��ԭͼ��û�н���̫����ģ�
%       rr:����ֱ�ߵĳ���
% �����section_ima����õ�ͶӰ�ָ�ͼ��
%Ѱ��һ��ֱ�����ͺ����ͨ������ԭͼ���λ��
    newstats = regionprops(Label_ima, 'BoundingBox');%8��ͨ������ ������Ӧ�������С����[x y x_w y_w]
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
  