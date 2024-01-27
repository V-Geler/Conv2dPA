%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-11-16: Created & Completed in the main.
% 2023-11-17: Modify show results.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CanddDectRov = v_Conv2dPA_detectCandd(Score, SGN, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% Score         : Convolution score. Enter a vector.
% SGN           : The signal of IDEAL convolution result to determine 
%                 candidates. Enter a 2-element vector.
% kwargs        : A Struct. Optional parameters.
%   @.SNr       : Singal to noise ratio. Used as Exclusions of:
%                 [1] Noise region. [2] Threshold of signal changed.
%     (default) : 0.003. (1-99.7%)
%   @.NoiseThod : (Optional) Threshold of noise.
%   @.peakRng   : Constraint on [PEAK] position of analytes
%     (default) : [1, sz_rt].
%   @.isshow    : Whether to plot the results.
%           '0' : Do not plot the results. (default)
%           '1' : Plot the results.
%   @.title     : Title for plot.
%
% Output
% CanddDectRov  : A Struct.
%   @.sz        : The number of candidate positions have been found.
%   @.pos       : Candidate positions. Output a column vector.
%
% Note that: This script is published as a part of the Conv2dPA project.
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.11.17
% vgeler9602@gmail.com

end