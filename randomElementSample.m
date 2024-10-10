function [IDX] = randomElementSample(Tensor,p)
%===================������������======================%
% ���룺 Tensor �������� Number ÿ����Ĳ��������
% ����� IDX ����λ�þ���
%======================================================%
[I,J,K]=size(Tensor); %��������Ĵ�С
IDX=zeros(I,J,K);     %��ʼ������λ������ Ϊ 0 ���� 
Number = floor(I*J*p);
for k = 1 : K
    P=randperm(I*J);  %�������
    for num=1:Number
        pos = P(num);
        row=floor( (pos-1)/J) +1;%�ҵ���Ӧ����
        col=mod( (pos-1),J)+1; %�ҵ���Ӧ����
        IDX(row,col,k)=1;
    end
end