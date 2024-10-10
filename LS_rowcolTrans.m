function [rowTrans,colTrans] = LS_rowcolTrans(Matrix)

% 输入参数为一个矩阵，输出该矩阵的行列变换算子
% 思考：LS pattern 是否有与时间相关的潜在模式
% 1. 先做大值的聚集，找的概率最大的矩形块
% 2. 接下来的面经过同样的行列组合，是否也呈现出相似的模式呢？
% 首先根据第2个面构造行排列矩阵
% 第一个面与第二个面差距较大
M = Matrix;
[I,J] = size(M);
rowTrans = zeros(I,I);
colTrans = zeros(J,J);
for i = 1:I
   maxIndexI = i;
   maxRowNorm = norm(M(i,:));
   for ii = 1:I
      if norm(M(ii,:)) > maxRowNorm
         maxIndexI = ii;
         maxRowNorm = norm(M(ii,:));
      end
   end
   M(maxIndexI,:) = 0;
   rowTrans(i,maxIndexI) = 1;
end
% 构造列排列矩阵
M = Matrix;
for j = 1:J
   maxIndexJ = j; 
   maxColNorm = norm(M(:,j));
   for jj = 1:J
      if norm(M(:,jj)) > maxColNorm
         maxIndexJ = jj;
         maxColNorm = norm(M(:,jj));
      end
   end
   M(:,maxIndexJ) = 0;
   colTrans(maxIndexJ,j) = 1;
end
end

