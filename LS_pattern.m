function [LSpattern] = LS_pattern(Tensor, R)
%功能：输入张量，计算每个位置的杠杆得分   

% 任务一：计算数据集的每个位置leveragesore
% 加载数据 Pingsdata
% load('experiment_leverage/data/Pingsdata');
% Tensor = data;
% [~,~,~,R] = tsvd(Tensor);
% 加载数据 PlanetLab
% load('experiment_leverage/data/PlanetLabData_18');
% Tensor = PlanetLabData;
% R = 100;

[I,J,K] = size(Tensor);
% 存储LS模式
LSpattern = zeros(I,J,K);
% 对于第一个张量面来说，直接计算矩阵LS
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
% 对于2-K个面来说，计算张量LS
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

