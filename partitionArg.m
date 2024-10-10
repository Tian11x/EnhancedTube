clear;
clc;

% 生成一个10x10的随机矩阵作为示例
% load('experiment_uniform/data/LS_data');
% rank = 8; % 6 12
% % 重新计算 LS_planetLab(1:120,1:120,:);
% % LS_planetlab = LS_pattern(PlanetLab(1:120,1:120,:), rank);
% [n,~,k] = size(LS_seattle); % LS_seattle LS_planetlab
% a = randi(k);
% matrix = LS_seattle(:,:,a); % LS_seattle LS_planetlab
% [rowTrans,colTrans] = LS_rowcolTrans(matrix);
% matrix = rowTrans*matrix*colTrans;
% % 初始化一个空的向量存储百分比结果
% percentages = zeros(n, 1);
% 
% % 计算矩阵的前r行和前r列的元素和所占的百分比，r的取值为1到n
% for r = 1:n
%     percentages(r) = matrix_percentage(matrix, r);
% end

% 保存实验结果 PartitionPlanetLab PartitionSeattle
% save('experiment_uniform/finalResult/PartitionPlanetLab120.mat', 'percentages');
load('experiment_uniform/finalResult/PartitionSeattle.mat');
[n,~] = size(percentages);
% 绘制实验结果图
figure('Position', [500, 500, 500, 300]);
plot(1:n,percentages,'-','linewidth',2,'Color',[250, 104, 39]/255);
grid on;
box on;