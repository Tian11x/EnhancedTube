function [ ema,std_matrix ] = CoVariation( subTensor, ema )

[I, J, K] = size(subTensor);
ema_windows = min(3,K);
std_windows = min(10,K);

% 首先计算每个位置的变异系数
std_matrix = std(subTensor(:,:,K-std_windows+1:K),0,3)./mean(subTensor(:,:,K-std_windows+1:K),3);

if sum(ema)==0
   ema = subTensor(:,:,1);
end
for k=1:K
    ema = (2*subTensor(:,:,k) + (ema_windows-1)*ema)/(ema_windows+1);
end
end


