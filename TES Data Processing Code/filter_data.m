function filtered_data = filter_data(raw_data, f_type, f_order, f_c, f_s)
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