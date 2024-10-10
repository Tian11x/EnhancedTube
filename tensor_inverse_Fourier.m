function [T2]=tensor_inverse_Fourier(T1)
%==============张量求逆====================%
%输入：张量 T1   size(T1): I,J,K
%输出：逆张量 T2 size(T2): J,I,K
%==========================================%
[I,J,K]=size(T1);  %获得张量大小
T1=fft(T1,[],3);   %傅里叶变换
T2=zeros(J,I,K);   %初始化 逆张量
for k = 1 : K
    T2(:,:,k)=pinv(T1(:,:,k));
end
T2=ifft(T2,[],3);