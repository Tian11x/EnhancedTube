function [samp_Tensor, samp_Omega, tube_list] = MACDschedule( Tensor, p, R, Beta, opt, u, alpha, beta)
% ==========================
% 1. 输入：张量、采样率、张量秩、冷启动比例
% 调度流程如下：
%           （1）初始化统计指标矩阵、全局变异系数
%           （2）每采样一个张量，根据采样值计算杠杆值的估计，用于更新指标
%           （3）更新统计指标矩阵、变异系数
% 2. 输出：采样张量、采样算子
% ==========================
[I,J,K] = size(Tensor);         %获得张量的大小
samp_Tensor = zeros(I,J,K);     %初始化采样算子
samp_Omega = zeros(I,J,K);      %初始化测量位置张量为全0张量
Number_each = floor( I*J*p );   %张量每个面的采样个数
K1 = floor( K*Beta );           %前K1个面用于冷启动
tube_list = 0;                 %用于记录tube长度变化

round = 'false'; % 是否在每次round结束后，填充张量
if strcmp(round, 'true')
   rec_Tensor = zeros(I,J,K);
end

% ========== 阶段一：随机测量部分 ==============
for i = 1:K1
   tube_list = tube_list + 1;
   tmp_Omega = matrix_random_sample_entry( Tensor(:,:,i), Number_each );
   samp_Omega(:,:,i) = tmp_Omega(:,:,1);                    %更新采样算子
   samp_Tensor(:,:,i) = Tensor(:,:,i).*tmp_Omega(:,:,1);    %更新采样张量
end

% 每一次采样之后，填充张量，然后再进行下一阶段
if strcmp(round, 'true')
   Recovered = tensor_ADMM(Tensor(:,:,1:K1), samp_Omega(:,:,1:K1)); 
   rec_Tensor(:,:,1:K1) = Recovered(:,:,:);
   tmp_LSpattern = LS_pattern(rec_Tensor(:,:,1:K1), R);
else
   tmp_LSpattern = LS_pattern(samp_Tensor(:,:,1:K1), R);     %计算到目前为止采样张量的杠杆值
end



% 区域划分，只需要划分一次，接下来每次采样做一次逆变换
[area1, area2] = AreaDivision(I,J,u);

% ========== 阶段二：杠杆值测量部分 ==============
i = K1 + 1;
tube_length = 1;      %初始tube采样长度
while i<=K
   if (i+tube_length-1)>K
      tube_length = K-i+1;
   end
   tube_list = tube_list + 1;
   
   [ tmp_Omega ] = AreaSample( tmp_LSpattern(:,:,i-1), p, area1, area2, alpha ); % 采样
   
   tmp_Omega_tube = repmat(tmp_Omega,[1,1,tube_length]);    %将其扩展为tube_length的采样算子
   samp_Omega(:,:,i:i+(tube_length-1)) = tmp_Omega_tube;    %更新采样算子
   samp_Tensor(:,:,i:i+(tube_length-1)) = Tensor(:,:,i:i+(tube_length-1)).*tmp_Omega_tube;     %更新采样张量
   
   % 填充张量
   
   if strcmp(round, 'true')
       Recovered = tensor_ADMM(Tensor(:,:,i:i+(tube_length-1)), tmp_Omega_tube);
       rec_Tensor(:,:,i:i+(tube_length-1)) = Recovered(:,:,:);
       tmp_LSpattern = LS_pattern(rec_Tensor(:,:,1:i+(tube_length-1)), R);
    else
       tmp_LSpattern = LS_pattern(samp_Tensor(:,:,1:i+(tube_length-1)), R);     %计算到目前为止采样张量的杠杆值
    end

   i = i + tube_length;                                     %更新循环变量
   % ========== 问题：如何用余弦相似度决定下一步的tube_length ============
   if strcmp(opt, 'tubeOn-cos') % 用 cos 来衡量网络稳定性
       [stability] = CosVar(tmp_LSpattern(:,:,end-1), tmp_LSpattern(:,:,end));
       if stability>=beta
         tube_length = tube_length + 1;
      elseif stability < beta
         tube_length = max( 1, floor(tube_length/2) );
      end
   end
end

if strcmp(round, 'true')
   samp_Tensor = rec_Tensor; 
end

end

