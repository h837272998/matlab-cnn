function [net time]= mycnntrain(net, x, y, opts)  
%输入：net：初始化后的网络cnn；x：训练数组；y：训练的正确数组；训练的信息
%输出：net：经过训练后的网络cnn
    global hwait
    m = size(x, 3); % m 保存的是训练样本个数 
    disp(['样本总个数=' num2str(m)]);
    numbatches = m / opts.batchsize; 
    disp(['numbatches=' num2str(numbatches)]);
    if rem(numbatches, 1) ~= 0  
        error('numbatches not integer');  
    end  
    hwait = waitbar(1,'训练中..');
    steps = 100;

    net.rL = []; % 代价函数值，也就是误差值  
       %tic;  
    t0=cputime
    for nowstep = 1 : opts.numepochs  % 训练次数
        %disp(['次数 ' num2str(nowstep) '/' num2str(opts.numepochs)]);  
        % tic 和 toc 计算消耗时间
        str=['训练中',num2str(nowstep),'%'];
            waitbar(nowstep/steps,hwait,str);
        % 打乱所有训练循序随机训练
        kk = randperm(m);  
        for l = 1 : numbatches  
            % 取出打乱顺序后的batchsize个样本和对应的标签  kk1 kk2 kk3 
            batch_x = x(:, :, kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize));
            batch_y = y(:,  kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize)); 
  
            % 在当前的网络权值和网络输入下计算网络的输出  
            net = cnnff2(net, batch_x); % Feedforward ff算法 向前传播
            % 得到上面的网络输出后，通过对应的样本标签用bp算法来得到误差对网络权值  
            %（也就是那些卷积核的元素）的导数  
            net = cnnbp(net, batch_y); % Backpropagation bp算法
            % 得到误差对权值的导数后，就通过权值更新方法去更新权值  
            net = cnnapplygrads(net, opts);  
            if isempty(net.rL)  
                net.rL(1) = net.L; % 代价函数值，也就是均方误差值 ，在cnnbp.m中计算初始值 net.L = 1/2* sum(net.e(:) .^ 2) / size(net.e, 2);   
            end
            % 保存历史的误差值，以便画图分析....
            net.rL(end+1) = 0.99 * net.rL(end) + 0.01 * net.L;%end函数返回数组下标的最大值 
        end  
  
    end  
        %  toc;  
        time=cputime-t0
end  