%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2023-10-27: Created & Completed in the main.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [estimSVD] = v_InitEstimation_svd(X_RtWlSam, Fac, kwargs)
% ---------------------------------------------------------
%                    Initialize Factors 
% ---------------------------------------------------------
%
% Inputro
% X_RtWlSam     : HPLC-DAD measurements. Enter a 3-way tensor in the order 
%                 of [Elution time point, Wavelength point, Samples].
% Fac           : The number of factors. Enter a 3-element vector to
%                 represent Fac in each of the N modes. Or Enter a scaler
%                 to represent Fac (same in N modes).
% kwargs        : A Struct for optional parameters.
%   @.compress  : Whether to perform data compression. (Xunf = V' * Xunf)
%       'false' : Do not compress data. (default)
%        'true' : Compress data.
%   @.seed      : Random seed.
%
% Output
% estimSVD      : Estimation for chromatogram, spectra, and concentration 
%                 profiles. Output a 3-element cell {Pf_rt, Pf_wl, Pf_conc}.
%
% This script implements as follow:
% [Step 1] Unfold X_RtWlSam and perform SVD to X_WlSam_Rt. Record V(:, Fac).
%          Update X by V(:, Fac)' * X_Rt_WlSam.
% [Step 2] Unfold X_WlSamRt and perform SVD to X_SamRt_Wl. Record V(:, Fac).
%          Update X by V(:, Fac)' * X_Wl_SamRt.
% [Step 3] Unfold X_SamRtWl and perform SVD to X_RtWl_Sam. Record V(:, Fac).
%          Update X by V(:, Fac)' * X_Sam_RtWl.
%
% Copyright (C) 2023  VGeler
% Last edited:  2023.10.27 
% vgeler9602@gmail.com


end