%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-10-18: Created & Completed in the main.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [fitEMG] = v_fitChroma_EMG(Xrt, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% Xrt           : Chromatographic profiles. Enter column matrix with size 
%                 of [sz_rt, comp].
% kwargs        : A Struct. Optional parameters.
%   @.isshow    : Show plot of results.
%   @.idx       : Index of data point for fitting EMG.
%   @.axis      : Axis of retention time. Default: [1:sz_rt];
%   @.SNr       : The signal-to-noise ratio. (Default: 0.01, aka 1%)
%   @.norm      : Whether or not to perform normalization. 
%                 Enter 'true' or 'false'.
%
% Output
% fitEMG        : A Struct.
%   @.data      : Fitted chromatographic profiles.
%   @.param     : Fit value of parameter [mu, sigma, tao] for each profile.
%                 Output a matrix with size of [comp, 3].
%   @.e         : Fit value of parameter 'e' (residual term).
%
% Note that:  The importance of the initial value (estimate) of the 
% parameters is beyond imagination!!!
%
% This script performs chromatographic profiles fitting based on the 
% Exponentially Modified Gaussian (EMG) model.
%
% Reference: https://doi.org/10.1007/BF02268168
%            https://doi.org/10.1021/ac00255a033(ORIGIN)
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.10.18 
% vgeler9602@gmail.com

end