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
 
alpha_values = 0.9;

fprintf('%15s %15s\n', 'Alpha_value','RSE');

 
[~, samp_Omega, ~] = MACDschedule( Target, rate, rank, 0.1, 'tubeOff',u, alpha_values, 0);
Recovered = tensor_ADMM(Target, samp_Omega);
RSE = norm(Recovered(:)-Target(:))/norm(Target(:));
fprintf('%15.2f %15.4f\n', alpha_values, RSE);

