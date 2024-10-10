function [LSpattern] = LS_pattern(Tensor, R)
%���ܣ���������������ÿ��λ�õĸܸ˵÷�   

% ����һ���������ݼ���ÿ��λ��leveragesore
% �������� Pingsdata
% load('experiment_leverage/data/Pingsdata');
% Tensor = data;
% [~,~,~,R] = tsvd(Tensor);
% �������� PlanetLab
% load('experiment_leverage/data/PlanetLabData_18');
% Tensor = PlanetLabData;
% R = 100;

[I,J,K] = size(Tensor);
% �洢LSģʽ
LSpattern = zeros(I,J,K);
% ���ڵ�һ����������˵��ֱ�Ӽ������LS
[U1,~,V1] = svd(Tensor(:,:,1));
U1 = U1(:,1:R,:);
V1 = V1(:,1:R,:);
for i = 1:I
    for j = 1:J
        ui= (I/R) * sqrt( (sum(sum(U1(i,:).^2))) );
        vj= (J/R) * sqrt( (sum(sum(V1(j,:).^2))) );
        Lij=ui*R/I + vj*R/J - (ui*R/I)*(vj*R/I);
        LSpattern(i,j,1)=log10(I*K)*Lij;
    end
end
% ����2-K������˵����������LS
if K>1
   for slices = 2:K
        [U,~,V]=t_SVD(Tensor(:,:,1:slices)); 
        U=U(:,1:R,:); V=V(:,1:R,:); 
        for i = 1:I
            for j = 1:J
                ui= (I/R) * sqrt( (sum(sum(U(i,:,:).^2))) );
                vj= (J/R) * sqrt( (sum(sum(V(j,:,:).^2))) );
                Lij=ui*R/I + vj*R/J - (ui*R/I)*(vj*R/I);
                LSpattern(i,j,slices)=log10(I*K)*Lij;
            end
        end
   end  
end
end

