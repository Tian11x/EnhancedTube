function [AT]=tensor_transpose(A)
%=======������ת��==========%
%���룺����A, size(A)=I,J,K
%���������A��ת��AT , size(AT)=J,I,K
%==========================%
[I,J,K]=size(A);
AT=zeros(J,I,K);
AT(:,:,1)=A(:,:,1)';%��һ����
for k=2:K %��������
    AT(:,:,k)=A(:,:,K+2-k)';
end