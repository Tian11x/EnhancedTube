function [variable_list, tube_list] = Datasets_trend(tensor)
% 给定全部数据，计算统计指标
% 1. 计算全局变异系数的变化
% 2. 计算不同时段tube长度的变化(为了方便画图，真实值除以100)

[I,J,K] = size(tensor);
gal_ema = zeros(I, J);          %初始化移动均值
gal_ema_n = 3;
tube_variable = zeros(I, J);    %初始化全局变异系数
variable_list = zeros(1,K);             %用于记录variable变化
tmp = zeros(2,I,J);
tube_list = zeros(1,K);
for k = 1:K
   if k==1
      gal_ema(:,:) = tensor(:,:,k);
      tube_list(1, k) = 1;
      continue;
   end
   gal_ema = ( 2*tensor(:,:,k) + (gal_ema_n-1)*gal_ema )/(gal_ema_n+1);
   tmp(1,:,:) = tensor(:,:,k);
   tmp(2,:,:) = gal_ema;
   tube_variable = squeeze(std(tmp))./gal_ema;
   variable_list(1,k) = sum( tube_variable.*gal_ema, 'all' )/sum(gal_ema, 'all');
   if variable_list(1,k)<=0.001
       tube_list(1, k) = tube_list(1, k-1) + 1;
   elseif variable_list(1, k)>=0.02
       tube_list(1, k) = max(1, floor(tube_list(1,k-1)/2)); 
   else
       tube_list(1, k) = tube_list(1, k-1); 
   end
end
end

