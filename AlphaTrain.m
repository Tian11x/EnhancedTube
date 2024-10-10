clear;
clc;

Dataset = 'Seattle';

if strcmp(Dataset, 'Seattle')
   data_path = 'experiment_uniform/data/Seattle99';
   load(data_path);
   Tensor = Seattle;
   Tensor = Tensor ./ max(max(max(Tensor))); 
   Target = Tensor(:,:,80:139);
   rank = 8;
   u = 8;
   save_path = 'experiment_uniform/finalResult/AlphaTrainSeattle.mat';
   load('experiment_uniform/finalResult/AlphaTrainSeattle.mat');
elseif strcmp(Dataset, 'PlanetLab')
   data_path = 'experiment_uniform/data/PlanetLab490';
   load(data_path);
   Tensor = PlanetLab;
   Tensor = Tensor ./ max(max(max(Tensor))); 
   Target = Tensor(:,:,:);
   rank = 12;
   u = 47;
   save_path = 'experiment_uniform/finalResult/AlphaTrainPlanetLab.mat';
   
end


[~, n, k] = size(Target);

rate = 0.2; 
 
alpha_values = 0.1:0.1:0.9;


best_alpha = 0;
best_rse = Inf;


alpha_rses = [];

fprintf('%15s %15s\n', 'Alpha_value','RSE');


for i = 1:length(alpha_values)
    
    [~, samp_Omega, ~] = MACDschedule( Target, rate, rank, 0.1, 'tubeOff',u, alpha_values(i), 0);
    Recovered = tensor_ADMM(Target, samp_Omega);
    RSE = norm(Recovered(:)-Target(:))/norm(Target(:));
    fprintf('%15.2f %15.4f\n', alpha_values(i), RSE);
    
    
    if RSE < best_rse
        best_alpha = alpha_values(i);
        best_rse = RSE;
    end
    
    
    alpha_rses = [alpha_rses; alpha_values(i), RSE];
end

out_alpha = best_alpha;

for i = -1:2:1
    
    new_alpha = best_alpha + i*0.05;
    
    
    [~, samp_Omega, ~] = MACDschedule( Target, rate, rank, 0.1, 'tubeOff',u, new_alpha, 0);
    Recovered = tensor_ADMM(Target, samp_Omega);
    RSE = norm(Recovered(:)-Target(:))/norm(Target(:));
    fprintf('%15.2f %15.4f\n', new_alpha, RSE);
    
    
    alpha_rses(end,2) = [alpha_rses; new_alpha, RSE];
    
    
    if RSE < best_rse
        out_alpha = new_alpha;
        best_rse = RSE;
    end
end


save(save_path, 'alpha_rses', 'out_alpha');

