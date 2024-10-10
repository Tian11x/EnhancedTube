function [IDX]=tensor_leverage_sample_entry(Tensor,Number,Beta,R)
%=========================TON==============================
%1.���룺 Tensor �������� Number �������� R ������tube��
%2.����� IDX  �� ��λ������
%==========================================================
[I,J,K]=size(Tensor);          %��������Ĵ�С
sample_tensor = zeros(I,J,K);
IDX=zeros(I,J,K);              %��ʼ������λ������Ϊȫ0����
Number_each=floor(Number/K);   %����ÿ����Ĳ�������
K1=floor( K*Beta );            %ȷ�������������ĸ���
%==========�����������==============%
IDX_rand=matrix_random_sample_entry(Tensor(:,:,1:K1),Number_each);  %ÿ�����������
IDX(:,:,1:K1)=IDX_rand;
sample_tensor(:,:,1:K1) = IDX_rand.*Tensor(:,:,1:K1);
%=========Leverage ��������=========%
for k = K1+1 : K
    [U,S,V]=t_SVD(sample_tensor(:,:,1:k-1));  %������tSVD
    U=U(:,1:R,:); S=S(1:R,1:R,:); V=V(:,1:R,:);  %�ض� ����tSVD
    PK=zeros(I,J);    %��ʼ�����ʾ��� 
    for i = 1 : I
        for  j = 1 : J
            ui= (I/R) * sqrt( (sum(sum(U(i,1:R,:).^2))) );    %�������пռ�
            vj= (J/R) * sqrt( (sum(sum(V(j,1:R,:).^2))) );    %�������пռ�
            Lij=ui*R/I + vj*R/J - (ui*R/I)*(vj*R/I);
            PK(i,j)=log10(I*K)*Lij;   
        end
    end
    
    %���ո��ʴ�Ľ��в���
    for num = 1 : Number_each  %ÿ����Ĳ�����ĸ���
        [row,col]=find( PK==max(max(PK)) );
        IDX(row(1),col(1),k)=1;   %������ߵĵ���в���
        PK(row(1),col(1))=0;      %���������ĵ���Ϊ0
    end
    sample_tensor(:,:,k) = Tensor(:,:,k).*IDX(:,:,k);
end
%===================================%
