%%
%img_path:ͼ�������ļ���
%save_path���ü����ͼ�񱣴��ļ���
%˫���������ͼ��������һ��
%%
img_path='\';
save_path='image\';
name_beg=0;%��ȡ��ͼ�񱣴����ִ�0��ʼ

Files = dir(img_path);
for j=1:length(Files)
    if strcmp(Files(j).name,'.') || strcmp(Files(j).name,'..') || ~strcmp(Files(j).name(end-3:end),'.jpg')
        continue;
    end
    I=imread(strcat(img_path,Files(j).name));
    imshow(I);
    [x,y] = ginput(2);
    if x(1)==x(2) && y(1)==y(2)
        continue;
    end
    rect=[x(1),y(1),x(2)-x(1),y(2)-y(1)];
    J=imcrop(I,rect);
    name=strcat(num2str(name_beg),'.jpg');
    imwrite(J,strcat(save_path,name));
    name_beg=name_beg+1;
end
