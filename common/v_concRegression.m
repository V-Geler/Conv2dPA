%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-11-28: Created & Completed in the main.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [concRegress, tabRegress] = v_concRegression(Intensity, RefConc, samProp, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input 
% Intensity     : Resolved profiles of relative concentration (Intensity).
%                 Enter a matrix with size of [sz_sam, sz_comp].
% RefConc       : True profiles of experimental concentration.
%                 Enter a matrix with size of [sz_sam, Comp].
% samProp       : Index of sample properties. Enter a 3-element cell to 
%                 represent the index of {calibration, real, spiked real}
%                 samples. Enter [] to represent all samples are used for
%                 regression.
% kwargs        : A Struct for optional parameters.
%   @.compName  : The name of components used for table.
%   @.verbose   : Whether to display logs.
%           '0' : Do not display logs.
%           '1' : Display logs. (default)
%
% Output 
% concRegress   : A Struct for quantificative analysis.
%                 (Tucker's Congruence Coefficient)
% tabRegreee    : Table for evaluation indicator (average, std, Rsquare, R, 
%                 RMSE, min, max)
%
% Note that: This script is published for the Conv2dPA project.
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.11.28
% vgeler9602@gmail.com

end
