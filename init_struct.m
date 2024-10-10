function [result] = init_struct()
% INIT_STRUCT  Initializes a structure with empty arrays for RSE, MAE, RMSE, SampleTime, and RecoverTime
%    Output:
%        result - a structure with empty arrays for RSE, MAE, RMSE, SampleTime, and RecoverTime

% Initialize the arrays
result.RSE = [];
result.MAE = [];
result.RMSE = [];
result.SampleTime = [];
result.RecoverTime = [];

end

