function [RSE,MAE,RMSE] = resultCal(targetTensor,Tensor)

[n1,n2,n3] = size(Tensor);
RSE = norm(Tensor(:)-targetTensor(:))/norm(targetTensor(:));
MAE = sum(sum(sum(abs(Tensor - targetTensor))))/(n1*n2*n3);
RMSE = norm(Tensor(:)-targetTensor(:))/sqrt(n1*n2*n3);
end

