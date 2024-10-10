function [IDX]=tensor_random_sample_tube(IDX,Number)    
%=================������� tube ����==============
%���룺IDX����λ�������� Number ���������� 
%�����IDX ����λ��������
%===============================================
[I,J,~]=size(IDX);                  %��������Ĵ�С
EachSlice_number=floor(Number/J);   %ƽ��ÿ��slice�ϲ������ٸ�fiber
for j =1:J
    P=randperm(I);%�������˳��
    for num=1:EachSlice_number
        pos=P(num);
        IDX(pos,j,:)=1; %����ֻ�Ե�һ������в�������Ϊ�����һ��
    end
end