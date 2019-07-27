function ima2  = myOtsu(ima)

ima = double(ima);
ima2 = ima;
L = 256;
P1 = zeros(L,1);
m = P1;
Sigma2 = P1;
%1��һ��ֱ��ͼH
H = myHist(ima);
%2�����ۻ���P1(k)
%3�����ۻ��ľ�ֵ m(k) = �ۼ�iH
for k = 1:L
    P1(k) = sum(H(1:k));%2
    m(k) = (0:k-1)*H(1:k);%3
end
%4����ȫ�ֻҶȾ�ֵmG
mG = mean(ima(:));
%5������䷽��Sigma2
for k = 1:L
    Sigma2(k) = (mG*P1(k)-m(k))^2/(P1(k)*(1-P1(k))+eps);
end
%6ʹ�÷�������kֵ��ΪT�����k��Ψһ���ø�������kƽ��ֵ��T��
maxk = find(Sigma2==max(Sigma2))-1; %-1 =����1 256 ��=����0 255��
trd = mean(maxk);
ima2(ima<trd) = 0;
ima2(ima>=trd) = 255;
ima2 = uint8(ima2);