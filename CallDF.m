function [X] = CallDF(Tensor,p)
% 输入目标张量和采样率
% 先随机点采样
% 然后调用CallDF恢复每一个矩阵
[n,~,k] = size(Tensor);
Number = floor(n*n*p);
% 阶段一，随机点采样
IDX = zeros(n,n,k);
for t=1:k
    num = 0;
    while num<Number
       pos = randi(n*n);
       row=floor( (pos-1)/n) +1;%找到相应的行
       col=mod( (pos-1),n)+1; %找到相应的列
       if IDX(row, col, t) == 0
          IDX(row,col, t) = 1;
          num = num + 1;
       end
    end
end
X = zeros(n,n,k);
% 阶段二，恢复
for t=1:k
   X(:,:,t) = DisAndFea(IDX(:,:,t).*Tensor(:,:,t)); 
end
end

