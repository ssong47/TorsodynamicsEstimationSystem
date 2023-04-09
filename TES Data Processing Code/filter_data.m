function filtered_data = filter_data(raw_data, f_type, f_order, f_c, f_s)
% This file is used for processing data from the Torso-dynamics Estimation System (TES) Validation Study.
    % Link to corresponding paper: https://doi.org/10.36227/techrxiv.22336843.v1
% All code files (including this one) can be found here: https://github.com/ssong47/TorsodynamicsEstimationSystem
% The data can be found here: https://ieee-dataport.org/documents/validation-study-torso-dynamics-estimation-system-tes-hands-free-physical-human-robot

% Finds Butterworth filter parameters bHP and aHP given f_order, f_c/(f_s/2), and f_type
    % f_order = order of filter, f_c = cutoff freq, f_s = sampling freq,
    % f_type = filter type
% Applies a Butterworth filter to raw_data using parameters bHP and aHP

    % find number of data points and number of columns
    [n_data, n_col] = size(raw_data);
    
    % initialize filtered_data
    filtered_data = zeros(n_data, n_col);
    
    % find Butterworth filter parameters and apply the filter
    for i_col = 1:n_col
        [bHP, aHP] = butter(f_order, f_c/(f_s/2), f_type);    
        filtered_data(:,i_col) = apply_butterworth_filter(bHP, aHP, raw_data(:,i_col));
    end
    
end
