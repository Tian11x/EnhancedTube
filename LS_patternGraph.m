clear;
clc;

% step1：首先绘制历史数据的每个slice的leverageScore之间是否存在联系
% 1.1 在PingsData上测试
% load('experiment_leverage/result/PingsDataLSLpattern');
% for s = 1:6
%    subplot(2,3,s); imagesc(LSpattern(:,:,s)); 
% end
% 1.2 在PlanetLab 上进行测试
load('experiment_leverage/result/PlanetLabLSLpattern');
% for s = 1:9
%    subplot(2,3,s); imagesc(LSpattern(:,:,s)); 
% end
% 1.3 在Seattle上进行测试


% step2 选定第一个面重新排序，得到行列变换矩阵，然后用于后续的面
period = 6;
slice = 6;
index = 1;
for s = 1:slice
    % 先根据第slice个基准面构造行列矩阵
    [rowTrans,colTrans] = LS_rowcolTrans(LSpattern(:,:,s));
    subplot(slice,period+1,index); imagesc(LSpattern(:,:,s)); index = index + 1;
    for p = 1:period
        X = rowTrans*LSpattern(:,:,s+p-1)*colTrans;
        subplot(slice,period+1,index); imagesc(X); index = index + 1;
    end
end

% step3 实验验证
% 在 Pingsdata 数据集上测试 ,先测试 period=4
% load('experiment_leverage/data/Pingsdata');
% PriTensor = data(:,:,1:6);
% Tensor = data(:,:,7:12);
% [n1,n2,n3] = size(Tensor);
% R = 13; % 估计秩
% p = 0.2;
% % 密度采样
% [Omega, ~] = LS_uniform_sample_tubes(PriTensor, R, Tensor, p);
% % leverage score 采样
% [IDX_L]=tensor_leverage_sample_entry(Tensor,n1*n2*n3*p,0.5,R); 
% % 真实情况
% [True_Pattern] = LS_pattern(data(:,:,1:12), R);
% % 绘制采样模式
% for i = 1:n3
%    subplot(3,n3,i); imagesc(Omega(:,:,i)); 
% end
% for i = 1:n3
%    subplot(3,n3,n3+i); imagesc(True_Pattern(:,:,6+i)); 
% end
% for i = 1:n3
%    subplot(3,n3,2*n3+i); imagesc(IDX_L(:,:,i)); 
% end



