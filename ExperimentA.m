clear;
clc;

% load dataset
% load('experiment_uniform/data/Seattle99'); 
% load('experiment_uniform/data/Harvard226');
% load('experiment_uniform/data/PlanetLab490');
data=load('E:\2.方向论文\4.Next\2.基于张量的采样算法\2.参考文献\NetLatency-Data-master\Seattle/SeattleData.mat');
% data=load('E:\2.方向论文\4.Next\2.基于张量的采样算法\2.参考文献\NetLatency-Data-master\PlanetLab/PlanetLabData.mat');
% data=load('E:\3.数据集\Haverd\harverd/Pingsdata.mat');

Seattle=data.data;
Tensor = Seattle; % Harvard-15 PlanetLab-12 Seattle-6
Tensor = Tensor ./ max(max(max(Tensor))); 
rank = 6;
[I, J, K] = size(Tensor);

% 
macd = struct(); macd.RSE=zeros(1,9); macd.MAE=zeros(1,9); macd.RMSE=zeros(1,9); 
macd.SampleTime=zeros(1,9); macd.RecoverTime=zeros(1,9); 

macdTube = struct(); macdTube.RSE=zeros(1,9); macdTube.MAE=zeros(1,9); macdTube.RMSE=zeros(1,9); 
macdTube.SampleTime=zeros(1,9); macdTube.RecoverTime=zeros(1,9); 

leverage = struct(); leverage.RSE=zeros(1,9); leverage.MAE=zeros(1,9); leverage.RMSE=zeros(1,9); 
leverage.SampleTime=zeros(1,9); leverage.RecoverTime=zeros(1,9); 

randomTube = struct(); randomTube.RSE=zeros(1,9); randomTube.MAE=zeros(1,9); randomTube.RMSE=zeros(1,9); 
randomTube.SampleTime=zeros(1,9); randomTube.RecoverTime=zeros(1,9); 

randomEntry = struct(); randomEntry.RSE=zeros(1,9); ra0ndomEntry.MAE=zeros(1,9); randomEntry.RMSE=zeros(1,9); 
randomEntry.SampleTime=zeros(1,9); randomEntry.RecoverTime=zeros(1,9); 

% adaptive = struct(); adaptive.RSE=zeros(1,9); adaptive.MAE=zeros(1,9); adaptive.RMSE=zeros(1,9); 
% adaptive.SampleTime=zeros(1,9); adaptive.RecoverTime=zeros(1,9); 

% target_Tensor = Tensor(:,:,80:110);
target_Tensor = Tensor(:,:,1:10);
[n1,n2,n3] = size(target_Tensor);
X = 0.1:0.1:0.9;
index = 0;
fprintf('%15s %5s %15s %15s %15s %15s %15s %15s \n', 'Algorithm','p','RSE','MAE','RMSE', 'SampleTime','RecoverTime','ScheduleCount');
for i=0.1:0.1:0.9
    index = index + 1;
    % ========= macd tube off =========
    t = tic;
    [samp_Tensor, samp_Omega, scheCount] = MACDschedule( target_Tensor, i, rank, 0.1, 'tubeOn-cos', rank, 0.8, 0.8);
%     [~, samp_Omega, scheCount] = MACDschedule( target_Tensor, i, rank, 0.3, 'tubeOff' );
    sample_time = toc(t);
    t = tic;
    T_macd = tensor_ADMM(target_Tensor, samp_Omega);
    recover_time = toc(t);
    [rse,mae,rmse] = resultCal(target_Tensor,T_macd);
    macd.RSE(1,index) = rse; macd.MAE(1,index) = mae; macd.RMSE(1,index) = rmse; 
    macd.SampleTime(1,index) = sample_time; macd.RecoverTime(1,index) = recover_time;
    fprintf('%15s %5.2f %15.2f %15f %15f %15.2f %15.2f %15d \n', 'MACD-TubeOff',i,rse,mae,rmse,sample_time,recover_time,scheCount);
    % ========= macd tube on =========
%     t = tic;
%     [~, samp_Omega, scheCount] = MACDschedule( target_Tensor, i, rank, 0.3, 'tubeOn-cos' );
%     sample_time = toc(t);
%     t = tic;
%     T_macd = tensor_ADMM(target_Tensor, samp_Omega);
%     recover_time = toc(t);
%     [rse,mae,rmse] = resultCal(target_Tensor,T_macd);
%     macdTube.RSE(1,index) = rse; macdTube.MAE(1,index) = mae; macdTube.RMSE(1,index) = rmse; 
%     macdTube.SampleTime(1,index) = sample_time; macdTube.RecoverTime(1,index) = recover_time;
%     fprintf('%15s %5.2f %15.2f %15f %15f %15.2f %15.2f %15d \n', 'MACD-TubeOn',i,rse,mae,rmse,sample_time,recover_time,scheCount);
    % ========= leverage =====
    t = tic;
    L = tensor_leverage_sample_entry(target_Tensor,n1*n2*n3*i,0.3,rank); 
    sample_time = toc(t);
    t = tic;
    T_leverage = tensor_ADMM(target_Tensor,L); 
    recover_time = toc(t);
    [rse,mae,rmse] = resultCal(target_Tensor,T_leverage);
    leverage.RSE(1,index) = rse; leverage.MAE(1,index) = mae; leverage.RMSE(1,index) = rmse; 
    leverage.SampleTime(1,index) = sample_time; leverage.RecoverTime(1,index) = recover_time;
    fprintf('%15s %5.2f %15.2f %15f %15f %15.2f %15.2f %15d \n', 'Leverage',i,rse,mae,rmse,sample_time,recover_time,n3);
%     % ========= randomEntry ==
%     t = tic;
%     [B] = randomElementSample(target_Tensor,i); 
%     sample_time = toc(t);
%     t = tic;
%     T_random = tensor_ADMM(target_Tensor,B); 
%     recover_time = toc(t);
%     [rse,mae,rmse] = resultCal(target_Tensor,T_random);
%     randomEntry.RSE(1,index) = rse; randomEntry.MAE(1,index) = mae; randomEntry.RMSE(1,index) = rmse; 
%     randomEntry.SampleTime(1,index) = sample_time; randomEntry.RecoverTime(1,index) = recover_time;
%     fprintf('%15s %5.2f %15.2f %15.2f %15.2f %15d %15d \n', 'RandomEntry',i,rse,mae,rmse,sample_time,recover_time);
%     % ============ RandomTube ===========
%     t = tic;
%     [~,~,~,A] = randomTubeSample(target_Tensor,floor(n1*n2*i)); 
%     sample_time = toc(t);
%     t = tic;
%     T_randomTube = tensor_ADMM(target_Tensor,A); 
%     recover_time = toc(t);
%     [rse,mae,rmse] = resultCal(target_Tensor,T_randomTube);
%     randomTube.RSE(1,index) = rse; randomTube.MAE(1,index) = mae; randomTube.RMSE(1,index) = rmse; 
%     randomTube.SampleTime(1,index) = sample_time; randomTube.RecoverTime(1,index) = recover_time;
%     fprintf('%15s %5.2f %15.2f %15.2f %15.2f %15d %15d \n', 'RandomTube',i,rse,mae,rmse,sample_time,recover_time);
end
% save_path = 'E:\5.其他\11.王诚\1.论文最终版本（两篇）\2.EnhancedTube\代码\experiment_uniform\NewResult/Two_Harvard_New01';
% save(save_path, 'macd', 'leverage', 'randomEntry','randomTube');