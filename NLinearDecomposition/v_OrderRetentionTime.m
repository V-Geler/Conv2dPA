%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-10-09: Created & Completed in the main.
% 2023-10-26: Add conditions for judging as peaks (kwargs.propsignal).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function idxRT = v_OrderRetentionTime(X_RtComp, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input 
% X_RtComp      : Chromatographic profiles, with size [sz_rt, sz_comp].
% kwargs        : A Struct. Optional parameters.
%   @.SNr       : Signal to noise ratio threshold.
%   @.propbg    : The proportion of data points for baseline. That is, the
%                 minimum (sz_rt * propbg) are considered as the baseline. 
%   @.propsignal: The proportion of data points for signal. That is,
%                 minimum (sz_rt * propbg)  / mean( maximum (sz_rt * propsignal) )
%                 must < SNr.  
%   @.isshow    : Show the results.
%   @.epsilon   : Epsilon. (To avoil dividing by 0).
%
% Output
% idxRT         : Index to change chromatographic profiles.
%
% This script is to returns the index to change the order of components 
% according to their retention time. The background/noise components are
% listed at the end.
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.10.26
% vgeler9602@gmail.com

end