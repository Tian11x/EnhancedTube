function [Matrix]=KR_product(matrix1,matrix2)
%======KR�� code ===================================%
%===================================================%
[I,K]=size(matrix1);
[J,~]=size(matrix2);
Matrix=zeros(I*J,K);
for k=1:K    %KΪ������������
    Matrix(:,k)=kron(matrix1(:,k),matrix2(:,k));
end

