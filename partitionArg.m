clear;
clc;

% ����һ��10x10�����������Ϊʾ��
% load('experiment_uniform/data/LS_data');
% rank = 8; % 6 12
% % ���¼��� LS_planetLab(1:120,1:120,:);
% % LS_planetlab = LS_pattern(PlanetLab(1:120,1:120,:), rank);
% [n,~,k] = size(LS_seattle); % LS_seattle LS_planetlab
% a = randi(k);
% matrix = LS_seattle(:,:,a); % LS_seattle LS_planetlab
% [rowTrans,colTrans] = LS_rowcolTrans(matrix);
% matrix = rowTrans*matrix*colTrans;
% % ��ʼ��һ���յ������洢�ٷֱȽ��
% percentages = zeros(n, 1);
% 
% % ��������ǰr�к�ǰr�е�Ԫ�غ���ռ�İٷֱȣ�r��ȡֵΪ1��n
% for r = 1:n
%     percentages(r) = matrix_percentage(matrix, r);
% end

% ����ʵ���� PartitionPlanetLab PartitionSeattle
% save('experiment_uniform/finalResult/PartitionPlanetLab120.mat', 'percentages');
load('experiment_uniform/finalResult/PartitionSeattle.mat');
[n,~] = size(percentages);
% ����ʵ����ͼ
figure('Position', [500, 500, 500, 300]);
plot(1:n,percentages,'-','linewidth',2,'Color',[250, 104, 39]/255);
grid on;
box on;