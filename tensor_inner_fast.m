function [T]=tensor_inner_fast(A,B,C)
%==============张量快速内积====================%
%输入：A B C 三个因子矩阵 ，size: I*R J*R K*R
%输出：T 张量 ，size:I*J*K
%==============================================%
[~,R]=size(A);%获得张量的秩 R
lambda=ones(1,R);%生成一个权重向量，权重全部为1，进而可以直接利用ktensor重构
T=ktensor(lambda',A,B,C);%cp分解中，自带的张量重构函数，速度快
T=double(T);