function ima2 = myerode(ima,type,c,xi)
%¸¯Ê´
if strcmp(type,'lin')
    se=strel('line',c,xi);  
    ima2 = imerode(ima,se);
end
if strcmp(type,'square')
    se=strel('square',c);  
    ima2 = imerode(ima,se);
end
if strcmp(type,'disk')
    se=strel('disk',c);  
    ima2 = imerode(ima,se);
end