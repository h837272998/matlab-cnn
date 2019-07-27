function ima2  = myOtsu(ima)

ima = double(ima);
ima2 = ima;
L = 256;
P1 = zeros(L,1);
m = P1;
Sigma2 = P1;
%1归一化直方图H
H = myHist(ima);
%2计算累积和P1(k)
%3计算累积的均值 m(k) = 累加iH
for k = 1:L
    P1(k) = sum(H(1:k));%2
    m(k) = (0:k-1)*H(1:k);%3
end
%4计算全局灰度均值mG
mG = mean(ima(:));
%5计算类间方差Sigma2
for k = 1:L
    Sigma2(k) = (mG*P1(k)-m(k))^2/(P1(k)*(1-P1(k))+eps);
end
%6使得方差最大的k值即为T。如果k不唯一，用各个最大的k平均值得T。
maxk = find(Sigma2==max(Sigma2))-1; %-1 =》【1 256 】=》【0 255】
trd = mean(maxk);
ima2(ima<trd) = 0;
ima2(ima>=trd) = 255;
ima2 = uint8(ima2);