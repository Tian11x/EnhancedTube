function [Rtensor] = CallSeq(Tensor,p)

[n1,n2,k] = size(Tensor);
Rtensor = zeros(n1,n2,k);
for i=1:k
   matrix = Seaquential(Tensor(:,:,i),p); 
   Rtensor(:,:,i) = matrix;
end

end

