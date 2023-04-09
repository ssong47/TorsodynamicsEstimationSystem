function rmse = compute_rmse(estimate, ref)
% This file is used for processing data from the Torso-dynamics Estimation System (TES) Validation Study.
    % Link to corresponding paper: https://doi.org/10.36227/techrxiv.22336843.v1
% All code files (including this one) can be found here: https://github.com/ssong47/TorsodynamicsEstimationSystem
% The data can be found here: https://ieee-dataport.org/documents/validation-study-torso-dynamics-estimation-system-tes-hands-free-physical-human-robot

% computes RMSE given reference and estimate

% find number of data points in the reference and estimate
N = min(length(estimate), length(ref));

% compute RMSE
rmse = sqrt(sum((estimate(1:N) - ref(1:N)).^2)/N);

end
