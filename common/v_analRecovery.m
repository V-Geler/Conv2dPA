%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2024-01-07: Created & Completed in the main.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function analRecovery = v_analRecovery(X_RtWlSam, rovPf, idxComp, idxSam, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input 
% Xdata         : HPLC-DAD measurements. Enter a 3-way tensor in the order 
%                 of [Elution time point, Wavelength point, Samples].
% rovPf         : Resolved profile, to reconstructe a 3-way data.
% idxComp       : Index of components to perform quantification analysis. 
%                 Enter a vector.
% idxSam        : Index of samples to perform quantification analysis. 
%                 Enter a vector.
% kwargs        : A Struct for optional parameters.
%   @.title     : Title for plot.
%   @.ylim      : ylim for plot.
%   @.compName  : The name of components for table.
%   @.isshow    : Whether to plot the results.
%           '0' : Do not plot the results.
%           '1' : Plot the results. (default)
%
% Output
% analRecover   : A Struct for goodness of recovery analysis.
%   @.similarity: Congruence coefficient.
%                 Output a matrix with size of [sz_wl, sz_sam].
%                 Note: NAN may be contained!!!
%   @.mean      : The average of Congruence coefficient for each sample.
%                 Note: NAN is excluded.
%   @.std       : The standard deviation for each sample.
%                 Note: NAN is excluded.
%   @.tab       : A table for [average; std].
%
% Note that: This script is published for the Conv2dPA project.
%
% Copyright (C) 2024  VGeler
% Last edited:  2024.01.07
% vgeler9602@gmail.com

end