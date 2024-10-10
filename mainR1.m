clear;clc;
close all;

data=load('E:\2.方向论文\4.Next\2.基于张量的采样算法\2.参考文献\NetLatency-Data-master\Seattle/SeattleData.mat');
Seattle=data.data;
Tensor = Seattle; % Harvard-15 PlanetLab-12 Seattle-6
Tensor = Tensor ./ max(max(max(Tensor))); 
rank = 6;
[I, J, K] = size(Tensor);





for i = 0.1:0.1:0.9   %采样率
    %---------
end
