%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-10-18: Created & Completed.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [fitEMG] = v_ChromaFitting_EMG(Xrt, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% Xrt           : Chromatographic profiles. Enter column matrix with size 
%                 of [sz_rt, comp].
% kwargs        : A Struct. Optional parameters.
%   @.isshow    : Show plot of results.
%   @.idx       : Index of data point for fitting EMG.
%   @.axis      : Axis of retention time. Default: [1:sz_rt];
%   @.SNr       : The signal-to-noise ratio. (Default: 0.01, aka 1%)
%   @.norm      : Whether or not to perform normalization. 
%                 Enter 'true' or 'false'.
%
% Output
% fitEMG        : A Struct.
%   @.data      : Fitted chromatographic profiles.
%   @.param     : Fit value of parameter [mu, sigma, tao] for each profile.
%                 Output a matrix with size of [comp, 3].
%   @.e         : Fit value of parameter 'e' (residual term).
%
% Note that:  The importance of the initial value (estimate) of the 
% parameters is beyond imagination!!!
%
% This script performs chromatographic profiles fitting based on the 
% Exponentially Modified Gaussian (EMG) model.
%
% Reference: https://doi.org/10.1007/BF02268168
%            https://doi.org/10.1021/ac00255a033(ORIGIN)
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.10.18 
% vgeler9602@gmail.com


% ****************************************
%   [Step 0] Check input and set system variables
% ****************************************
DimX = size(Xrt);

if nargin < 2, kwargs = struct(); end
if ~isfield(kwargs, 'isshow'), kwargs.isshow = 0; end
if ~isfield(kwargs, 'idx'), kwargs.idx = []; end
if ~isfield(kwargs, 'axis'), kwargs.axis = (1:DimX(1))'; end
if ~isfield(kwargs, 'SNr'), kwargs.SNr = 0.01; end
if ~isfield(kwargs, 'norm'), kwargs.norm = true; end

if isempty(kwargs.idx), kwargs.idx = 1 : DimX(1); end
if isrow(kwargs.axis), kwargs.axis = kwargs.axis'; end

% ****************************************
%   [Step 1] Fit chromatographic profiles based on EMG model
% ****************************************
% [Part 1.1] Set global parameters
EMGEqn = ['exp(0.5*(sigma/tao)^2-(x-mu)/tao)', ...
    '*(erf(1/sqrt(2)*(mu/sigma+sigma/tao))', ...
    '+erf(1/sqrt(2)*((x-mu)/sigma-sigma/tao)))', ...
    '+e'];
ft = fittype(EMGEqn);
fopt = fitoptions( 'Method', 'NonlinearLeastSquares' );
fopt.Algorithm = 'Trust-Region';
fopt.Display = 'Off';
fopt.StartPoint = ones(1, 4);                                               % e, mu, sigma, tao

fitEMG.data = zeros(DimX(1), DimX(2));
fitEMG.param = zeros(DimX(2), 3);                                           % [mu, sigma, tao]
fitEMG.e = zeros(1, DimX(2));

for c_ = 1 : DimX(2)
    % [Part 1.2] Initialization
    chroma = Xrt(kwargs.idx, c_);

    [h0, mu0] = max(chroma);
    mu0 = kwargs.axis(kwargs.idx(mu0));
    e0 = h0 * kwargs.SNr;
    lp = find(chroma > 0.5*h0, 1, 'first');
    rp = find(chroma > 0.5*h0, 1, 'last');
    if lp == 1 && rp < length(kwargs.idx) 
        rp = kwargs.axis(kwargs.idx(rp));
        sigma0 = rp - mu0;
    elseif rp == length(kwargs.idx) && lp > 1
        lp = kwargs.axis(kwargs.idx(lp));
        sigma0 = mu0 - lp;
    else
        lp = kwargs.axis(kwargs.idx(lp));
        rp = kwargs.axis(kwargs.idx(rp));
        sigma0 = min((rp-lp)*0.5, min(rp-mu0, mu0-lp));
    end                                      
    tao0 = sqrt(sigma0);
    
    fopt.StartPoint = [e0, mu0, sigma0, tao0];
    
    % [Part 1.3] Search results
    fitresult = fit(kwargs.axis(kwargs.idx), chroma, ft, fopt);

    % [Part 1.4] Record results
    fitEMG.data(:, c_) = fitresult(kwargs.axis);
    fitEMG.param(c_, :) = [fitresult.mu, fitresult.sigma, fitresult.tao];
    fitEMG.e(c_) = fitresult.e;
end
clear EMGEqn ft fopt c_ chroma fitresult
clear e0 h0 mu0 sigma0 tao0 e h mu sigma tao lp rp

% ****************************************
%   [Step 2] Output results
% ****************************************
fitEMG.data = fitEMG.data - fitEMG.e;
if kwargs.norm
    fitEMG.data = fitEMG.data ./ vecnorm(fitEMG.data);
end

% ****************************************
%   [Step 3] Plot results
% ****************************************
if kwargs.isshow
    figure('Name', 'ChromaFitting [EMG]', ...
        'Position', [400, 400, 600, 300], 'NumberTitle', 'off'); 
    hold on
    plot([kwargs.axis(1), kwargs.axis(end)], [0, 0], 'k:');
    p0 = plot(kwargs.axis(1:DimX(1)), Xrt - fitEMG.e, ...
        'Color', [0, 114, 189] ./ 255, 'LineWidth', 0.8, ...
        'DisplayName', 'Ori-err');    
    p1 = plot(kwargs.axis, fitEMG.data, 'LineWidth', 1.7, ...
        'Color', [234, 67, 53] ./ 255, 'DisplayName', 'Fit');
    p2 = plot(kwargs.axis(1:DimX(1)), Xrt, 'Color', [0.4, 0.4, 0.4], ...
        'LineWidth', 0.8, 'DisplayName', 'Origin');     
    xlim([kwargs.axis(1), kwargs.axis(end)]);
    ylim(vplot_ylimit([Xrt, fitEMG.data(1:DimX(1), :)]));
    legend([p1(1), p2(1), p0(1)]);
    clear p1 p2 p0
end
end

function ylimit = vplot_ylimit(data, scaler)
if nargin < 2, scaler = 0.05; end
lim(1) = min(data, [], 'all');
lim(2) = max(data, [], 'all');
lim(3) = (lim(2) - lim(1)) * scaler;
ylimit = [lim(1)-lim(3), lim(2)+lim(3)];
end