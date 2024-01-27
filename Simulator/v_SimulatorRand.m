%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-10-22: Created & Completed in the main
% 2023-10-29: Modify the way to generate system noise. [Step 6]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [simuData] = v_SimulatorRand(Chroma, Spec, ...
    idx_comp, sz_sample, noiselevel, baseline, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Input
% Chroma        : Chromatgraphic data (struct) from actual HPLC-DAD 
%                 measurements. 
% Spec          : Spectra data (struct) from actual HPLC-DAD measurements.
% idx_comp      : The index of components to be used for generating
%                 simulated data. 
% sz_sample     : Number of samples
% uniTable      : The name of the Uniform Design Table to be used for
%                 designing concentration profiles.
% noiselevel    : Noise level. Enter a value for [0, ~]. 
%      (default): 0.1 for sigma = noiselevel / 3, noise = sigma * randn().
% baseline      : The type baseline. Enter a specified string.
%        'none' : Do not add baseline items. (default)
%     'sigmoid' : Add 'sigmoid' baseline. (ascending or descending cruve)
%       'gauss' : Add 'gaussian' baseline. (convex curve)
%         'cos' : Add 'cosine' baseline. (ascending or descending cruve)
%         'sin' : Add 'sine' baseline. (convex curve)
%      'linear' : Add 'linear' baseline. (ascending or descending cruve)
% kwargs        : A Struct for optional parameters.
%   @.shift     : The [lower, upper] limits on the degree of retention time 
%                 offset. Enter a matrix with size of [sz_comp, 2].
%            [] : No retention time shift (meet the trilinear structure)
%   @.concRange : Concentration Range of components. Enter a matrix with
%                 size of [sz_sam, 2]. 
%      (default): [10, 1000].
%   @.blparam   : The parameters used to generate baseline. Enter a 
%                 4-element vector [A, B, C, D] to represent the following
%                 transformation in chromatographic mode:
%       'gauss' : f(x) = A * gaussmf(x, [B*(sz_rt/6), 0.5*sz_rt+c]) + D
%     'sigmoid' : f(x) = A ./ (1 + exp(-B*(x - C) ) ) + D
%         'cos' : f(x) = A * cos(pi/sz_rt * (B*x + C) ) + D
%         'sin' : f(x) = A * sin(pi/sz_rt * (B*x + C) ) + D
%      'linear' : f(x) = A * (1/sz_rt * (B*x + C) ) + D
%                 Besides, deviations of [-5%, 5%] will be randomly added
%                 to this four parameter, and 0.5% noise will also be added
%                 to the baseline itself.
%   @.compName  : The name of components used for generating.
%   @.isshow    : Whether to plot the results.
%           '0' : Do not plot the results. (default)
%           '1' : Plot the results.
%   @.seed      : Random seed.
%
% Output
% simuData      : A Struct for simulated HPLC-DAD data.
%   @.data      : HPLC-DAD measurements. Output a 3-way tensor with size of 
%                 [sz_rt, sz_wl, sz_comp].
%   @.DimX      : Number of data points for dimensions of chromatogram,
%                 spectra, sample, and components.
%   @.axis      : The coordinate axes for dimensions of retention time, 
%                 wavelength, and samples.
%   @.axisunit  : The unit of above coordinate axes.
%   @.compName  : The name of components used for generating.
%   @.profileChroma : The true chromatographic profiles. Output a 3-way
%                 tensor with size of [sz_rt, sz_comp, sz_sam].
%   @.profileSpec   : The true spectra profiles. Output a matrix with size
%                 of [sz_wl, sz_comp].
%   @.profileConc   : The true concentration profiles. Output a matrix with
%                 size of [sz_sam, sz_comp].
%   @.baseline  : Output a [true/false] to represent whether the baseline
%                 is included. If true, the baseline term has been merged
%                 to the end.
%   @.param     : Record some inputed parameters. (Struct)
%
% Note that: This script provides a simulator for generating a group of 
% HPLC-DAD data from actual measured chromatographic and spectra profiles, 
% where the concentration is simulated based on a random uniform
% distribution (with a deviation of [-5%, 5%]).
% This simulator supports the following scenarios: 
% (1) Nonlinear (variable) retention time shift; 
% (2) Instrument noise; 
% (3) Baseline drift.
% The script will be continuously updated!

% Copyright (C) 2023  VGeler
% Last edited:  2023.10.29
% vgeler9602@gmail.com

% ****************************************
%   [Step 1] Check input and set system variables
% ****************************************
vpath = string(fileparts(mfilename('fullpath')));
addpath(vpath + "\common");

if nargin < 5, noiselevel = 0.1; end
if nargin < 6, baseline = "none"; end
if nargin < 7, kwargs = struct(); end

% [Part 1.0] Set global parameters
DimX = [0, 0, 0, length(idx_comp)];

% [Part 1.1] Load chromatographic profiles
CHROMA = struct();
reg = [min(Chroma.idxRT(idx_comp, 1)), max(Chroma.idxRT(idx_comp, 2))];
DimX(1) = reg(2) - reg(1) + 1;
CHROMA.data = zeros(DimX(1), DimX(4));
CHROMA.axis = Chroma.axis(reg(1) : reg(2));
CHROMA.unit = Chroma.unit;
if isfield(Chroma, 'paramEMG')
    CHROMA.paramEMG = Chroma.paramEMG(idx_comp, :);
    CHROMA.paramEMG(:, 1) = CHROMA.paramEMG(:, 1) - (reg(1) - 1);
    axis = 1 : DimX(1);
    CHROMA.data = cell2mat(...
        v_ChromaGenerate_EMG(axis, CHROMA.paramEMG, struct('isshow', 0))' );
else
    for cp_ = 1 : DimX(4)
        c_ = idx_comp(cp_);
        axis = Chroma.idxRT(c_, :) - (reg(1) - 1);
        CHROMA.data(axis(1) : axis(2), cp_) = Chroma.data(:, c_);
    end
    rovEMG = v_ChromaFitting_EMG(CHROMA.data, struct('isshow', 0));
    CHROMA.paramEMG = rovEMG.param;
    CHROMA.paramEMG(:, 1) = round(CHROMA.paramEMG(:, 1));
end
CHROMA.data = CHROMA.data ./ vecnorm(CHROMA.data);
clear reg axis cp_ c_ rovEMG

% [Part 1.2] Load spectra profiles
SPEC = struct();
reg = [min(Spec.idxWL(idx_comp, 1)), max(Spec.idxWL(idx_comp, 2))];
DimX(2) = reg(2) - reg(1) + 1;
SPEC.data = zeros(DimX(2), DimX(4));
SPEC.axis = Spec.axis;
SPEC.unit = Spec.unit;
for cp_ = 1 : DimX(4)
    c_ = idx_comp(cp_);
    axis = Spec.idxWL(c_, :) - (reg(1) - 1);
    SPEC.data(axis(1) : axis(2), cp_) = Spec.data(:, c_);
end
SPEC.data = SPEC.data ./ vecnorm(SPEC.data);
clear reg axis cp_ c_

% [Part 1.3] Set parameters for concentration profiles
DimX(3) = sz_sample;
CONC = struct();
CONC.data = zeros(DimX(3), DimX(4));
if ~isfield(kwargs, 'concRange'), kwargs.concRange = [10, 1000] * ones(DimX(4), 1); end

% [Part 1.4] Check and complete the 'kwargs' Struct
if ~isfield(kwargs, 'shift'), kwargs.shift = []; end
if ~isfield(kwargs, 'blparam'), kwargs.blparam = []; end
if ~any(baseline == ["sigmoid", "gauss", "cos", "sin", "linear"])
    kwargs.blparam = [1.0, 0.2, 0, 0]; 
end
if ~isfield(kwargs, 'isshow'), kwargs.isshow = false; end
if ~isfield(kwargs, 'seed') || (isstring(kwargs.seed) && kwargs.seed == "time")
    seed = clock;
    seed = round( sum(seed(4:6)) * sum(seed(1:3)) / 100 );
else
    seed = 'default';
end
rng(seed); 

% ****************************************
%   [Step 2] Randomly simulate retention time shift (Normal distribution)
% ****************************************
if ~isempty(kwargs.shift) && any(kwargs.shift(:))
    CHROMA.shift = zeros(DimX(3), DimX(4));
    for c_ = 1 : DimX(4)
        m_ = (kwargs.shift(c_, 2) - kwargs.shift(c_, 1)) / 3;
        CHROMA.shift(:, c_) = ...
            round(m_ * randn(DimX(3), 1) + mean(kwargs.shift(c_, :)) );
    end
end
clear c_ m_

% ****************************************
%   [Step 3] Randomly simulate concentration (Uniform Distribution)
% ****************************************
for c_ = 1 : DimX(4)
    CONC.data(:, c_) = randi(kwargs.concRange(c_, :), DimX(3), 1);
end
dev = 1 - randn(DimX(3), DimX(4)) .* (0.05 / 3);
CONC.data = CONC.data .* dev;
clear c_ dev

% ****************************************
%   [Step 4] Simulate baseline
% ****************************************
if baseline ~= "none"
    % [Part 4.1] Initialization
    BL = struct();
    BL.chroma = zeros(DimX(1), DimX(3));
    BL.spec = zeros(DimX(2), DimX(3));
    BL.conc = zeros(1, DimX(3));

    % [Part 4.2] Generate baseline for chromatographic mode
    blp = repmat(kwargs.blparam', 1, DimX(3));
    dev = randn(4, DimX(3)) .* (0.05 / 3);
    dev(1:3, :) = 1 - dev(1:3, :);
    blp(1:2, :) = blp(1:2, :) .* dev(1:2, :);
    if ~isempty(kwargs.shift)
        blp(3, :) = blp(3, :) + mean(CHROMA.shift, 2)' .* dev(3, :);
    end
    blp(4, :) = blp(4, :) + kwargs.blparam(1) * dev(4, :);
    if baseline == "sigmoid"
        axis = (1 : DimX(1))' - round(DimX(1) * 0.5);
        BL.chroma = blp(4, :) + blp(1, :) ./ ...
            (1 + exp( -blp(2, :) .* (axis - blp(3, :)) ) ) ;
    end
    if baseline == "gauss"
        axis = (1 : DimX(1))';
        gp = [1, DimX(1)/6, DimX(1)*0.5, 1];
        for s_ = 1 : DimX(3)
            BL.chroma(:, s_) = blp(4, s_) + blp(1, s_) .* ...
            gaussmf(axis, [gp(2)*blp(2, s_), gp(3)+blp(3, s_)]);
        end
    end
    if baseline == "cos"
        axis = (1 : DimX(1))';
        axis = pi/DimX(1) .* ( blp(2, :) .* axis + blp(3, :) );
        BL.chroma = blp(1, :) .* cos(axis) + blp(4, :);
    end
    if baseline == "sin"
        axis = (1 : DimX(1))' - round(DimX(1) * 0.5);
        axis = pi/DimX(1) .* ( blp(2, :) .* axis + blp(3, :) );
        BL.chroma = blp(1, :) .* cos(axis) + blp(4, :);
    end
    if baseline == "linear"
        axis = (1 : DimX(1))';
        axis = 1/DimX(1) .* (blp(2, :) .* axis + blp(3, :));
        BL.chroma = blp(1, :) .* axis + blp(4, :);
    end
    noise = randn(DimX(1), DimX(3));
    scaler = 0.005 * std(BL.chroma) ./ std(noise);
    BL.chroma = BL.chroma + scaler .* noise;

    % [Part 4.3] Generate baseline for spectra mode
    axis = (1 : DimX(2))';
    spec_aver = mean(SPEC.data, 2);
    scaler = (1 ./ axis) .^ 0.5;
    BL.spec = spec_aver .* scaler;
    noise = randn(DimX(2), 1);
    scaler = 0.005 * std(BL.spec) ./ std(noise);
    BL.spec = BL.spec + scaler .* noise;


    % [Part 4.4] Normalization
    BL.conc = vecnorm(BL.chroma) * vecnorm(BL.spec);
    BL.chroma = BL.chroma ./ vecnorm(BL.chroma);
    BL.spec = BL.spec ./ vecnorm(BL.spec);

    % [Part 4.5] Debug
%     figure('Position', [200,200,1600,250], 'NumberTitle', 'off', 'Name', 'Baseline');
%     subplot(1,4,1);surf(BL.chroma(:, 1) .* BL.conc(1) * BL.spec', 'LineStyle', 'none');
%     subplot(1,4,2);plot(BL.chroma);
%     subplot(1,4,3);plot(BL.spec);
%     subplot(1,4,4);plot(BL.conc, 'Marker', '.', 'MarkerSize', 10);

    clear blp dev axis gp s_ noise spec_aver scaler
end

% ****************************************
%   [Step 5] Generate HPLC-DAD data
% ****************************************
simuData = struct();
simuData.data = zeros(DimX(1), DimX(2), DimX(3));
simuData.DimX = DimX;
simuData.axis = {CHROMA.axis; SPEC.axis; (1:DimX(3))'};
simuData.axisunit = [CHROMA.unit; SPEC.unit; ""];
if isfield(kwargs, 'compName'), simuData.compName = kwargs.compName;
else, simuData.compName = "Comp" + string(1:DimX(4))'; end
simuData.profileChroma = [];
simuData.profileSpec = SPEC.data;
simuData.profileConc = CONC.data;
simuData.baseline = baseline ~= "none";

% [Part 5.2] Generate chromatographic profiles
if isfield(CHROMA, 'shift')
    simuData.profileChroma = zeros(DimX(1), DimX(4), DimX(3));
    axis = 1 : DimX(1);
    for s_ = 1 : DimX(3)
        paramEMG = CHROMA.paramEMG;
        paramEMG(:, 1) = paramEMG(:, 1) + CHROMA.shift(s_, :)';
        simuData.profileChroma(:, :, s_) = cell2mat(...
            v_ChromaGenerate_EMG(axis, paramEMG)' );
    end
else
    simuData.profileChroma = CHROMA.data;
end

% [Part 5.3] Merge baseline as a component
if simuData.baseline
    simuData.DimX(4) = simuData.DimX(4) + 1;
    c_ = simuData.DimX(4);
    simuData.profileChroma(:, c_, :) = BL.chroma;
    simuData.profileSpec(:, c_) = BL.spec;
    simuData.profileConc(:, c_) = BL.conc;
    simuData.compName(c_) = "Baseline";
    clear c_
end

% [Part 5.4] Generate HPLC-DAD data
spec = simuData.profileSpec';
for s_ = 1 : DimX(3)
    if isfield(CHROMA, 'shift'), chroma = simuData.profileChroma(:, :, s_);
    else, chroma = simuData.profileChroma; end
    simuData.data(:, :, s_) = chroma .* simuData.profileConc(s_, :) * spec;
end
clear s_ axis paramEMG chroma spec

% ****************************************
%   [Step 6] Simulate noise (Normal distribution)
% ****************************************
if noiselevel > 0
    noise = (noiselevel / 3) * randn(DimX(1), DimX(2), DimX(3));
    simuData.data = simuData.data + noise;
    clear noise
end

% ****************************************
%   [Step 7] Output results
% ****************************************
simuData.param.idx_comp = idx_comp;
simuData.param.noiselevel = noiselevel;
simuData.param.baseline = baseline;
if baseline == "none", simuData.param.blparam = [];
else, simuData.param.blparam = kwargs.blparam; end
simuData.param.shift = kwargs.shift;
simuData.param.concRange = kwargs.concRange;
simuData.param.seed = seed;

% ****************************************
%   [Step 8] Show results
% ****************************************
if kwargs.isshow
    figure('Name', 'Simulated HPLC-DAD data (Uniform Design)', ...
        'Position', [200 200 1200 600], 'NumberTitle', 'off');
    subplot(2, 2, 1); hold on
        ylimit = [];
        for s_ = 1 : DimX(3)
            set(gca, 'ColorOrderIndex', 1);
            chroma = simuData.profileChroma(:, :, s_) .* simuData.profileConc(s_, :);
            plot(simuData.axis{1}, chroma);
            ylimit = vplot_ylimit(chroma, ylimit);
        end
        xlabel("Time (" + simuData.axisunit(1) + ")");
        xlim(simuData.axis{1}([1, end]));
        ylabel("Intensity");
        ylim(ylimit);
        title('Simulated Chromatogram');
    subplot(2, 2, 3); hold on
        color = get(gca, "ColorOrder");
        for c_ = 1 : DimX(4)
            plot([1, 1] * simuData.axis{1}(CHROMA.paramEMG(c_, 1)), [1, DimX(3)], ...
                'Color', color(c_, :), 'LineStyle', ':');
            set(gca, "ColorOrderIndex", c_);
            [~, peaks] = max( squeeze(simuData.profileChroma(:, c_, :)) );
            scatter(simuData.axis{1}(peaks), simuData.axis{3}, ...
                'Color', color(c_, :), 'Marker', '.', 'SizeData', 100);
        end
        xlabel("Time (" + simuData.axisunit(1) + ")");
        xlim(simuData.axis{1}([1, end]));
        ylabel("Sample");
        ylim([1, DimX(3)]);
        title('Simulated Retention Time Shift');
    subplot(2, 2, 2); hold on
        plot(simuData.axis{2}, simuData.profileSpec, 'LineWidth', 1.5);
        xlabel("Wavelength (" + simuData.axisunit(2) + ")");
        xlim(simuData.axis{2}([1, end]));
        ylabel("Intensity (normalized)");
        ylim(vplot_ylimit(simuData.profileSpec));
        if isfield(simuData, 'compName')
            legend(simuData.compName, 'Location','best');
        end
        title('Spectra Profiles');
    subplot(2, 2, 4); hold on
        plot(simuData.axis{3}, simuData.profileConc, ...
            'Marker', '.', 'MarkerSize', 15, 'LineWidth', 1.5);
        xlabel("Sample");
        xlim(simuData.axis{3}([1, end]));
        ylabel("Concentration")
        ylim(vplot_ylimit(simuData.profileConc));
        title('Simulated Concentration');
    clear s_ c_ ylimit chroma peaks color
end

% rmpath(vpath + "\common");
clear vpath
end


function ylimit = vplot_ylimit(data, ylimit, scaler)
if nargin < 2 || isempty(ylimit), ylimit = [inf, -inf]; end
if nargin < 3, scaler = 0.05; end
lim(1) = min(data, [], 'all');
lim(2) = max(data, [], 'all');
lim(3) = (lim(2) - lim(1)) * scaler;
ylimit = [min(ylimit(1), lim(1)-lim(3)), max(ylimit(2), lim(2)+lim(3))];
end
