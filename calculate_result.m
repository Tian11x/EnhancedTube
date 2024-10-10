function [metrics] = calculate_result(recovered, target, results, SampleTime, RecoverTime)
% COMPUTE_METRICS  Computes RSE, MAE, and RMSE between tensors and a target tensor
%    Inputs:
%        tensors - a 3D reconstructed tensor
%        target - the 3D target tensor
%        results - a struct with empty arrays for RSE, MAE, and RMSE
%    Output:
%        metrics - a structure with RSE, MAE, and RMSE for the input tensors

% Compute the size
[m,n,k] = size(recovered);

% Compute the metrics
RSE = norm(recovered(:)-target(:))/norm(target(:));
MAE = sum(abs(recovered - target), 'all')/(m*n*k);
RMSE = norm(recovered(:)-target(:))/sqrt(m*n*k);

% Store the results in the input results struct
results.RSE = [results.RSE RSE];
results.MAE = [results.MAE MAE];
results.RMSE = [results.RMSE RMSE];
results.SampleTime = [results.SampleTime SampleTime];
results.RecoverTime = [results.RecoverTime RecoverTime];

% Return the metrics
metrics = results;
end
