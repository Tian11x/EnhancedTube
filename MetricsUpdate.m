function [ slow_ema, fast_ema, ema, macd, tube_variable ] = MetricsUpdate( subTensor, slow_ema, fast_ema, ema )

% ´°¿Ú³¤¶È
ema_windows = 3;
slow_windows = 2;
fast_windows = 6;

[I, J, K] = size(subTensor);
tube_variable = zeros(I,J);
if sum(ema)==0
   slow_ema = subTensor(:,:,1);
   fast_ema = subTensor(:,:,1);
   ema = subTensor(:,:,1);
end
for k=1:K
    for i=1:I
       for j=1:J
          tube_variable(i,j) = std([ema(i,j),subTensor(i,j,k)])/mean([ema(i,j),subTensor(i,j,k)]); 
       end
    end
    ema = (2*subTensor(:,:,k) + (ema_windows-1)*ema)/(ema_windows+1);
    slow_ema = (2*subTensor(:,:,k) + (slow_windows-1)*slow_ema)/(slow_windows+1);
    fast_ema = (2*subTensor(:,:,k) + (fast_windows-1)*fast_ema)/(fast_windows+1);
end
macd = (slow_ema./fast_ema).*ema;
end

