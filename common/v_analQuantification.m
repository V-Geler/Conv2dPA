%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-11-25: Created & Completed in the main.
% 2023-11-28: Add parameter 'idxSam'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function analQuan = v_analQuantification(Pfref, Pfres, idxComp, idxSam, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input 
% Pfref         : True (or reference) concentration profiles.
% Pfres         : Resolved concentration profile to be compared with Pfref.
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
% analQuan      : A Struct for quantificative analysis.
%   @.ref       : (Input) True (or reference) concentration profiles.
%   @.res       : (Input) Resolved concentration profile.
%   @.tab       : A table for [Recovery; average; std ].
%
% Note that: This script is published for the Conv2dPA project.
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.11.28
% vgeler9602@gmail.com

end