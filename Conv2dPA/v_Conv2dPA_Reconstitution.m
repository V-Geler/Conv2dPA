%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-11-21: Created & Completed in the main.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rovConv2dPA] = v_Conv2dPA_Reconstitution(fitConv2dPA, ...
    X_RtWlSam, tarChroma, tarSpec, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% fitConv2dPA   : The output of the v_Conv2dPA_Fitting.m function.
% X_RtWlSam     : Raw HPLC-DAD measurements. Enter a 3-way tensor in the 
%                 order of [Elution time point, Wavelength point, Samples].
%                 Nonlinear retention time alignment will be performed.
% tarChroma     : Target chromatographic profiles for analytes.
%                 Enter a matrix with size of [sz_rt, sz_comp].
% tarSpec       : The target spectra profiles.
%                 Enter a matrix with size of [sz_rt, sz_comp].
% kwargs        : A Struct for optional parameters.
%   @.residual  : Whether to preserves the fit residuals.
%          true : Preserve the fit residuals. (default)
%         false : Remove the fit residuals.
%
% Output
% rovConv2dPA   : A Struct for Conv2dPA resolution. (Reconstituion)
%   @.data      : Reconstituion of HPLC-DAD measurements. Output a 3-way 
%                 tensor with size of [sz_rt, sz_wl, sz_comp].
%   @.DimX      : Number of data points for dimensions of chromatogram,
%                 spectra, and sample.
%   @.rovPf     : Resolved (norm) chromatographic, (norm) spectra, and 
%                 (relative) concentration profiles. Output a 3-element 
%                 cell {rovChroma, rovSpec, rovConc}.
%                 rovChroma: [sz_rt, Comp, sz_sam]
%                 rovSpec: [sz_wl, Comp, sz_sam]
%                 rovConc: [sz_sam, Comp]
%
% Note that: This script is published as a part of the Conv2dPA project.
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.11.21
% vgeler9602@gmail.com

end