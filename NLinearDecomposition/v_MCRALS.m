%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-10-26: Created & Completed in the main.
% 2023-10-28: Add initialization options.
% 2023-10-29: Modify the nan profiles for zero concentration components. (Step 7)
% 2023-10-30: Modify [Step 6], Loading{2} is calculate when niter > 1.
% 2023-11-27: Set kwargs.earlystop = 1e-3 (same as original code of MCR-ALS).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rovMCRALS] = v_MCRALS(X_RtWlSam, Comp, Opt_init, Noneg, ...
    kwargs, Closure, Isp_mat)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% X_RtWlSam     : HPLC-DAD measurements. Enter a 3-way tensor in the order 
%                 of [Elution time point, Wavelength point, Samples].
% Comp          : The number of factors. Enter a pre-estimated value.
% Opt_Init      : Initialization options.
%           '1' : Pure variable initialization. (default)
%           '2' : SVD initialization.
%           '3' : Random orthogonal initialization.
%           '4' : Initialization with known spectra profiles.
% Noneg         : A Struct for Non-Negative constraint.
%   @.Cnoneg    : Whether perform constraint on Concentration mode.
%           '0' : Not perform. (default)
%           '1' : Perform non-negative on Concentration mode.
%   @.Cialg     : The algorithm for non-negative constraint.
%           '0' : Forced to zeros. (default)
%           '1' : nnls.
%           '2' : fnnls.
%   @.Ccneg     : Perform or not for each component in each sample. 
%                 A [0/1] matrix with size [sz_sam, Comp].
%   @.Snoneg    : Whether perform constraint on Spectral mode.
%           '0' : Not perform.
%           '1' : Perform non-negative on Spectral mode.
%   @.Sialg     : The algorithm for non-negative constraint.
%           '0' : Forced to zeros.
%           '1' : nnls.
%           '2' : fnnls.
%   @.Scneg     : Perform or not for each component in each sample. 
%                 A [0/1] matrix with size [1, Comp].
% kwargs        : A Struct. Optional parameters.
%   @.iterMax   : The maximum number of iterations.
%      (default): 500.
%   @.order     : The order of output components.
%        'none' : Determined by initialization. (default)
%          'rt' : In order of retention time (acsending).
%   @.pInitNoise: Noise level for pure varibale initialization.
%     (default) : 0.1
%   @.iniSpec   : Known profiles used as initialization (Implement when
%                 Opt_Init = 4). Enter a matrix for known spectra profiles.
%   @.earlystop : Judgement for convergence of loss function.
%     (default) : 1e-2 > (sigma_prep - sigma_now) / sigma_now
%   @.isshow    : Whether to plot the results.
% (default) '0' : Do not plot the results.
%           '1' : Plot the results.
%   @.isdisp    : Whether to display the options.
% (default) '0' : Do not display the options.
%           '1' : Display the options.
% Closure       : A struct for closure constraint in spectra;
%   @.closure   : Whether perform closure constraint.
%           '0' : DO NOT perform closure constraint. (default)
%                 Normalization will perform.
%           '1' : Perform closure constraint. (pass)
%   @.Sinorm    : The algorithm for spectra's normalization.
%           '0' : DO NOT perform normalization.
%           '1' : Spectra equal height.
%           '2' : Spectra equal length - divided by Frobenius Norm. (default)
%           '3' : equal length - divided by Total Sum Norm.
% Isp_mat       : Presence or absence of each component in each sample.
%                 A [0/1] matrix with size of [sz_sam, Comp].
%
% Output
% rovMCRALS     : Struct. Record the solutions.
%   @.rovP      : Resolved (norm) chromatographic, (norm) spectra, and 
%                 (relative) concentration profiles. Output a 3-element 
%                 cell {rovPf_rt, rovPf_wl, rovPf_conc}.
%   @.DimX      : Number of data points for dimensions of chromatogram,
%                 spectra, sample, and components.
%   @.niter     : Number of iterations at convergence.
%   @.loss      : Loss function results for each iteration.
%   @.ssr       : Sum of Squared Residuals.
%   @.sfit      : SD of residuals(Sfit).
%   @.explvar   : Explained Variance.
%
% Note that: This script has restricted some features and is published for
% the Conv2dPA project.
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.10.30
% vgeler9602@gmail.com

end