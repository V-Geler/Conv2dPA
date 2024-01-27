%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-10-05: Created & Completed.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ylimit = vplot_ylimit(data, ylimit, scaler)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% data          : The data used for plotting.
% ylimit        : The calculation result of 'data' will be merged with this
%                 existing 'ylimit'.
% scaler        : The scaling factor.
% 
% Output
% ylimit        : ylim([min, max]).
%
% This script is used to calculate the [lower limit, upper limit] for the
% built-in function ylim().
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.10.05
% vgeler9602@gmail.com

% ****************************************
%   [Step 0] Check input and set system variables
% ****************************************
data = squeeze(data);
if nargin < 2 || isempty(ylimit), ylimit = [inf, -inf]; end
if nargin < 3, scaler = 0.05; end

% ****************************************
%   [Step 1] Calculate the limits
% ****************************************
lim(1) = min(data, [], 'all');
lim(2) = max(data, [], 'all');
lim(3) = (lim(2) - lim(1)) * scaler;

% ****************************************
%   [Step 2] Output results
% ****************************************
ylimit = [min(ylimit(1), lim(1)-lim(3)), max(ylimit(2), lim(2)+lim(3))];

end