function [train_error,test_error]=tensor_recover_error(X,Xhat,IDX)
%================张量重构误差计算==========================%
%输入： X 原始数据张量 Xhat重构数据张量 IDX 采样位置张量
%输出： sample_error 训练误差  unsample_error 测试误差
%=========================================================%
UIDX=ones(size(X))-IDX;
% train_error=( sum(sum(sum( abs(X-Xhat).*IDX ))) / sum(sum(sum( abs(X).*IDX ))) );
% test_error=( sum(sum(sum( abs(X-Xhat).*UIDX ))) / sum(sum(sum( abs(X).*UIDX ))) );
train_error=sqrt( sum(sum(sum( (X-Xhat).^2.*IDX ))) / sum(sum(sum( (X).^2.*IDX ))) );
test_error=sqrt( sum(sum(sum( (X-Xhat).^2.*UIDX ))) / sum(sum(sum( (X).^2.*UIDX ))) );