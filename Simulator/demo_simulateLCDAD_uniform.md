# Simulator
**[DESCRIPTION]**\
&emsp;This demo script that generates a groups of HPLC-DAD data using v_SimulatorUniform.m function, which supports the following scenarios:\
&emsp;(1) Nonlinear (variable) retention time shift;\
&emsp;(2) Instrument noise;\
&emsp;(3) Baseline drift.\
&emsp;Please refer to (https://doi.org/********) for citation.\
**[DOWNLOAD]**\
https://github.com/V-Geler/Conv2dPA/tree/main/Simulator

# 
```
clc, clear, close all;
```
Load an actual measurements from "./data/"\
e.g. protoberberine-type alkaloids in Coptidis Rhizoma
```
load('data/Profile_CoptidisRhizoma.mat');
DimX = [length(Chroma.axis), length(Spec.axis), length(name)];
```
(OPTIONAL) Visualization chromatographic and spectra profiles
```
figure('Name', 'protoberberine-type alkaloids in Coptidis Rhizoma', ...
    'Position', [200 400 700 500], 'NumberTitle', 'off');
subplot(2, 1, 1); hold on
    flag = iscell(Chroma.data);
    for c_ = 1 : DimX(3)
        reg = Chroma.idxRT(c_, :);
        if flag, plot(Chroma.axis(reg(1):reg(2)), Chroma.data{c_});
        else, plot(Chroma.axis(reg(1):reg(2)), Chroma.data(:, c_)); end
    end
    legend(name, 'Location', 'northeast');
    title('Chromatographic profiles');
subplot(2, 1, 2); hold on
    for c_ = 1 : DimX(3)
        reg = Spec.idxWL(c_, :);
        plot(Spec.axis(reg(1):reg(2)), Spec.data(:, c_));
    end
    legend(name, 'Location', 'northeast');
    title('Spectra profiles');
clear c_ reg flag
```
Choose the Uniform Design Table
```
% load("data\Conc_uniform.mat");
% disp(ConcUniform.name);
```
(OPTIONAL) Visualization Uniform Design Table
```
% uniTable = "U10*(10^8)";
% uniIdx = find(ConcUniform.name == uniTable);
% figure('Position', [250 200 600 300], 'NumberTitle', 'off', ...
%     'Name', ['Uniform Design [', convertStringsToChars(uniTable), ']']); hold on
%     fidx = ConcUniform.fidx(uniIdx, :);
%     for c_ = 1 : fidx(3)
%         level = ConcUniform.table{uniIdx, 1}(:, c_);
%         plot(level, 'Marker', '.', 'MarkerSize', 15);
%         text(double(fidx(2))+0.2, level(end), num2str(c_));
%     end
%     xlabel('Sample');
%     xlim([1 fidx(2)]);
%     ylabel('Concentration Level');
%     ylim([0 fidx(2)+1]);
% clear uniTable uniIdx fidx c_ level
```
Set parameters for v_SimulatorUniform.m function\
**[TARGET]** 4 analytes of interest (COL, EPI, JAT, COP) and a unknown interference (embedded in peak of COP); 10 samples; design the concentration of 4 analytes based on table "U10*(10^8)"; randomly design the concentration of interference; 0.5% level of noise; increasing retention time shift degrees of analytes; baseline drift.
```
idx_comp = [1, 2, 3, 4, 7];
uniTable = "U10*(10^8)";
noiselevel = 0.1 ;                                          % Optional
baseline = "sigmoid";                                       % Optional

kwargs = struct();
kwargs.shift = [-5, 5; -3, 10; -1, 15; 3, 20; 5, 15];       % Optional
kwargs.uniOrder = [2, 1, 3, 4, -1];                         % Optional
kwargs.concLOD = [10, 20, 10, 10, 50];                      % Designed
kwargs.concScaler = [100, 100, 100, 100, 1.5];              % Designed
kwargs.blparam = [100, 0.02, -20, 50];                      % Designed
kwargs.compName = name(idx_comp);                           % Optional
kwargs.isshow = true;                                       % Optional
kwargs.seed = "time";                                       % Default (Optional)
```
RUN and SAVE simulated result
```
pkg load statistics
simuData = v_SimulatorUniform(Chroma, Spec, idx_comp, uniTable, noiselevel, baseline, kwargs);

t = clock;
t(1) = mod(t(1), 100);
t(6) = round(t(6));
save(["test/simuUni_", num2str(t, "%02d"), ".mat"], 'simuData');
clear t
```

#
**[USEFUL VISUALIZATION]**\
Load data
```
clc, clear, close all;
load('test\demo_simuUni.mat', "simuData");
sD = simuData;
```
**(a) 3-D surface map of a single sample**
```
idxsam = 1;
figure('Position', [250 500 600 300], 'NumberTitle', 'off', ...
    'Name', ['Surface of [Sample ', num2str(idxsam), ']']);
    [X, Y] = meshgrid(sD.axis{2}, sD.axis{1});
    surf(X, Y, sD.data(:, :, idxsam), 'LineStyle', 'none');
    set(gca, 'ColorMap', jet);
    xlabel(["Wavelength (", sD.axisunit{2}, ")"], 'Rotation', 9);
    xlim([sD.axis{2}([1, end])]);
    ylabel(["Time (", sD.axisunit{1}, ")"], 'Rotation', -15);
    ylim([sD.axis{1}([1, end])]);
    set(gca, 'YDir', 'reverse');
    zlim(vplot_ylimit(sD.data(:, :, idxsam)));
clear idxsam X Y
```
**(b) 2-D contour map, Chromatogram, Spectra of a single sample**
```
idxsam = 1;
figure('Position', [250 450 1200 300], 'NumberTitle', 'off', ...
    'Name', ['Visualization of [Sample ', num2str(idxsam), ']']);
subplot(1, 3, 1); hold on
    [X, Y] = meshgrid(sD.axis{1}, sD.axis{2});
    contour(X, Y, squeeze(sD.data(:, :, idxsam))', 200);
    set(gca, 'ColorMap', hot);
    xlabel(["Time (", sD.axisunit{1}, ")"]);
    ylabel(["Wavelength (", sD.axisunit{2}, ")"]);
    title('Contour');
subplot(1, 3, 2); hold on
    chroma = sD.profileChroma(:, :, idxsam) .* sD.profileConc(idxsam, :);
    plot(sD.axis{1}, chroma, 'LineWidth', 1.5);
    xlabel(["Time (", sD.axisunit{1}, ")"]);
    xlim(sD.axis{1}([1, end]));
    ylabel("Intensity");
    ylim(vplot_ylimit(chroma));
    title('Chromatogram');
subplot(1, 3, 3); hold on
    plot(sD.axis{2}, sD.profileSpec, 'LineWidth', 1.5);
    xlabel(["Wavelength (", sD.axisunit{2}, ")"]);
    xlim(sD.axis{2}([1, end]));
    ylabel("Intensity (normalized)");
    ylim(vplot_ylimit(sD.profileSpec));
    if isfield(sD, 'compName'), legend(sD.compName, 'Location', 'northeast'); end
    title('Spectra');
clear idxsam X Y c_ ylimit chroma
```
**(c) Chromatograms at characteristic wavelength**
```
wl = 345;
idxwl = find(sD.axis{2} >= wl, 1);
wl = sD.axis{2}(idxwl);
figure('Position', [250 400 600 300], 'NumberTitle', 'off', ...
    'Name', ['Chromatograms at ', num2str(wl), ' ', sD.axisunit{2}]);
    plot(sD.axis{1}, squeeze(sD.data(:, idxwl, :)), 'LineWidth', 1.5);
    set(gca, 'ColorOrder', jet(sD.DimX(3)));
    xlabel(["Time (", sD.axisunit{1}, ")"]);
    xlim(sD.axis{1}([1, end]));
    ylabel("Intensity");
    ylim(vplot_ylimit(sD.data(:, idxwl, :)));
clear idxwl wl
```
**(d) Overall visualization**
```
figure('Position', [250 150 800 500], 'NumberTitle', 'off', ...
    'Name', 'Overall visualization');
subplot(2, 2, 1); hold on
    ylimit = [];
    for s_ = 1 : sD.DimX(3)
        set(gca, 'ColorOrderIndex', 1);
        chroma = sD.profileChroma(:, :, s_) .* sD.profileConc(s_, :);
        plot(sD.axis{1}, chroma);
        ylimit = vplot_ylimit(chroma, ylimit);
    end
    xlabel(["Time (", sD.axisunit{1}, ")"]);
    xlim(sD.axis{1}([1, end]));
    ylabel("Intensity");
    ylim(ylimit);
    title('Chromatogram');
subplot(2, 2, 2); hold on
    plot(sD.axis{2}, sD.profileSpec, 'LineWidth', 1.5);
    xlabel(["Wavelength (", sD.axisunit{2}, ")"]);
    xlim(sD.axis{2}([1, end]));
    ylabel("Intensity (normalized)");
    ylim(vplot_ylimit(sD.profileSpec));
    if isfield(sD, 'compName'), legend(sD.compName, 'Location', 'northeast'); end
    title('Spectra');
subplot(2, 2, 3); hold on
    color = get(gca, "ColorOrder");
    for c_ = 1 : sD.DimX(4)-sD.baseline
        set(gca, "ColorOrderIndex", c_);
        [~, peaks] = max( squeeze(sD.profileChroma(:, c_, :)) );
        plot(sD.axis{1}(peaks), sD.axis{3}, 'LineStyle', 'none', ...
            'Color', color(c_, :), ...
            'Marker', '.', 'MarkerSize', 15);
    end
    xlabel(["Time (", sD.axisunit{1}, ")"]);
    xlim(sD.axis{1}([1, end]));
    ylabel("Sample");
    ylim([1, sD.DimX(3)]);
    title('Peak distribution');
subplot(2, 2, 4); hold on
    plot(sD.axis{3}, sD.profileConc, ...
        'Marker', '.', 'MarkerSize', 15, 'LineWidth', 1.5);
    xlabel("Sample");
    xlim(sD.axis{3}([1, end]));
    ylabel("Concentration")
    ylim(vplot_ylimit(sD.profileConc));
    title('Simulated Concentration');
clear s_ c_ ylimit chroma peaks color

```
#