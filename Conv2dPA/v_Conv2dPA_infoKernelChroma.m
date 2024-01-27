%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-11-15: Created & Completed in the main.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function KernelCInfo = v_Conv2dPA_infoKernelChroma(chroma, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% chroma        : Chromatographic profiles, with size of [sz_rt, 1].
% kwargs        : A Struct for optional parameters.
%   @.height    : Parameters to determine the data points that used to 
%                 construct the convolutional kernel (chromatographic).
%     (default) : [0.7, 0.1].
%               +                   peak
%              + -
%             +   -
%       left|+  |  -|right          >= 70% peak height (with similar value)
%           -       +
%          -         +
%    left|-           +|right       >= 10% peak height (with similar value)
%   @.isshow    : Whether to plot the results.
%           '0' : Do not plot the results. (default)
%           '1' : Plot the results.
%   @.title     : Title for plot.
%
% Output 
% KernelCInfo   : A struct for infomation on chromatographic kernel.
%   @.rngC      : Offset values for the boundaries of [L-, L+, R-, R+] 
%                 regions. Output a vector with size of [1, 8].
%.  @.peak      : Chromatographic peak position.
%
% Note that: This script is published as a part of the Conv2dPA project.
% Assumption: Chromatographic profile is unimodal
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.11.15
% vgeler9602@gmail.com

end