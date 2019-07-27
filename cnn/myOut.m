function h = myOut(net, x)  
    net = cnnff2(net, x); % ff前向传播得到输出 
    [rate, h] = max(net.o); % 找到每列（一列表示一个测试样本）最大的输出对应的标签  
   % h = h;
   % result = data(h);

%     if rate <0.45
%         disp(['识别结果（可能出错）：' num2str(h)  ' 概率：' num2str(rate)]);
%     else
%         disp(['识别结果：' num2str(h) ' 概率：' num2str(rate)]);
end   