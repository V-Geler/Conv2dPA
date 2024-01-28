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

% ****************************************
%   [Step 0] Check the legality of input parameters
% ****************************************
if nargin < 2 || isempty(axis), axis = {[], [], []}; end
if nargin < 3, idxcomp = []; end
if nargin < 4, kwargs = struct(); end

% [Part 0.2] Check cell 'Pf'
if ~iscell(Pf), Pf = {Pf, [], []}; end
if length(Pf) < 3, Pf{3} = []; end
isplot = ~[isempty(Pf{1}), isempty(Pf{2}), isempty(Pf{3})];

DimX = zeros(1, 4);
if isplot(1), DimX(1) = size(Pf{1}, 1); end
if isplot(2), DimX(2) = size(Pf{2}, 1); end
if isplot(3), DimX(3) = size(Pf{3}, 1);
elseif isplot(1), DimX(3) = size(Pf{1}, 3);
elseif isplot(2), DimX(3) = size(Pf{2}, 3);
end
DimX(4) = max([...
    isplot(1) * size(Pf{1}, 2), ...
    isplot(2) * size(Pf{2}, 2), ...
    isplot(3) * size(Pf{3}, 2)]);
if ~isplot(3), Pf{3} = ones(DimX(3), DimX(4)); end

% [Part 0.2] Check cell 'axis'
if ~iscell(axis), axis = {axis, [], []}; end
if length(axis) < 3, axis{3} = []; end
if isempty(axis{1}), axis{1} = (1 : DimX(1))'; end
if isempty(axis{2}), axis{2} = (1 : DimX(2))'; end
if isempty(axis{3}), axis{3} = (1 : DimX(3))'; end

% [Part 0.3] Check parameter 'idxcomp'
if isempty(idxcomp), idxcomp = 1 : DimX(4); end
if islogical(idxcomp), idxcomp = find(idxcomp); end
if ~all(ismember(idxcomp, 1 : DimX(4))), error('[ERROR] Incorrect value of "idxcomp"!!!'); end

% [Part 0.4] Check struct 'kwargs'
if ~isfield(kwargs, 'unit'), kwargs.unit = [""; ""; ""]; end
if length(kwargs.unit) < 2, kwargs.unit = ""; end
if kwargs.unit(1) ~= "", kwargs.unit(1) = " (" + kwargs.unit(1) + ")"; end
if kwargs.unit(2) ~= "", kwargs.unit(2) = " (" + kwargs.unit(2) + ")"; end

% ****************************************
%   [Step 1] Obtain profiles to plot
% ****************************************
if isplot(1)
    if ismatrix(Pf{1}), Pf{1} = Pf{1}(:, idxcomp); else, Pf{1} = Pf{1}(:, idxcomp, :); end
end
if isplot(2)
    if ismatrix(Pf{2}), Pf{2} = Pf{2}(:, idxcomp); else, Pf{2} = Pf{2}(:, idxcomp, :); end
end
if isplot(3)
    Pf{3} = Pf{3}(:, idxcomp); 
end
DimX(4) = length(idxcomp);
compName = "C" + string(1:DimX(4))';
if isfield(kwargs, 'compName')
    len = length(kwargs.compName);
    kwargs.compName(len+1 : DimX(4)) = "C" + string(len+1 : DimX(4))';
    compName = kwargs.compName(idxcomp);
    clear len
end

% ****************************************
%   [Step 2] Overall Visualization
% ****************************************
title_ = 'Overall Visualization';
if isfield(kwargs, 'title'), title_ = title_ + " [" + kwargs.title + "]"; end
figure('Name', title_, 'Position', [200 500 1300 300], 'NumberTitle', 'off');
tiledlayout(1, 3, 'TileSpacing', 'compact', 'Padding', 'compact');
nexttile; hold on
    if isplot(1)
        color = get(gca, 'ColorOrder');
        ylimit = [];
        if ismatrix(Pf{1})
            for c_ = 1 : DimX(4)
                set(gca, 'ColorOrderIndex', c_);
                chroma = Pf{1}(:, c_) * Pf{3}(:, c_)';
                plot(axis{1}, chroma, 'Color', color(c_, :));
                ylimit = vplot_ylimit(chroma, ylimit);
            end
        else
            for c_ = 1 : DimX(4)
                set(gca, 'ColorOrderIndex', c_);
                chroma = squeeze(Pf{1}(:, c_, :)) .* Pf{3}(:, c_)';
                plot(axis{1}, chroma, 'Color', color(c_, :));
                ylimit = vplot_ylimit(chroma, ylimit);
            end
        end
        xlabel("Time" + kwargs.unit(1));
        xlim(axis{1}([1, end]));
        ylabel("Intensity");
        ylim(ylimit);
    end
    title('Chromatogram');
nexttile; hold on
    if isplot(2)
        if ismatrix(Pf{2})
            pl = plot(axis{2}, Pf{2}, 'LineWidth', 1.5);
            ylimit = vplot_ylimit(Pf{2});
        else
            color = get(gca, 'ColorOrder');
            ylimit = [];
            pl = [];
            for c_ = 1 : DimX(4)
                set(gca, 'ColorOrderIndex', c_);
                spec = squeeze(Pf{2}(:, c_, :));
                p_ = plot(axis{2}, spec, 'Color', color(c_, :));
                pl(c_) = p_(1);
                ylimit = vplot_ylimit(spec, ylimit);
            end
        end
        xlabel("Wavelength" + kwargs.unit(2));
        xlim(axis{2}([1, end]));
        ylabel("Intensity (normalized)");
        ylim(ylimit);
        legend(pl, compName, 'Location','best');
    end
    title('Spectra');
nexttile; hold on
    if isplot(3)
        if DimX(3) > 1
            plot(axis{3}, Pf{3}, 'Marker', '.', 'MarkerSize', 15, 'LineWidth', 1.5);
            xlabel("Sample");
            xlim(axis{3}([1, end]));
            ylabel("Concentration")
            ylim(vplot_ylimit(Pf{3}));
        else
            for c_ = 1 : DimX(4)
                plot(c_, Pf{3}(c_), 'Marker', '.', 'MarkerSize', 15, 'LineWidth', 1.5);
            end
            xlabel("Component");
            xlim([1, DimX(4)]);
            ylabel("Intensity (relative)")
            ylim(vplot_ylimit(Pf{3}));
        end
    end
    title('Concentration');
clear title_ ylimit color chroma spec c_ pl p_

end




function ylimit = vplot_ylimit(data, ylimit, scaler)
data = squeeze(data);
if nargin < 2 || isempty(ylimit), ylimit = [inf, -inf]; end
if nargin < 3, scaler = 0.05; end
lim(1) = min(data, [], 'all');
lim(2) = max(data, [], 'all');
lim(3) = (lim(2) - lim(1)) * scaler;
ylimit = [min(ylimit(1), lim(1)-lim(3)), max(ylimit(2), lim(2)+lim(3))];
end