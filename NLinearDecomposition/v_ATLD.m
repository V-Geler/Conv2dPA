%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-10-25: Created & Completed in the main.
% 2023-10-31: Modify orthogonal operation to Opt_Init=3.
% 2023-11-27: Add Isp_mat parameters.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rovATLD] = v_ATLD(X_RtWlSam, Comp, Opt_init, Constraints, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% X_RtWlSam     : HPLC-DAD measurements. Enter a 3-way tensor in the order 
%                 of [Elution time point, Wavelength point, Samples].
% Comp          : The number of factors. Enter a pre-estimated value.
% Opt_Init      : Initialization options.
%           '1' : DTLD initialization.
%           '2' : SVD initialization.
%  (Default)'3' : Random orthogonal initialization.
%           '4' : Initialization with known profiles.
%           '5' : Best fit of several runs.
% Constraints   : Constraint options for chromatographic and spectra mode. 
%                 Enter a 2-element vector with value: 
%           '0' : No constraint. (default)
%           '1' : Orthogonality. (TODO)
%           '2' : Non-negativity (directly force to 0)
%           '3' : Unimodality and non-negativity (directly force to 0)
% kwargs        : A Struct for optional parameters.
%   @.iterMax   : The maximum number of iterations.
%      (default): 500.
%   @.iniLoading: Known profiles used as initialization (Implement when
%                 Opt_Init = 4). Enter a 3-element cell.
%           e.g.: {[Pf_rt], [Pf_wl], []} for known chromatographic and
%                 spectra profiles.
%   @.fixIdx    : Index of profiles that REMAIN CONTANT during interation.
%                 Enter a 3-element cell, e.g. {[Fidx_rt], [Fidx_wl], []}.
%   @.order     : The order of output components.
%        'none' : Determined by initialization. (default)
%          'rt' : In order of retention time (acsending).
%   @.Isp_mat   : Presence or absence of each component in each sample.
%                 A [0/1] matrix with size of [sz_sam, Comp].
%   @.epsilon   : Tolerance. (default: calculate by Dim * eps(norm()) ).
%   @.earlystop : Judgement for convergence of loss function.
%     (default) : 1e-6.
%   @.seed      : Random seed.
%   @.isshow    : Whether to plot the results.
% (default) '0' : Do not plot the results.
%           '1' : Plot the results.
%   @.isdisp    : Whether to display the options.
% (default) '0' : Do not display the options.
%           '1' : Display the options.
%
% Output
% rovATLD       : Struct. Record the solutions.
%   @.rovPf     : Resolved (norm) chromatographic, (norm) spectra, and 
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
% Last edited:  2023.10.31
% vgeler9602@gmail.com

end