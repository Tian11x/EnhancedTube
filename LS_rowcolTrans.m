function [rowTrans,colTrans] = LS_rowcolTrans(Matrix)

% �������Ϊһ����������þ�������б任����
% ˼����LS pattern �Ƿ�����ʱ����ص�Ǳ��ģʽ
% 1. ������ֵ�ľۼ����ҵĸ������ľ��ο�
% 2. ���������澭��ͬ����������ϣ��Ƿ�Ҳ���ֳ����Ƶ�ģʽ�أ�
% ���ȸ��ݵ�2���湹�������о���
% ��һ������ڶ�������ϴ�
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
% ���������о���
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

