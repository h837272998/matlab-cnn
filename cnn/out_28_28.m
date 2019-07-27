function train_one = out_28_28(ima2);
        y_w = size(ima2,1)-1;  %  size和stats 大小有区别？？？
        x_w = size(ima2,2)-1;
        themax = max(x_w,y_w);

        theOne_img = double(ima2);
        %theOne_img2 = zeros(themax,themax);
         if y_w>x_w
            A = zeros(y_w+1,ceil((y_w-x_w)/3));
            theOne_img = [A,theOne_img,A];
%             if ceil((y_w-x_w)/3)-floor((y_w-x_w)/3) >0%奇数
%                  m = 2;
%             else
%                 m=1;
%             end
%             B = zeros(4,ceil((y_w-x_w)/3)*2+x_w);
%             theOne_img = [B;theOne_img;B];
         else
          A = zeros(ceil((x_w-y_w)*5/8),x_w+1);
          theOne_img = [A;theOne_img;A];
           % if ceil((y_w-x_w)*5/8)-floor((y_w-x_w)*5/8) >0%偶数
                %m = 2;
            %else
               % m=1;
            %end
            %B = zeros(x_w+m,4);
            B = zeros(ceil((x_w-y_w)*5/8)*2+y_w+1,5);
            theOne_img = [B,theOne_img,B];
         end
         theOne_img = imresize(theOne_img,[26,26]);
         train_one = zeros(28,28);
         train_one(2:27,2:27)=theOne_img;