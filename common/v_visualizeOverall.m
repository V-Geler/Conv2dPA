%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-10-28: Created & Completed in the main.
% 2023-10-31: Add situation for single sample.
% 2023-11-21: Fix bugs for multiple spectra
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [] = v_visualizeOverall(Pf, axis, idxcomp, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input 
% Pf            : Enter a 3-element cell for {Pf_chroma, Pf_spec, Pf_conc}.
% axis          : The coordinate axes for dimensions of retention time, 
%                 wavelength, and samples. Enter a 3-element cell.
% idxcomp       : Index of components to be plot. Enter a vector.
% kwargs        : A Struct for optional parameters.
%   %.unit      : The unit of coordinate axes.
%   @.title     : Title for plot.
%   @.compName  : The name of components for ploting.
%
% Note that: This script is published for the Conv2dPA project.
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.11.20
% vgeler9602@gmail.com

end