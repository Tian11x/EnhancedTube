function [T_recover]=tensor_ADMM(Tensor,IDX, sigma)
%========ADMM求解张量==================%
%1.输入： Tensor 原始张量数据 IDX 采样位置张量  参数 rho
%2.输出： T_recover 重构张量数据
%======================================%
[I,J,K]=size(Tensor);  % 获得张量的大小
UIDX=ones(I,J,K)-IDX;  % 非观测的张量位置 
Y=Tensor.*IDX;         % 张量的观测部分
sigma=0.1;
%====1.初始化=======%
X=zeros(I,J,K); Z=zeros(I,J,K); B=zeros(I,J,K);
converge=0;   %不收敛   
iteration=1; %迭代次数
maxIter=10;
error=0;
tol=10^-5;
% 记录：1. PlanetLab: sigma = 0.9, maxIter = 10
% : 2. Seattle sigma = 0.1 maxIter = 100
%===================%
U=zeros(I,I,K); S=zeros(I,J,K); V=zeros(J,J,K);
while ~converge
    X= UIDX .* (Z-B) + Y;  % 无噪声的情况下
    M=X+B; %中间变量
    D=M;   %中间变量, 用于 tsvd 分解
    %======= 张量TSVD分解 ============%
    D=fft(D,[],3);  %对第3维度做傅里叶变换
    for k = 1 : K
        [u,s,v]=svd(D(:,:,k));  %对第k个面做svd分解
        s=sign(s).*max(abs(s)-sigma,0);  %shrink 操作
        Z(:,:,k)=u*s*v';   %重构
        U(:,:,k)=u; S(:,:,k)=s; V(:,:,k)=v;
    end 
    U=ifft(U,[],3);  S=ifft(S,[],3); V=ifft(V,[],3); %反傅里叶变换
    Z=ifft(Z,[],3);
    B=B+X-Z;
    if  iteration>maxIter
        converge=1;
    end
    iteration=iteration+1;
end
T_recover=X;
