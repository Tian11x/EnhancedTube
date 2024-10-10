function [res] = data_trend(nums, type, co_variable)
%COMPUTE_MA 此处显示有关此函数的摘要
%   计算MA指标
[I,J] = size(nums);
res = zeros(I,J);
if strcmp(type, 'A')
   for i=1:I
       for j=1:J
           if j==1
               res(i,j) = nums(i,j);
           else
               res(i, j) = (res(i, j-1) + nums(i,j))/2;
           end
           
       end
   end 
elseif strcmp(type, 'MA')
    ma_n = 3;
    for i=1:I
       for j=1:J
           if j<ma_n
               res(i, j) = nums(i, j);
           else
              for k=1:ma_n
                 res(i, j) = res(i, j) + nums(i, j-k+1); 
              end
              res(i, j) = res(i, j)/ma_n;
           end
       end
    end
elseif strcmp(type, 'EMA')
    ema_n = 2;
    for i=1:I
       for j=1:J
           if j<=1
              res(i, j) = nums(i, j);
           else
              res(i, j) = (2*nums(i,j) + (ema_n-1)*res(i, j-1))/(ema_n+1);
           end
       end
    end 
elseif strcmp(type, 'MACD')
    ema_n1 = 2;
    ema_n2 = 6;
    ema_n3 = 3;
    slow_ema = [];
    fast_ema = [];
    ema = [];
    ma = [];
    for i=1:I
       for j=1:J
          if j<=1
             slow_ema(i, j) = nums(i, j); 
             fast_ema(i, j) = nums(i, j);
             ema(i,j) = nums(i,j);
             ma(i,j) = nums(i,j);
             res(i,j) = ema(i,j);
          else
             slow_ema(i, j) = (2*nums(i,j) + (ema_n1-1)*slow_ema(i, j-1))/(ema_n1+1); 
             fast_ema(i, j) = (2*nums(i,j) + (ema_n2-1)*fast_ema(i, j-1))/(ema_n2+1); 
             ema(i, j) = (2*nums(i,j) + (ema_n3-1)*ema(i, j-1))/(ema_n3+1); 
             ma(i,j) = (ma(i,j-1)+nums(i,j))/2;
             res(i,j) = (slow_ema(i, j)/fast_ema(i,j))*ema(i,j);
          end
       end
    end
elseif strcmp(type, 'STD_MEAN')
   ema = [];
   ema_n3 = 3;
   ma = [];
   for i=1:I
       for j=1:J
          if j<=1
             res(i,j) = 0;
             ma(i,j) = nums(i,j);
             ema(i,j) = nums(i,j);
          else
             ma(i,j) = (ma(i,j-1)+nums(i,j))/2;
             ema(i, j) = (2*nums(i,j) + (ema_n3-1)*ema(i, j-1))/(ema_n3+1);
             res(i,j) = std([ema(i,j-1),nums(i,j)])/ema(i,j);
          end
       end
   end
   tmp = zeros(1,J);
   for j=2:J
      tmp(1,j) = sum( ema(:,j).*res(:,j), 'all' )/sum( ema(:,j), 'all' ); % /sum( ema(:,j), 'all' )
   end
   res = tmp;
end

end

