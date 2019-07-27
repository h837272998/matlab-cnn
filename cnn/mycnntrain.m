function [net time]= mycnntrain(net, x, y, opts)  
%���룺net����ʼ���������cnn��x��ѵ�����飻y��ѵ������ȷ���飻ѵ������Ϣ
%�����net������ѵ���������cnn
    global hwait
    m = size(x, 3); % m �������ѵ���������� 
    disp(['�����ܸ���=' num2str(m)]);
    numbatches = m / opts.batchsize; 
    disp(['numbatches=' num2str(numbatches)]);
    if rem(numbatches, 1) ~= 0  
        error('numbatches not integer');  
    end  
    hwait = waitbar(1,'ѵ����..');
    steps = 100;

    net.rL = []; % ���ۺ���ֵ��Ҳ�������ֵ  
       %tic;  
    t0=cputime
    for nowstep = 1 : opts.numepochs  % ѵ������
        %disp(['���� ' num2str(nowstep) '/' num2str(opts.numepochs)]);  
        % tic �� toc ��������ʱ��
        str=['ѵ����',num2str(nowstep),'%'];
            waitbar(nowstep/steps,hwait,str);
        % ��������ѵ��ѭ�����ѵ��
        kk = randperm(m);  
        for l = 1 : numbatches  
            % ȡ������˳����batchsize�������Ͷ�Ӧ�ı�ǩ  kk1 kk2 kk3 
            batch_x = x(:, :, kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize));
            batch_y = y(:,  kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize)); 
  
            % �ڵ�ǰ������Ȩֵ�����������¼�����������  
            net = cnnff2(net, batch_x); % Feedforward ff�㷨 ��ǰ����
            % �õ���������������ͨ����Ӧ��������ǩ��bp�㷨���õ���������Ȩֵ  
            %��Ҳ������Щ����˵�Ԫ�أ��ĵ���  
            net = cnnbp(net, batch_y); % Backpropagation bp�㷨
            % �õ�����Ȩֵ�ĵ����󣬾�ͨ��Ȩֵ���·���ȥ����Ȩֵ  
            net = cnnapplygrads(net, opts);  
            if isempty(net.rL)  
                net.rL(1) = net.L; % ���ۺ���ֵ��Ҳ���Ǿ������ֵ ����cnnbp.m�м����ʼֵ net.L = 1/2* sum(net.e(:) .^ 2) / size(net.e, 2);   
            end
            % ������ʷ�����ֵ���Ա㻭ͼ����....
            net.rL(end+1) = 0.99 * net.rL(end) + 0.01 * net.L;%end�������������±�����ֵ 
        end  
  
    end  
        %  toc;  
        time=cputime-t0
end  