function [IDX]=matrix_random_sample_entry(Tensor,Number,IDX)
%===================������������======================%
% ���룺 Tensor �������� Number ÿ����Ĳ��������
% ����� IDX ����λ�þ���
%======================================================%
[I,J,K]=size(Tensor); %��������Ĵ�С
if exist('IDX','var') == 0
    IDX=zeros(I,J,K);   %��ʼ������λ������ Ϊ 0 ���� 
end
for k = 1 : K
%     num = sum(IDX(:,:,k),'all');
    num = sum(sum(IDX(:,:,k)));
    % P=randperm(I*J);  %�������
    while num<Number
        % pos = P(num);
        pos = randi(I*J);
        row=floor( (pos-1)/J) +1;%�ҵ���Ӧ����
        col=mod( (pos-1),J)+1; %�ҵ���Ӧ����
        if IDX(row,col,k)==1
           continue; 
        end
        IDX(row,col,k)=1;
        num = num + 1;
    end
end