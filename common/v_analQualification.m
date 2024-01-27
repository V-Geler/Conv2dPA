%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-11-25: Created & Completed in the main.
% 2023-11-28: Add missing input situations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function analQual = v_analQualification(Pfref, Pfres, idxcomp, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input 
% Pfref         : True (or reference) chromatographic and spectra profiles. 
%                 Enter a 2-element cell {PfChroma, PfSpec} or a
%                 3-element cell {PfChroma, PfSpec, PfConc}.
%                 PfConc is used to determine the presence of components.
% Pfres         : Resolved chromatographic and spectra profiles to be 
%                 compared with Pfref. Enter a cell {Pf_chroma, Pf_spec}. 
% idxcomp       : Index of components to perform qualification analysis. 
%                 Enter a vector.
% kwargs        : A Struct for optional parameters.
%   @.title     : Title for plot.
%   @.ylim      : ylim for plot.
%   @.compName  : The name of components used for table.
%   @.isshow    : Whether to plot the results.
%           '0' : Do not plot the results.
%           '1' : Plot the results. (default)
%
% Output 
% analQual      : A Struct for quantificative analysis.
%                 (Tucker's Congruence Coefficient)
%   @.tab       : A table for similarity of chromatographic and spectra
%                 profiles (average and standard deviation).
%   @.tabChroma : A table for similarity of chromatographic profiles.
%   @.tabSpec   : A table for similarity of spectra profiles.
%
% Note that: This script is published for the Conv2dPA project.
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.11.28
% vgeler9602@gmail.com

end

