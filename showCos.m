clear;
clc;

Dataset = 'PlanetLab';

if strcmp(Dataset, 'Seattle')
   data_path = 'experiment_uniform/data/Seattle99';
   load(data_path);
   Tensor = Seattle;
   Tensor = Tensor ./ max(max(max(Tensor))); 
   Target = Tensor(:,:,80:139);
   rank = 8;
   LS = LS_pattern(Target, rank);
   x = 1:1:59;
elseif strcmp(Dataset, 'PlanetLab')
   data_path = 'experiment_uniform/data/PlanetLab490';
   load(data_path);
   Tensor = PlanetLab;
   Tensor = Tensor ./ max(max(max(Tensor))); 
   Target = Tensor(:,:,:);
   rank = 12;
   LS = LS_pattern(Target, rank);
   x = 1:1:17;
end

cos_array = compute_cos(LS);

figure('Position', [500, 500, 500, 300]);
plot(x,cos_array,'-^','linewidth',2,'Color',[250, 104, 39]/255);
grid on;
box on;
%axis([0 18 0.955 1]);




