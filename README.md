# Conv2dPA
**[Conv2dPA]**&emsp;*[(Description)](https://github.com/V-Geler/Conv2dPA/tree/main/Conv2dPA/README_Conv2dPA.md)*\
&emsp;Two-dimensional convolution-based nonlinear retention time alignment solution for HPLC-DAD data
- Highly complex fingerprints
- Nonlinear retention time shift
- Overlapping and even embedded chromatographic profiles
- Baseline drift

**[Simulator]**\
&emsp;Generate simulated HPLC-DAD datasets. Supports simulation of:
- variable noise levels
- nonlinear retention time shift
- baseline drift (different shape and intensity)

# 2. Installation and Usage
2.1 GNU Octave version\
&emsp;Install *[GNU Octave 8.4.0](https://octave.org/download)* or higher on your computer.\
2.2 Usage\
&emsp;1. Download and unzip it from this URL.\
&emsp;2. Run iniconfig.m to add the folders to the GNU Octave search path.\
&emsp;3. Several demonstration scripts are provided. These should help users of the Conv2dPA solution and Simulator to get the first idea of how they can be applied. Useful codes for visualization are also provided to help interpret the results.\
&emsp;&emsp;&emsp;Conv2dPA/demo_Conv2dPA.md \
&emsp;&emsp;&emsp;Simulator/demo_simulateLCDAD_rand.md \
&emsp;&emsp;&emsp;Simulator/demo_simulateLCDAD_uniform.md \
&emsp;&emsp;Run the scripts in **GNU Octave (GUI)** window

# 3. Example
- Graphical illustration of the principles of techniques involved in Conv2dPA
<img src="https://github.com/V-Geler/Conv2dPA/blob/main/img/Conv2dPA_flowchart.jpg" alt="Image" width="750" height="auto">

- Simulated HPLC-DAD data
<img src="https://github.com/V-Geler/Conv2dPA/blob/main/img/Simulator_uniform.jpg" alt="Image" width="500" height="auto">

- Conv2dPA Fitting
<img src="https://github.com/V-Geler/Conv2dPA/blob/main/img/Conv2dPA_Fitting.jpg" alt="Image" width="750" height="auto">

- Conv2dPA Alignment (chromatogram at λ=270.41 nm)
<img src="https://github.com/V-Geler/Conv2dPA/blob/main/img/RawData%26Conv2dPA_chroma270.jpg" alt="Image" width="500" height="auto">

# 4. Contact
For any questions, please contact: An-Qi Chen, vgeler9602@gmail.com

# 5. Manuscript and citation
It will be announced once the manuscript is accepted for publication.