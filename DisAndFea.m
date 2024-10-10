function [X] = DisAndFea(Matrix)
% 输入不完全测量矩阵
% 首先用Vivaldi生成完全距离矩阵和不完全特征矩阵
% 然后填充不完全特征矩阵
[n,~] = size(Matrix);
D = Vivaldi(Matrix); %调用Vivaldi生成距离矩阵
F = zeros(n,n); 
for i=1:n
   for j=1:n
      if (i~=j) && Matrix(i,j)~=0
         F(i,j) = Matrix(i,j)/D(i,j); 
      end
   end
end
% 恢复F 相当于多轮的SVT
maxIter = 5;
Fi = F;
for i=1:maxIter
   Fi = SVT(Fi,0.1); 
end
F = Fi;
% 有了D和F之后，恢复目标矩阵
X = D.*F;
end

