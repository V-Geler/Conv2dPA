# Conv2dPA
**[Conv2dPA]**\
&emsp;Two-dimensional convolution-based nonlinear retention time alignment solution for HPLC-DAD data
- Highly complex fingerprints
- Nonlinear retention time shift
- Overlapping and even embedded chromatographic profiles
- Baseline drift

# 2. Statement
&emsp;All original *[GNU Octave](https://octave.org/)* codes will be made public once upon the manuscript "**Conv2dPA: Two-dimensional Convolution Sharpening-Based Non-linear Alignment Solution for Chromatographic Fingerprints with High Complexity and Co-elution Behavior**" is accepted for publication.

&emsp;A **simulated dataset** (discussed in the manuscript) and several **demonstration scripts** are provided. We expect that these should help users of the Conv2dPA solution to get the first idea of how it can be applied. Useful codes for **visualization** are also provided to help interpret the results.\
&emsp;&emsp;./test/demo_simuData.mat --- Data\
&emsp;&emsp;./test/demo_simuData.txt --- Description\
&emsp;&emsp;./demo_Conv2dPA.md --- Demonstration scripts

&emsp;The text documents "*.txt" with the same name as the functions provide instructions of the **INPUT** and **OUTPUT** in the functions. They are also provided in the **original GNU Octave codes**.

# 3. Functions
- v_Conv2dPA_Fitting.m
- v_Conv2dPA_Reconstitution.m
- v_Conv2dPA_main.m
- v_Conv2dPA_estmProfile.m
- v_Conv2dPA_infoKernelChroma.m
- v_Conv2dPA_constrKernelChroma.m
- v_Conv2dPA_detectCandd.m
- v_Conv2dPA_rankCandd.m
- v_Conv2dPA_alignPeak.m
- v_Conv2dPA_orderComponent.m

# 4. Contact
For any questions, please contact: An-Qi Chen, vgeler9602@gmail.com

# 5. Manuscript and citation
It will be announced once the manuscript is accepted for publication.