function [IDX]=matrix_random_sample_entry(Tensor,Number,IDX)
%===================面进行随机采样======================%
% 输入： Tensor 数据张量 Number 每个面的采样点个数
% 输出： IDX 采样位置矩阵
%======================================================%
[I,J,K]=size(Tensor); %获得张量的大小
if exist('IDX','var') == 0
    IDX=zeros(I,J,K);   %初始化测量位置张量 为 0 张量 
end
for k = 1 : K
%     num = sum(IDX(:,:,k),'all');
    num = sum(sum(IDX(:,:,k)));
    % P=randperm(I*J);  %随机排序
    while num<Number
        % pos = P(num);
        pos = randi(I*J);
        row=floor( (pos-1)/J) +1;%找到相应的行
        col=mod( (pos-1),J)+1; %找到相应的列
        if IDX(row,col,k)==1
           continue; 
        end
        IDX(row,col,k)=1;
        num = num + 1;
    end
end