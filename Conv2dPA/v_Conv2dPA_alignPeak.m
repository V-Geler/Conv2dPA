%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-11-01: Created & Completed in the main.
% 2023-11-16: Support for multi-component.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function aglinChroma = v_Conv2dPA_alignPeak(chroma, step, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% chroma        : Chromatographic profiles, with size of [sz_rt, sz_Comp].
% step          : The "direction & points" of alignment.
%            <0 : retention time ↓. (GO LEFT)
%            =0 : remain.
%            >0 : retention time ↑. (GO RIGHT)
% kwargs        : A Struct for optional parameters.
%   @.norm      : Whether to perform normalization.
%           '0' : Do not perform normalization. 
%           '1' : Perform normalization. (default)
%   @.isshow    : Whether to plot the results.
%           '0' : Do not plot the results. (default)
%           '1' : Plot the results.
%   @.title     : Title for plot.
%
% Output
% alignChroma   : The resulting chromatographic profile.
%
% Note that: This script is published as a part of the Conv2dPA project.
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.11.16
% vgeler9602@gmail.com

end