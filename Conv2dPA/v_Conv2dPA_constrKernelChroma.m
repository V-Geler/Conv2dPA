%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-11-03: Created & Completed in the main.
% 2023-11-17: Modify bug in [Part 1.4]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function KernelCRov = v_Conv2dPA_constrKernelChroma(Chroma, Conc, Spec, ...
    tarComp, rngC, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% Chroma        : Chromatographic profiles of analytes. Enter a matrix with
%                 size of [sz_rt, szP{1}].
% Conc          : Relative concentration (current).
% Spec          : Spectra profiles of analytes (sliced by rngS). Enter a
%                 matrix with size of [sz(rngS), szP{1}].
% tarComp       : A index of target component.
% rngC          : The range of chromatographic data points to construct 
%                 convolutional kernels. Enter a vector with size of [8, 1]
%                 obtained by v_infoKernelChroma.m function.
% kwargs        : A Struct for optional parameters.
%   @.isshow    : Whether to plot the results.
%           '0' : Do not plot the results. (default)
%           '1' : Plot the results.
%   @.title     : Title for plot.
%
% Output 
% KernelCRov    : A struct for chromatographic profiles to constuct the 
%                 convolution kernel (KernelCRov.data * Spec(rngS)') 
%   @.data      : Chromatographic profiles of kernel. Output a matrix 
%                 with size of [sz_rt, Comp].
%   @.sgn       : The signal of IDEAL convolution result used to determine 
%                 candidates. Output a 2-element vector.
%
% Note that: This script is published as a part of the Conv2dPA project.
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.11.17
% vgeler9602@gmail.com

end