function h = myOut(net, x)  
    net = cnnff2(net, x); % ffǰ�򴫲��õ���� 
    [rate, h] = max(net.o); % �ҵ�ÿ�У�һ�б�ʾһ���������������������Ӧ�ı�ǩ  
   % h = h;
   % result = data(h);

%     if rate <0.45
%         disp(['ʶ���������ܳ�����' num2str(h)  ' ���ʣ�' num2str(rate)]);
%     else
%         disp(['ʶ������' num2str(h) ' ���ʣ�' num2str(rate)]);
end   