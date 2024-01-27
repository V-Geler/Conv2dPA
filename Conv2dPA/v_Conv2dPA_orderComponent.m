%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-11-01: Created & Completed in the main.
% 2023-11-14: Modify description.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Order = v_Conv2dPA_orderComponent(Chromas, compProp, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input 
% Chromas       : Chromatographic profiles, with size [sz_rt, sz_comp].
% compProp      : Properties of component.
%           '0' : Baseline/Noise -- Variable estimation.
%           '1' : Analytes -- Perform non-linear peak alignment. (default)
%           '2' : Background/multi-components with low-intensity.
% kwargs        : A Struct. Optional parameters.
%   @.idx       : The index of new order {Analytes, Background, Noise}.
%                 Output a vector with size of [Comp, 1].
%   @.idxP      : The index of new order for each compProp. Output a cell 
%                 {idx(Analytes); idx(Background); idx(Noise)}.
%   @.isshow    : Show the results.
%
% Output
% idxRT         : Index to change chromatographic profiles.
%
% Note that: This script is published as a part of the Conv2dPA project.
%
% Copyright (C) 2023  VGeler 
% Last edited:  2023.11.14
% vgeler9602@gmail.com

end