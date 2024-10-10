function [AT]=tensor_transpose(A)
%=======张量的转置==========%
%输入：张量A, size(A)=I,J,K
%输出：张量A的转置AT , size(AT)=J,I,K
%==========================%
[I,J,K]=size(A);
AT=zeros(J,I,K);
AT(:,:,1)=A(:,:,1)';%第一个面
for k=2:K %其他的面
    AT(:,:,k)=A(:,:,K+2-k)';
end