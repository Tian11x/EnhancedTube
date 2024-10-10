clear;
clc;
warning('off');

Dataset = 'Seattle';
% change dataset
if strcmp(Dataset, 'Seattle')
    data_path = 'experiment_uniform/data/Seattle99';
    load(data_path);  % load data
    Tensor = Seattle;
    Tensor = Tensor ./ max(max(max(Tensor))); 
    Target = Tensor(:,:,80:139);
    rank = 8;
    u = 8;
    % loading alpha value
    load('experiment_uniform/finalResult/AlphaTrainSeattle.mat');
    load('experiment_uniform/finalResult/SubEffectiveSeattle.mat');
    save_path = 'experiment_uniform/finalResult/SubEffectiveSeattle.mat';
elseif strcmp(Dataset, 'PlanetLab')
    data_path = 'experiment_uniform/data/PlanetLab490';
    load(data_path);  % load data
    Tensor = PlanetLab;
    Tensor = Tensor ./ max(max(max(Tensor))); 
    Target = Tensor(:,:,1:18);
    rank = 12;
    u = 47;
    % loading alpha value
    load('experiment_uniform/finalResult/AlphaTrainPlanetLab.mat');
    load('experiment_uniform/finalResult/SubEffectivePlanetLab.mat');
    save_path = 'experiment_uniform/finalResult/SubEffectivePlanetLab.mat';
end



% para init
[m, n, k] = size(Target);
alpha = out_alpha;
beta = -1;

% sampling step
sample_step = 0.1;

% store result
% ours = init_struct();
% leverage = init_struct();
% random_point = init_struct();
% random_tube = init_struct();
adaptive = init_struct();
% CP_ALS = init_struct();
% CP_OPT = init_struct();
% hosvd = init_struct();
% sindinfo = init_struct();
% anlp = init_struct();
% seq = init_struct();

fprintf('%15s %5s %15s %15s %15s %15s %15s %15s \n', 'Algorithm','p','RSE','MAE','RMSE', 'SampleTime','RecoverTime','ScheduleCount');
% recovery error at different sampling rate
for p = 0.1:sample_step:0.9
    % enhanced tube-based sampling
%     t = tic;
%     [~, samp_Omega, scheCount] = MACDschedule( Target, p, rank, 0.1, 'tubeOff', u, alpha, beta);
%     sample_time = toc(t); % sampling time
%     t = tic;
%     Recovered = tensor_ADMM(Target, samp_Omega);
%     recover_time = toc(t); % recovery time
%     ours = calculate_result(Recovered, Target, ours, sample_time, recover_time);
%     % print result
%     fprintf('%15s %5.2f %15.2f %15f %15f %15.2f %15.2f %15d \n', 'Ours', p, ours.RSE(end), ...
%         ours.MAE(end),ours.RMSE(end),sample_time,recover_time,scheCount);
%     
%     % leverage score + ADMM
%     t = tic;
%     L = tensor_leverage_sample_entry(Target,m*n*k*p,0.1,rank); 
%     sample_time = toc(t);
%     t = tic;
%     Recovered = tensor_ADMM(Target,L); 
%     recover_time = toc(t);
%     leverage = calculate_result(Recovered, Target, leverage, sample_time, recover_time);
%     fprintf('%15s %5.2f %15.2f %15f %15f %15.2f %15.2f %15d \n', 'Leverage',p,leverage.RSE(end),...
%         leverage.MAE(end),leverage.RMSE(end),sample_time,recover_time,k);
%     
%     % random entry + ADMM
%     t = tic;
%     [B] = randomElementSample(Target,p); 
%     sample_time = toc(t);
%     t = tic;
%     Recovered = tensor_ADMM(Target,B); 
%     recover_time = toc(t);
%     random_point = calculate_result(Recovered, Target, random_point, sample_time, recover_time);
%     fprintf('%15s %5.2f %15.2f %15.2f %15.2f %15d %15d \n', 'RandomEntry',p,random_point.RSE(end),...
%         random_point.MAE(end),random_point.RMSE(end),sample_time,recover_time);
%     
%     % randon tube + ADMM
%     t = tic;
%     [~,~,~,A] = randomTubeSample(Target,floor(m*n*p)); 
%     sample_time = toc(t);
%     t = tic;
%     Recovered = tensor_ADMM(Target,A); 
%     recover_time = toc(t);
%     random_tube = calculate_result(Recovered, Target, random_tube, sample_time, recover_time);
%     fprintf('%15s %5.2f %15.2f %15.2f %15.2f %15d %15d \n', 'RandomTube',p,random_tube.RSE(end),...
%         random_tube.MAE(end),random_tube.RMSE(end),sample_time,recover_time);
    
    % adaptive tube + subspace
    t = tic;
    [Recovered,IDX_A]=tensor_adaptive_sample_fiber(Target,m*n*p,0.7,rank);
    time = toc(t);
    adaptive = calculate_result(Recovered, Target, adaptive, -1, time);
    fprintf('%15s %5.2f %15.2f %15.2f %15.2f %15d %15d \n','Adaptive', ...
        p, adaptive.RSE(end),adaptive.MAE(end),adaptive.RMSE(end),-1, time);
    
    % random entry + CP_ALS
%     t = tic;
%     [IDX_C] = matrix_random_sample_entry(Target, m*n*p);
%     IDX_C = tensor(IDX_C.*Target);
%     sample_time = toc(t);
%     t = tic;
%     T_cp = cp_als(IDX_C, min(rank,k) ,'init','nvecs','tol',1e-6,'maxiters',1000,'printitn',0); 
%     recover_time = toc(t);
%     Recovered = double(T_cp);
%     CP_ALS = calculate_result(Recovered, Target, CP_ALS, sample_time, recover_time);
%     fprintf('%15s %5.2f %15.2f %15.2f %15.2f %15d %15d \n','CP-ALS', ...
%         p, CP_ALS.RSE(end),CP_ALS.MAE(end),CP_ALS.RMSE(end),sample_time, recover_time);
%     
%     % random entry + CP_OPT
%     t = tic;
%     [IDX_C] = matrix_random_sample_entry(Target, m*n*p);
%     IDX_C = tensor(IDX_C.*Target);
%     sample_time = toc(t);
%     t = tic;
%     T_cp = gcp_opt(IDX_C,min(rank,k),'type','normal','opt','adam','printitn',0);
%     recover_time = toc(t);
%     Recovered = double(T_cp);
%     CP_OPT = calculate_result(Recovered, Target, CP_OPT, sample_time, recover_time);
%     fprintf('%15s %5.2f %15.2f %15.2f %15.2f %15d %15d \n','CP-OPT', ...
%         p, CP_OPT.RSE(end),CP_OPT.MAE(end),CP_OPT.RMSE(end),sample_time, recover_time);
%     
%     % random entry + HOSVD
%     t = tic;
%     [IDX_C] = matrix_random_sample_entry(Target, m*n*p);
%     IDX_C = tensor(IDX_C.*Target);
%     sample_time = toc(t);
%     t = tic;
%     T_hosvd = tucker_als(IDX_C,min(rank,k),'printitn',0);
%     recover_time = toc(t);
%     Recovered = double(T_hosvd);
%     hosvd = calculate_result(Recovered, Target, hosvd, sample_time, recover_time);
%     fprintf('%15s %5.2f %15.2f %15.2f %15.2f %15d %15d \n','HOSVD', ...
%         p, hosvd.RSE(end),hosvd.MAE(end),hosvd.RMSE(end),sample_time, recover_time);
%     
%     % SideInfo
%     t = tic;
%     [Recovered]=SideInfo(Target,p,min(rank ,k));
%     time = toc(t);
%     sindinfo = calculate_result(Recovered, Target, sindinfo, -1, time);
%     fprintf('%15s %5.2f %15.2f %15.2f %15.2f %15d %15d \n','SideInfo', ...
%         p, sindinfo.RSE(end),sindinfo.MAE(end),sindinfo.RMSE(end),-1, time);
%     
%     % Algorithm: ANLLP
%     t = tic;
%     [Recovered]=ANLP(Target,p);
%     time = toc(t);
%     anlp = calculate_result(Recovered, Target, anlp, -1, time);
%     fprintf('%15s %5.2f %15.2f %15.2f %15.2f %15d %15d \n','ANLP', ...
%         p, anlp.RSE(end),anlp.MAE(end),anlp.RMSE(end),-1, time);
%     
%     % Seq
%     t = tic;
%     [Recovered] = CallSeq(Target, p);
%     time = toc(t);
%     seq = calculate_result(Recovered, Target, seq, -1, time);
%     fprintf('%15s %5.2f %15.2f %15.2f %15.2f %15d %15d \n','Seq', ...
%         p, seq.RSE(end),seq.MAE(end),seq.RMSE(end),-1, time);
    
end

% save result
save(save_path, 'ours','leverage','random_point', ...
    'random_tube', 'adaptive', 'CP_ALS', 'CP_OPT', 'hosvd', 'sindinfo', 'anlp', 'seq');




