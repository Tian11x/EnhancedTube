clear;clc;
close all;

data=load('E:\2.��������\4.Next\2.���������Ĳ����㷨\2.�ο�����\NetLatency-Data-master\Seattle/SeattleData.mat');
Seattle=data.data;
Tensor = Seattle; % Harvard-15 PlanetLab-12 Seattle-6
Tensor = Tensor ./ max(max(max(Tensor))); 
rank = 6;
[I, J, K] = size(Tensor);





for i = 0.1:0.1:0.9   %������
    %---------
end
