function [IDX]=tensor_leverage_sample_entry(Tensor,Number,Beta,R)
%=========================TON==============================
%1.输入： Tensor 张量数据 Number 采样个数 R 张量的tube秩
%2.输出： IDX  测 量位置张量
%==========================================================
[I,J,K]=size(Tensor);          %获得张量的大小
sample_tensor = zeros(I,J,K);
IDX=zeros(I,J,K);              %初始化测量位置张量为全0张量
Number_each=floor(Number/K);   %张量每个面的采样个数
K1=floor( K*Beta );            %确定随机采样的面的个数
%==========随机测量部分==============%
IDX_rand=matrix_random_sample_entry(Tensor(:,:,1:K1),Number_each);  %每个面随机采样
IDX(:,:,1:K1)=IDX_rand;
sample_tensor(:,:,1:K1) = IDX_rand.*Tensor(:,:,1:K1);
%=========Leverage 测量部分=========%
for k = K1+1 : K
    [U,S,V]=t_SVD(sample_tensor(:,:,1:k-1));  %张量的tSVD
    U=U(:,1:R,:); S=S(1:R,1:R,:); V=V(:,1:R,:);  %截断 张量tSVD
    PK=zeros(I,J);    %初始化概率矩阵 
    for i = 1 : I
        for  j = 1 : J
            ui= (I/R) * sqrt( (sum(sum(U(i,1:R,:).^2))) );    %张量的行空间
            vj= (J/R) * sqrt( (sum(sum(V(j,1:R,:).^2))) );    %张量的列空间
            Lij=ui*R/I + vj*R/J - (ui*R/I)*(vj*R/I);
            PK(i,j)=log10(I*K)*Lij;   
        end
    end
    
    %按照概率大的进行采样
    for num = 1 : Number_each  %每个面的采样点的个数
        [row,col]=find( PK==max(max(PK)) );
        IDX(row(1),col(1),k)=1;   %概率最高的点进行采样
        PK(row(1),col(1))=0;      %将概率最大的点置为0
    end
    sample_tensor(:,:,k) = Tensor(:,:,k).*IDX(:,:,k);
end
%===================================%
