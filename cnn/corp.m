%%
%img_path:图像所在文件夹
%save_path：裁剪后的图像保存文件夹
%双击左键不截图，跳到下一张
%%
img_path='\';
save_path='image\';
name_beg=0;%截取的图像保存名字从0开始

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
