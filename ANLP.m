function [D] = ANLP(T,p)
%输入：原始张量T , 采样率 p, 张量的秩
%输出：重构张量T_recover
%====================================
[n1,n2,n3] = size(T);
% K = 32;
% L = 2;
% P = 5;
sample_number = floor(n1*n2*p);
% n = floor(sample_number/(K+L*P));
J = zeros(n1,n2,n3);
Q = zeros(n1,n2,n3);
Y = zeros(n1,n2,n3);
D = zeros(n1,n2,n3);
lambda = 0.3;
mue = 0.6;
% ======== 第一个时刻 初始化 =======
IDX_ = new_matrix_sample(n1,n2,sample_number);
J(:,:,1) = IDX_;
% nIDX = randperm(n1,n);
% for i=1:n
%    KIDX = randperm(n2,K+L*P);
%    J(nIDX(i),KIDX,1) = 1;
% end

Q(:,:,1) = T(:,:,1).*J(:,:,1);
D(:,:,1) = ASVT(Q(:,:,1),lambda);
Y(:,:,1) = 0; 
% ======= 后续时刻 ==========
for t=2:n3
%     nIDX = randperm(n1,n);
%     for i=1:n
%        KIDX = randperm(n2,K+L*P);
%        J(nIDX(i),KIDX,t) = 1;
%     end
    IDX_ = new_matrix_sample(n1,n2,sample_number);
    J(:,:,t) = IDX_;
    Q(:,:,t) = T(:,:,t).*J(:,:,t);
    Y(:,:,t) = Y(:,:,t-1) + mue*(J(:,:,t-1).*(Q(:,:,t-1)-D(:,:,t-1)));
    D(:,:,t) = ASVT(Y(:,:,t), lambda);
end
end

