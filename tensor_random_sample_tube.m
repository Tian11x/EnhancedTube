function [IDX]=tensor_random_sample_tube(IDX,Number)    
%=================随机采样 tube 函数==============
%输入：IDX测量位置张量； Number 采样个数； 
%输出：IDX 测量位置张量；
%===============================================
[I,J,~]=size(IDX);                  %获得张量的大小
EachSlice_number=floor(Number/J);   %平均每个slice上采样多少个fiber
for j =1:J
    P=randperm(I);%随机排列顺序
    for num=1:EachSlice_number
        pos=P(num);
        IDX(pos,j,:)=1; %这里只对第一个面进行采样，因为后面的一样
    end
end