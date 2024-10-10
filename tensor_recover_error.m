function [train_error,test_error]=tensor_recover_error(X,Xhat,IDX)
%================�����ع�������==========================%
%���룺 X ԭʼ�������� Xhat�ع��������� IDX ����λ������
%����� sample_error ѵ�����  unsample_error �������
%=========================================================%
UIDX=ones(size(X))-IDX;
% train_error=( sum(sum(sum( abs(X-Xhat).*IDX ))) / sum(sum(sum( abs(X).*IDX ))) );
% test_error=( sum(sum(sum( abs(X-Xhat).*UIDX ))) / sum(sum(sum( abs(X).*UIDX ))) );
train_error=sqrt( sum(sum(sum( (X-Xhat).^2.*IDX ))) / sum(sum(sum( (X).^2.*IDX ))) );
test_error=sqrt( sum(sum(sum( (X-Xhat).^2.*UIDX ))) / sum(sum(sum( (X).^2.*UIDX ))) );