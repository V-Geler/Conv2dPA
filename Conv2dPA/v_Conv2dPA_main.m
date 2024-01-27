%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-11-20: Created & Completed in the main.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rovConv2dPA] = v_Conv2dPA_main(X_RtWl, Comp, Info, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% X_RtWl        : [NECESSARY] A single HPLC-DAD measurement. Enter a matrix 
%                 in the order of [elution time points, wavelength points].
%                 Nonlinear retention time alignment will be performed.
% Info          : [NECESSARY] A struct for reference infomation and 
%                 constraints on chromatographic and spectra profiles.
%   @.iniPf_rt  : [NECESSARY] The initial estimation of chromatographic 
%                 profiles. Enter a matrix with size of [sz_rt, sz_comp].
%   @.iniPf_wl  : [NECESSARY] The initial estimation of spectra profiles.
%                 Enter a matrix with size of [sz_wl, sz_comp].
%   @.compProp  : Properties of component. Enter a [1, sz_comp] vector with
%                 value of:
%           '0' : Baseline/Noise -- Variable estimation.
%           '1' : Analytes -- Perform non-linear peak alignment. (default)
%           '2' : Background/multi-components with low-intensity.
%   @.compOrder : Constraint on the elution order of analytes (compProp=1).
%                 Enter a [sz_comp, 2] matrix to represent the index of 
%                 preceding and following components of the analytes.
%   e.g. [0, 2] : no limit -> Comp 1 -> Comp 2 
%        [1, 4] :   Comp 1 -> Comp 2 -> Comp 4
%        [1, 4] :   Comp 1 -> Comp 3 -> Comp 4
%   (value) '0' : Do not perform constraint.
%   @.rngPeak   : Constraint on [PEAK] position of analytes (compProp=1). 
%                 Enter a [sz_comp, 2] matrix to represent the available
%                 range of [PEAK].
%  e.g.[50, 70] : 50, Peak 1, 80 (compProp = 1)
%      [10, 80] : 10, Peak 2, 80 (compProp = 2)
%    [1, sz_rt] : default.
%        [0, 0] : Do not perform constraint. (Adjusted to default)
%   @.rngSpec   : Constrain on the range of spectral data points to
%                 construct convolutional kernels. Enter a [sz_comp, 2] 
%                 matrix or a 2-element vector to represent the ranges.
%  e.g.[50, 80] : Peak 1, Pf_wl(50:80) for kernel_wl
%    [1, sz_wl] : default.
%        [0, 0] : Do not perform constraint. (Adjusted to default)
%   @.maxShift  : Constrain on the maximum points for [PEAK] alignment. 
%                 Enter a [sz_comp, 2] matrix to represent the 
%                 [lower, upper] limits, or a [sz_comp, 1] vector to
%                 represent the absolute limits.
%     (default) : 15.
%          '-1' : Do not perform constraint.
% kwargs        : A Struct for optional parameters.
%   @.epochMax  : Maximum number of epoches.
%     (default) : 50.
%   @.earlystop : Judgement for convergence (@.earlystop >= Concentration 
%                 difference bewteen two iterations). Enter a scaler.
%       Default : max(size(X_RtWl)) * eps(norm(X_RtWl, 2)).
%   @.SNr       : Signal to Noise Ratio. Peak alignment is performed only
%                 if the signal of analyte > signalThold.
%     (default) : 0.003. (1-99.7%).
%   @.signalThold:[OPTIONAL] if kwargs.signalThold is inputed, then
%                 'signalThold' does not calculated by kwargs.SNr.
%   @.paramKernelC: [OPTIONAL] Parameters for v_Conv2dPA_infoKernelChroma.m 
%                 function. Constrain on the data points that used to 
%                 construct the convolutional kernel (chromatographic dim).
%     (default) : Enter an [] to use default setting within the function.
%   @.isshow    : Whether to plot the results.
%           '0' : Do not plot the results. (default)
%           '1' : Plot the results.
%
% Output
% rovConv2dPA   : A Struct for Conv2dPA resolution.
%   @.rovPf     : Resolved (norm) chromatographic, (norm) spectra, and 
%                 (relative) concentration profiles. Output a 3-element 
%                 cell {rovPf_chroma, rovPf_spec, rovPf_conc}.
%   @.peak      : The optimal [PEAK] position to fit the inputed X_RtWl.
%                 Output a vector with size of [1, Comp].
%   @.shift     : The optimal peak alignment to fit the inputed X_RtWl.
%                 Output a vector with size of [1, Comp].
%          [<0] : Retention time ↓. (GO LEFT)
%          [=0] : Remain.
%          [>0] : Retention time ↑. (GO RIGHT)
%   @.DimX      : Number of data points for dimensions of chromatogram,
%                 spectra, component, and analytes (compProp = 1 or 2).
%   @.nepoch    : Number of epochs to obtain the optimal solution.
%   @.iter      : A Struct to record the calculation process.
%
% Note that:
% a) The core of Conv2dPA is the construction of convolution kernels 
% capable of sharpening the spactra differences between co-eluting analyes.
% b) The parameter 'Info.iniPf_wl' is particularly important. It will 
% directly affect the performance of Conv2dPA.
%
% This script is published as a part of the Conv2dPA project.
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.11.20
% vgeler9602@gmail.com

end