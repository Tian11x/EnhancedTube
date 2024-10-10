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
   save_path = 'experiment_uniform/finalResult/BetaTrainSeattle.mat';
   load('experiment_uniform/finalResult/AlphaTrainSeattle.mat');
   alpha = out_alpha;
elseif strcmp(Dataset, 'PlanetLab')
   data_path = 'experiment_uniform/data/PlanetLab490';
   load(data_path);
   Tensor = PlanetLab;
   Tensor = Tensor ./ max(max(max(Tensor))); 
   Target = Tensor(:,:,:);
   rank = 12;
   u = 47;
   save_path = 'experiment_uniform/finalResult/BetaTrainPlanetLab.mat';
   load('experiment_uniform/finalResult/AlphaTrainPlanetLab.mat');
   alpha = out_alpha;
end

[~, n, k] = size(Target);
beta_values = [0.96, 0.97,0.98,0.99,0.999];

beta1_rses = zeros(length(beta_values),9);
beta1_schcost = zeros(length(beta_values) ,9);

fprintf('%15s %15s %15s %15s \n','SampleRate','Beta_value','RSE','Schcost');

for j = 1:1:9
    for i = 1:length(beta_values)
        [~, samp_Omega, schecost] = MACDschedule( Target, j*0.1, rank, 0.1, 'tubeOn-cos',u, alpha, beta_values(i));
        Recovered = tensor_ADMM(Target, samp_Omega);
        RSE = norm(Recovered(:)-Target(:))/norm(Target(:));
        fprintf('%15.1f %15.3f %15.4f %15d\n',j, beta_values(i), RSE, schecost);

        % save result
        beta_rses(i,j) = RSE;
        beta_schcost(i,j) = schecost;
    end
end


save(save_path, 'beta_values', 'beta_rses','beta_schcost'); % ,'best_rse','best_schcost'

