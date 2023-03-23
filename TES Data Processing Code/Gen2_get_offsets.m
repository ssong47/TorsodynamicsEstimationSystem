function [i_start_all, i_amti_start, i_qtm_start, i_end_idx_array,...
 crop_status_array, i_crop_s_array, i_crop_e_array] = get_offsets(subject_id)
% Since data collection was not synchronized, time offsets were found 
% The found offsets will be used to align all data in the time axis
% NOTE: this function applies offsets for the Gen 2.0 FSS study. Use
% Gen1_get_offsets.m if analyzing data from the Gen 1.0 FSS study

if strcmp(subject_id, 'S1') == 1
    i_start_all =  [[1, 2136, 1, 1250]]; % Truncate overall first
    i_amti_start = [1, 1, 1, 1];
    i_qtm_start = [1, 1, 1, 1];
    i_end_idx_array = {[18670],[16770],[1],[1]};
    
    crop_status_array = [0, 0, 0, 0];
    i_crop_s_array = {[0], [0], [0], [0]};
    i_crop_e_array = {[0], [0], [0], [0]};

elseif strcmp(subject_id, 'S2') == 1 
    i_start_all =  [[1, 1530, 3560, 2010]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[1],[19450],[20630],[18900]}; %2. Find ending idx
    
    crop_status_array = [0, 0, 0, 0]; %3. Crop areas
    i_crop_s_array = {[0], [0], [0], [0]};
    i_crop_e_array = {[0], [0], [0], [0]};
    
elseif strcmp(subject_id, 'S3') == 1 
    i_start_all =  [[2900, 2436, 2398, 1647]]; % 1. Find starting idx from FSS
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[1],[23440],[21290],[20670]}; %2. Find ending idx from F
    
    crop_status_array = [0, 0, 0, 0]; %3. Crop areas
    i_crop_s_array = {[6708, 20350], [0], [0], [0]};
    i_crop_e_array = {[6974, 20440], [0], [0], [0]};
    
elseif strcmp(subject_id, 'S4') == 1 
    i_start_all =  [[1, 1, 1674, 1]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[1],[22690],[21070], [20720]}; %2. Find ending idx
    
    crop_status_array = [0, 0, 0, 0]; %3. Crop areas
    i_crop_s_array = {[1], [0], [0], [0]};
    i_crop_e_array = {[1], [0], [0], [0]};
    
    
elseif strcmp(subject_id, 'S5') == 1 
    i_start_all =  [[1, 1, 1, 1]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[19150],[22590],[1],[1]}; %2. Find ending idx
    
    crop_status_array = [1, 0, 0, 0]; %3. Crop areas
    i_crop_s_array = {[1], [0], [0], [0]};
    i_crop_e_array = {[1], [0], [0], [0]};
    
elseif strcmp(subject_id, 'S6') == 1 
    i_start_all =  [[1, 5815, 1, 1]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[1], [26040-5815], [21480], [21440]}; %2. Find ending idx
    
    crop_status_array = [0, 1, 0, 0]; %3. Crop areas
    i_crop_s_array = {[1], [13060-5815], [0], [0]};
    i_crop_e_array = {[1], [13210-5815], [0], [0]};
    
    
elseif strcmp(subject_id, 'S7') == 1 
    i_start_all =  [[1, 1, 1, 1]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[23314], [1], [1], [1]}; %2. Find ending idx
    
    crop_status_array = [0,0,1,0];
    i_crop_s_array = {[6190, 11160], [15270, 15530, 17590, 19080], [13630], [8342, 10470, 11080]};
    i_crop_e_array = {[6298, 11330], [15390, 15630, 17690, 19180], [13870], [8467, 10590, 11200]};

elseif strcmp(subject_id, 'S8') == 1 
    i_start_all =  [[2374, 1, 1, 1]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[22978], [1], [22780], [20330]}; %2. Find ending idx
    
    crop_status_array = [0,0,1,0];
    i_crop_s_array = {[1], [0], [13270, 21870], [0]};
    i_crop_e_array = {[1], [0], [13390, 22000], [0]};
    

elseif strcmp(subject_id, 'S9') == 1 
    i_start_all =  [[1, 5910, 1, 1]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[18280], [20300], [21430], [1]}; %2. Find ending idx
    
    crop_status_array = [0, 1, 0, 0]; %3. Crop areas
    i_crop_s_array = {[1], [7147], [0], [0]};
    i_crop_e_array = {[1], [7314], [0], [0]};

elseif strcmp(subject_id, 'S10') == 1 
    i_start_all =  [[1, 1, 1, 1]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[1], [1], [1], [1]}; %2. Find ending idx
    
    crop_status_array = [0,0,0,0];
    i_crop_s_array = {[1], [0], [0], [0]};
    i_crop_e_array = {[1], [0], [0], [0]};
    
end
end