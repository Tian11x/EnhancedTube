clear;
clc;

% ===================== Alpha
load_path = 'experiment_uniform/finalResult/AlphaTrainSeattle.mat';
load(load_path);
alpha_rses = sortrows(alpha_rses,1);
figure('Position', [500, 500, 500, 300]);
plot(alpha_rses(:,1),alpha_rses(:,2),'-*','linewidth',2,'Color',[250, 104, 39]/255);
grid on;
box on;
% h1 = legend({'0.96','0.97','0.98','0.99','0.999',},'Location','northeast');

% ================= Beta RSE
% load_path = 'experiment_uniform/finalResult/BetaTrainSeattle.mat';
% load(load_path);
% figure('Position', [500, 500, 500, 280]);
% plot(0.1:0.1:0.9,beta_rses(1,:),'-^','linewidth',2,'Color',[250, 104, 39]/255);
% hold on;
% % plot(0.1:0.1:0.9,beta_rses(2,:),'-o','linewidth',1,'Color',[150, 204, 139]/255);
% plot(0.1:0.1:0.9,beta_rses(3,:),'-<','linewidth',2,'Color',[110, 4, 139]/255);
% % plot(0.1:0.1:0.9,beta_rses(4,:),'->','linewidth',1,'Color',[18, 39, 139]/255);
% plot(0.1:0.1:0.9,beta_rses(5,:),'-*','linewidth',2,'Color',[44, 204, 139]/255);
% grid on;
% box on;
% h1 = legend({'0.96','0.98','0.999',},'Location','northeast');
% h1 = legend({'0.96','0.97','0.98','0.99','0.999',},'Location','northeast');

% ================= Beta Overhead
% load_path = 'experiment_uniform/finalResult/BetaTrainSeattle.mat';
% load(load_path);
% beta_schcost(2,:) = [];
% beta_schcost(3,:) = [];
% figure('Position', [500, 500, 500, 300]);
% bar(beta_schcost')
% grid on;
% box on;
% legend({'0.96','0.98','0.999',},'Location','northeast');


% =============================SubEffectiveness
% load_path = 'experiment_uniform/finalResult/SubEffectiveSeattle';
% load_path = 'experiment_uniform/finalResult/EffectiveSeattle';
% load_path = 'experiment_uniform/finalResult/SubEffectivePlanetLab';
% load_path = 'experiment_uniform/finalResult/EffectivePlanetLab';
% load(load_path);
% x = 0.1:0.1:0.9;
% figure('Position', [500, 500, 500, 300]);
% plot(x,ours.RSE,'-^','linewidth',2,'Color',[250, 104, 39]/255);
% hold on;
% plot(x,leverage.RSE,'-*','linewidth',2,'Color',[150, 204, 139]/255);
% plot(x,random_point.RSE,'-o','linewidth',2,'Color',[110, 4, 139]/255);
% plot(x,random_tube.RSE,'-+','linewidth',2,'Color',[18, 39, 139]/255);
% plot(x,adaptive.RSE,'-.','linewidth',2,'Color',[44, 204, 139]/255);
% plot(x,CP_ALS.RSE,'-p','linewidth',2,'Color',[150, 20, 139]/255);
% plot(x,CP_OPT.RSE,'-h','linewidth',2,'Color',[150, 44, 17]/255);
% plot(x,hosvd.RSE,'-d','linewidth',2,'Color',[150, 204, 8]/255);
% plot(x,sindinfo.RSE,'-s','linewidth',2,'Color',[143, 104, 139]/255);
% plot(x,anlp.RSE,'-<','linewidth',2,'Color',[250, 204, 139]/255);
% plot(x,seq.RSE,'->','linewidth',2,'Color',[10, 44, 39]/255);
% grid on;
% box on;
% axis([0.1 0.9 0 1]);
% h1 = legend({'ETBS','Leverage score + ADMM','Random point + ADMM','Random tube + ADMM', ... 
%     'Adaptive tube + Subspace','Random point + CP','Random point + GCP', ...
%     'Random point + Tucker','Random point + Sideinfo','Adaptive point + SVT','Random point + ASVT'},'Location','northeast');

% figure('Position', [500, 500, 500, 300]);
% sche = [9,18,18,1,1,18,18,18,18,18,18];
% bar(sche)
% grid on;
% box on;
% axis([0 12 0 20]);
% legend({'ETBS','Leverage score + ADMM','Random point + ADMM','Random tube + ADMM', ... 
%      'Adaptive tube + Subspace','Random point + CP','Random point + GCP', ...
%     'Random point + Tucker','Random point + Sideinfo','Adaptive point + SVT','Random point + ASVT'},'Location','northeast');

















