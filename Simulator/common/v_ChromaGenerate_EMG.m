%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-10-01: Created & Completed.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [curveEMG] = v_ChromaGenerate_EMG(axis, param, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% axis          : The axis for chromatography, 
%                 with size [sz_rt, comp] or [sz_rt, 1].
% param         : The parameters for EMG funtion, with size [comp, 3].
%                 [mu, sigma, tao]
% kwargs        : A Struct.
%   @.isshow    : If showing result
%
% Output
% curveEMG      : A cell with size {comp, 1}. Curve will be normalized.
%
% Note that: Exponentially Modified Gaussian (EMG)
%             h_EMG(t) = A / tao * EMG(t)
%             EMG(t) = exp(0.5*(sigma/tao)^2-(axis-mu)/tao)
%                    * [erf(1/sqrt(2)*(mu/sigma+sigma/tao)) 
%                    + erf(1/sqrt(2)*((axis-mu)/sigma-sigma/tao))]
%
% This script perform Chromatographic curve fitting according to EMG model.
%
% Reference: https://doi.org/10.1007/BF02268168
%            https://doi.org/10.1021/ac00255a033(ORIGIN)
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.10.01
% vgeler9602@gmail.com


% ****************************************
%   [Step 0] Check input and set system variables
% ****************************************
if nargin < 2, error("Incomplete input!!"); end

if nargin < 3, kwargs = struct(); end

if ~isfield(kwargs, 'isshow'), kwargs.isshow = 0; end

Comp = size(param, 1);
if isrow(axis), axis = axis'; end
if size(axis, 2) == 1, axis = repmat(axis, 1, Comp); end

% ****************************************
%   [Step 1] Get EMG curve
% ****************************************
curveEMG = cell(Comp, 1);
dsqrt2 = 1 / sqrt(2);
for c_ = 1 : Comp
    p_ = param(c_, :);
    curveEMG{c_, 1} = ...
        exp(0.5*(p_(2)/p_(3))^2 - (axis(:, c_) - p_(1))/p_(3)) ...
        .* (erf( dsqrt2 * ( p_(1)/p_(2) + p_(2)/p_(3))) ...
        + erf( dsqrt2 * ( (axis(:, c_) - p_(1))/p_(2) - p_(2)/p_(3) ) ));
    curveEMG{c_, 1} = curveEMG{c_, 1} ./ vecnorm(curveEMG{c_, 1});
end

clear c_ p_ dsqrt2 

% ****************************************
%   [Step 2] Plot results
% ****************************************
if kwargs.isshow
    figure('Name', 'ChromaFit [EMG]', ...
        'Position', [400, 400, 600, 300], 'NumberTitle', 'off'); 
    hold on
    for c_ = 1 : Comp
        plot(axis(:, c_), curveEMG{c_}, 'LineWidth', 1.5);
    end
    clear c_
end

% ****************************************
%   [Step 3] Output Result
% ****************************************
if Comp == 1
    curveEMG = curveEMG{1};
end

end



