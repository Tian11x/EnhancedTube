function [samp_Omega] = AreaSample(samp_macd, p,sampleRange1,sampleRange2,percent)

[I, J] = size(samp_macd);
samp_num = floor(I*J*p);
samp_Omega = zeros(I, J); % 初始化采样算子
[rowTrans, colTrans] = LS_rowcolTrans(samp_macd); % 行列变换矩阵

% percent = 0.8;
if floor(samp_num*percent)>length(sampleRange1) % 不同区域采样数目划分
    sampleNum1 = length(sampleRange1);
else
    sampleNum1 = floor(samp_num*percent);
end
sampleNum2 = samp_num - sampleNum1;
 
% 3. 分区域随机采样
sample1 = randperm(length(sampleRange1), sampleNum1);
for i = 1:sampleNum1 
    index = sampleRange1( sample1(i) );
    [indexi, indexj] = ind2sub(size(samp_Omega), index);  
    samp_Omega(indexi,indexj) = 1; 
end
sample2 = randperm(length(sampleRange2), sampleNum2);  
for i = 1:sampleNum2 
    index = sampleRange2( sample2(i) );
    [indexi, indexj] = ind2sub(size(samp_Omega), index);  
    samp_Omega(indexi,indexj) = 1; 
end
% 4. 将samp_Omega运用 rowTrans 和 colTrans 转回正常模式
samp_Omega = inv(rowTrans)*samp_Omega*inv(colTrans);
end

