function [D] = Vivaldi(Rmatrix)
% 输入不完全RTT矩阵
% 输出完全距离矩阵
[n,~] = size(Rmatrix);
CoordinateMatrix = ceil(rand(n,3)*10);
for i=1:n
   for j=1:n
      if Rmatrix(i,j)~=0 
         e = Rmatrix(i,j) - norm(CoordinateMatrix(i,:)-CoordinateMatrix(j,:));
         dir = (CoordinateMatrix(i,:)-CoordinateMatrix(j,:))/norm(CoordinateMatrix(i,:)-CoordinateMatrix(j,:));
         f = dir*e;
         CoordinateMatrix(i,:) = CoordinateMatrix(i,:) + f;
      else
          continue;
      end
   end
end
% 有了坐标之后生成距离矩阵
D = zeros(n,n);
for i=1:n-1
   for j=(i+1):n
       D(i,j) = norm(CoordinateMatrix(i,:)-CoordinateMatrix(j,:));
       D(j,i) = D(i,j);
   end
end
end

