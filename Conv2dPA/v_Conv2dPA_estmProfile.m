%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-10-31: Created & Completed in the main.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [estmPf] = v_Conv2dPA_estmProfile(X_RtWl, Comp, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% X_RtWl        : A single HPLC-DAD measurement. Enter a matrix in the stimat
%                 order of [elution time points, wavelength points].
%                 Profiles will be estimated based on component model.
% Comp          : The number of factors. Enter a pre-estimated value (that 
%                 is the input value of Conv2dPA_main).
% kwargs        : A Struct for optional parameters.
%   @.Opt_Init  : Initialization options.
%           '1' : DTLD initialization. (TODO)
%           '2' : SVD initialization.
%           '3' : Random orthogonal initialization. (default)
%           '4' : Initialization with known profiles.
%   @.iniLoading: Known profiles used as initialization (Implement when
%                 Opt_Init = 4). Enter a 2-element cell {[Pf_rt], [Pf_wl]}
%                 for known chromatographic and spectra profiles.
%   @.fixIdx    : Index of profiles that REMAIN CONTANT during interation.
%                 Enter a 2-element cell, e.g. {[Fidx_rt], [Fidx_wl]}.
%   @.Constraint: Constraint options for chromatographic and spectra mode. 
%                 Enter a {[1, Comp], [1, Comp]} cell with value of: 
%           '0' : No constraint. (default)
%           '1' : Forced to zeros.
%   @.iterMax   : The maximum number of iterations.
%     (default) : 500.
%   @.earlystop : Judgement for convergence of loss function.
%     (default) : 1e-6.
%   @.seed      : Random seed.
%   @.isshow    : Whether to plot the results.
%           '0' : Do not plot the results. (default)
%           '1' : Plot the results.
%   @.isdisp    : Whether to display the options.
%           '0' : Do not display the options. (default)
%           '1' : Display the options.
%
% Output
% estmPf        : Resolved (norm) chromatographic, (norm) spectra, and 
%                 (relative) concentration profiles. Output a 3-element 
%                 cell {rovPf_rt, rovPf_wl, rovPf_conc}.
%
% Note that: This script is published as a part of the Conv2dPA project.
% The basis of this script is the linear component model.  
% Pf_chroma(rt, :) = {inv(Pf_conc    Khatri-Rao  Pf_spec)   * vec(X_wl)}'
% Pf_spec(wl, :)   = {inv(Pf_chroma  Khatri-Rao  Pf_conc)   * vec(X_rt)}' 
% Pf_conc(sam, :)  = {inv(Pf_spec    Khatri-Rao  Pf_chroma) * vec(X_RtWl)}'
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.10.31
% vgeler9602@gmail.com
%
end