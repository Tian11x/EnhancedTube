function [stability] = CosVar(LS_old,LS_new)

[I, J] = size(LS_old);
vector1 = reshape(LS_old,[1,I*J]);
vector2 = reshape(LS_new,[1,I*J]);

stability = dot(vector1,vector2)/(norm(vector1)*norm(vector2));

end

