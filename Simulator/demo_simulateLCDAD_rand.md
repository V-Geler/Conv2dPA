# Simulator
**[DESCRIPTION]**\
&emsp;This demo script that generates a groups of HPLC-DAD data using v_SimulatorRand.m function, which supports the following scenarios:\
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
e.g. Three analytes in Atractylodes macrocephala Koidz.
```
load('data/Profile_AtractylodesMacrocephala_reg2.mat');
DimX = [length(Chroma.axis), length(Spec.axis), length(name)];
```
(OPTIONAL) Visualization chromatographic and spectra profiles
```
figure('Name', 'Three analytes in Atractylodes macrocephala Koidz. (Region 2)', ...
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
Set parameters for v_SimulatorRand.m function\
**[TARGET]** 3 analytes of interest (FUA, SCO, UMB; 50 samples; randomly design the concentration (uniform distribution); 1.0% level of noise; increasing retention time shift degrees of analytes; baseline drift.
```
idx_comp = [1, 2, 3];
sz_sample = 50;                                             % Designed
noiselevel = 0.1;                                           % Optional
baseline = "sigmoid";                                       % Optional

kwargs = struct();
kwargs.shift = [-1, 1; -1, 3; 0, 5];                        % Optional
kwargs.concRange = [100, 300; 80, 300; 50, 350];            % Designed
kwargs.blparam = [-50, 0.2, -5, -50];                       % Designed
kwargs.compName = name(idx_comp);                           % Optional
kwargs.isshow = true;                                       % Optional
kwargs.seed = "time";                                       % Default (Optional)
```
RUN and SAVE simulated result
```
pkg load statistics
simuData = v_SimulatorRand(Chroma, Spec, idx_comp, sz_sample, noiselevel, baseline, kwargs);

t = clock;
t(1) = mod(t(1), 100);
t(6) = round(t(6));
save(["test/simuRand_", num2str(t, "%02d"), ".mat"], 'simuData');
clear t
```

#
**[USEFUL VISUALIZATION]**\
Load data
```
clc, clear, close all;
load('test\demo_simuRand.mat', "simuData");
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