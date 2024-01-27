%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-11-28: Created & Completed in the main.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [fit2Gauss] = v_fitChroma_DoubleGaussian(Xrt, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% Xrt           : Chromatographic profiles. Enter column matrix with size 
%                 of [sz_rt, comp].
% kwargs        : A Struct. Optional parameters.
%   @.isshow    : Show plot of results.
%   @.idx       : Index of data point for fitting double Gaussian.
%   @.axis      : Axis of retention time. Default: [1:sz_rt];
%   @.SNr       : The signal-to-noise ratio. (Default: 0.01, aka 1%)
%   @.a0        : The initial contribution of the main peak. 
%     (default) : 0.51.
%   @.norm      : Whether or not to perform normalization. 
%                 Enter 'true' or 'false'.
%
% Output
% rov2Gaussian  : A Struct.
%   @.data      : Fitted chromatographic profiles.
%   @.param     : Fit value of parameter [a, h, mu1, mu2, sigma1, sigma2] 
%                 for each profile. Output a matrix with size of [comp, 6].
%   @.e         : Fit value of parameter 'e' (residual term).
%   @.X1        : The first fitted Gaussian Cruve. (main peak)
%   @.X2        : The first fitted Gaussian Cruve.
%
% Note that:  The importance of the initial value (estimate) of the 
% parameters is beyond imagination!!!
%
% This script perform Chromatographic curve fitting according to 
% double Gaussian model.
%
% Reference: https://doi.org/10.1021/ac00124a051
%            https://doi.org/10.1016/s0021-9673(01)01136-0 (Review)
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.11.28 
% vgeler9602@gmail.com


end
