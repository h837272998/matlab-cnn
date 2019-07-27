function ima2 = mydilate(ima,type,c,xi)
%≈Ú’Õ
if strcmp(type,'lin')
    se=strel('line',c,xi);  
    ima2 = imdilate(ima,se);
end
if strcmp(type,'square')
    se=strel('square',c);  
    ima2 = imdilate(ima,se);
end
if strcmp(type,'disk')
    se=strel('disk',c);  
    ima2 = imdilate(ima,se);
end