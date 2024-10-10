function [IDX] = randomElementSample(Tensor,p)
%===================面进行随机采样======================%
% 输入： Tensor 数据张量 Number 每个面的采样点个数
% 输出： IDX 采样位置矩阵
%======================================================%
[I,J,K]=size(Tensor); %获得张量的大小
IDX=zeros(I,J,K);     %初始化测量位置张量 为 0 张量 
Number = floor(I*J*p);
for k = 1 : K
    P=randperm(I*J);  %随机排序
    for num=1:Number
        pos = P(num);
        row=floor( (pos-1)/J) +1;%找到相应的行
        col=mod( (pos-1),J)+1; %找到相应的列
        IDX(row,col,k)=1;
    end
end