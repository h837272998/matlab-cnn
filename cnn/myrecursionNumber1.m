function [section len] = myrecursionNumber1(ima,cnn,mul,len,section);
% ���룺ima����ʶ��ͼ��
%          cnn��������
%          mul����ǰ�ݹ�������������Ĳ���
%          section��ǰһ�ݹ�ʶ��󲿷����飬��ʼ0
% �����section����Ϻ��ĳһ�ݹ�ʶ�����顣
    
    rr = size(ima,1);   %�����ȣ�����ֱ�����ͳ��ȷ���
    ima1 = mydilate(ima,'lin',35,90);
    [Label_ima,numx] = bwlabel(ima1 , 8);
    newstats = regionprops(Label_ima,'BoundingBox');%�������ͼ����ͨ������
    [ix iy] = myProjection(ima);
    [thesection num] = mySecPro(iy);%���ˮƽͶӰ�Ŀ���������
    section = zeros(3,1); %�����洢
    section(1:3,1) = mul*111;
    for ii = 1:num   %��ˮƽͶӰ���� 
        section_ima = ima(:,thesection(ii,1)-1:thesection(ii,1)+thesection(ii,3)+1);   %��ǰͶӰ�飨û�����ͣ�
        [lab num] = bwlabel(section_ima);   %��ͶӰ������ָ�ж��ǵ����������
        r = size(section,1);
        if num<3   % �����ַ� Ҳ�ǵݹ����
            test_x = myRestore(thesection(ii,:),Label_ima,ima,rr); %�����͵�������Ѱ��ԭͼ��
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
             if num2>1  %i���
                thex = thesection2(1,3)*2+thesection2(2,3);%que
             else  %�������
                thex = thesection2(1,3);
             end 
             len(1,end+1) = thex;
             len(2,end) = thesection(ii,3);
            if len(1,end)~=0&&len(1,end-1)>len(1,end)*5/3&&len(2,end-1)>len(2,end)*4/3
                section(ceil(r/2)-1,end+1) = myOut(cnn,test_x/255);
             else
                section(ceil(r/2),end+1) = myOut(cnn,test_x/255);
             end
              figure();imshow(test_x/255);title('ʶ��');
        else  %������������  ����������߳���
            %���жϳ���
            [ix1 iy1] = myProjection(section_ima);
            [thesection2 num2] = mySecPro(ix1);
            thex = sum(thesection2(:,3));
             if (section(ceil(r/2),end)>0&&section(ceil(r/2),end)<11&&section(ceil(r/2),end)~=0)||...
                (section(ceil(r/2),end)>0&&section(ceil(r/2)-1,end)<11&&section(ceil(r/2)-1,end)~=0)%||...
                %thex<vg_x
            %�����жϡ�������ǰ���ʶ���� ....�����ϴ�ļ������
                test_x = myRestore(thesection(ii,:),Label_ima,ima,rr);
                test_x = myOtsu(test_x);
                test_x = mydilate(test_x,'disk',1);
                test_x = myerode(test_x,'disk',2);
                test_x = out_28_28(test_x);
                section(ceil(r/2),end+1) = myOut(cnn,test_x/255);
             %����
                else
                 test_x = myRestore(thesection(ii,:),Label_ima,ima,rr);
                 %ȥ���ֺ�
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
                 test_x(m,n) = 0; %ȥ��
                 maxx = max(m);
                 minx = min(m);
                 thisx = ceil((maxx+minx)/2);
                 theOne = test_x(1:thisx, : );
                 theTwo = test_x(thisx:end,:);
                 theOne1 = mydilate(theOne,'lin',10,90);   %10������
                 theTwo1 = mydilate(theTwo,'lin',10,90);   %10������
                 [ix1 iy1] = myProjection(theOne1);  %ͶӰ
                 [ix2 iy2] = myProjection(theTwo1);  %ͶӰ
                 [thesection3 num3] = mySecPro(ix1);%����ʶ����
                 [thesection4 num4] = mySecPro(ix2);%����ʶ����
                 theOne = theOne(thesection3(1,1):thesection3(end,1)+thesection3(end,3),:);
                 section1 = myrecursionNumber1(theOne,cnn,abs(mul)+1,len);%�ݹ�
                 theTwo = theTwo(thesection4(1,1):thesection4(end,1)+thesection4(end,3),:);
                 section2 = myrecursionNumber1(theTwo,cnn,-(abs(mul)+1),len);%�ݹ�
                  %�ϲ����
                 section2 = [section2,section1(1:3,1)];
                 section = [section,section1,section2];
             end
        end
    end