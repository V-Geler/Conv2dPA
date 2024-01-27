%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-11-16: Created & Completed in the main.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function OptPos = v_Conv2dPA_rankCandd(candd, curPeak, ufixComp, ...
    Chroma, Spec, Xfg, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% candd         : Candidate positions. Enter a column vector.
% curPeak       : Current position of peak.
% ufixComp      : A index of adjustable component. Enter a vector.
% Chroma        : Chromatographic profiles of analytes. Enter a matrix with
%                 size of [sz_rt, szP{1}].
% Spec          : Spectra profiles of analytes (sliced by rngS). Enter a
%                 matrix with size of [sz(rngS), szP{1}].
% Xfg           : Current contribution of all analytes(sliced by rngS). Enter
%                 a matrix with size of [sz_rt, sz(rngS)].
% kwargs        : A Struct. Optional parameters.
%   @.isshow    : Whether to plot the results.
%           '0' : Do not plot the results. (default)
%           '1' : Plot the results.
%   @.title     : Title for plot.
%
% Output
% OptPos        : The optimal position.
%
% Note that: This script is published as a part of the Conv2dPA project.
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.11.16
% vgeler9602@gmail.com

end