function [variable_list, tube_list] = Datasets_trend(tensor)
% ����ȫ�����ݣ�����ͳ��ָ��
% 1. ����ȫ�ֱ���ϵ���ı仯
% 2. ���㲻ͬʱ��tube���ȵı仯(Ϊ�˷��㻭ͼ����ʵֵ����100)

[I,J,K] = size(tensor);
gal_ema = zeros(I, J);          %��ʼ���ƶ���ֵ
gal_ema_n = 3;
tube_variable = zeros(I, J);    %��ʼ��ȫ�ֱ���ϵ��
variable_list = zeros(1,K);             %���ڼ�¼variable�仯
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

