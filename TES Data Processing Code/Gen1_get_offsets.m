function [i_start_all, i_amti_start, i_qtm_start, i_end_idx_array,...
 crop_status_array, i_crop_s_array, i_crop_e_array] = get_offsets(subject_id)
% Since data collection was not synchronized, time offsets were found 
% The found offsets will be used to align all data in the time axis
% NOTE: this function applies offsets for the Gen 1.0 FSS study. Use
% Gen2_get_offsets.m if analyzing data from the Gen 2.0 FSS study

if strcmp(subject_id, 'S1') == 1
    i_start_all =  [[3631, 3500, 3000, 4500]]; % Truncate overall first
    i_amti_start = [3000, 1,1,1];
    i_qtm_start = [2300, 1,1,1];
    i_end_idx_array = {[15570],[16590],[15080],[14750]};
    
    crop_status_array = [1, 1, 0, 0];
    i_crop_s_array = {[15100], [11520], [0], [0]};
    i_crop_e_array = {[15230], [11680], [0], [0]};

elseif strcmp(subject_id, 'S2') == 1 
    i_start_all =  [[2130, 2039, 12894, 1764]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[19160],[20040],[18970],[19190]}; %2. Find ending idx
    
    crop_status_array = [1, 0, 0, 0]; %3. Crop areas
    i_crop_s_array = {[11030], [0], [0], [0]};
    i_crop_e_array = {[11150], [0], [0], [0]};
    
elseif strcmp(subject_id, 'S3') == 1 
    i_start_all =  [[5332, 2436, 2398, 2118]]; % 1. Find starting idx from FSS
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[23910],[23440],[21800],[22400]}; %2. Find ending idx from F
    
    crop_status_array = [1, 0, 0, 0]; %3. Crop areas
    i_crop_s_array = {[6708, 20350], [0], [0], [0]};
    i_crop_e_array = {[6974, 20440], [0], [0], [0]};
    
elseif strcmp(subject_id, 'S4') == 1 
    i_start_all =  [[1, 1, 1674, 1]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[28870],[26180],[22320],[23100]}; %2. Find ending idx
    
    crop_status_array = [0, 1, 0, 0]; %3. Crop areas
    i_crop_s_array = {[1], [24760], [0], [0]};
    i_crop_e_array = {[1], [25120], [0], [0]};
    
    
elseif strcmp(subject_id, 'S5') == 1 % 5 is no good... :( 
    i_start_all =  [[800, 1, 1, 1]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[19622],[1],[1],[1]}; %2. Find ending idx
    
    crop_status_array = [0, 0, 0, 0]; %3. Crop areas
    i_crop_s_array = {[1], [0], [0], [0]};
    i_crop_e_array = {[1], [0], [0], [0]};
    
elseif strcmp(subject_id, 'S6') == 1 
    i_start_all =  [[1, 1, 880, 1]]; % 1. Find Start Idx --> Run
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[20700],[20180],[19070],[19250]}; %2. Find ending idx

    
    crop_status_array = [0, 0, 0, 0]; %3. Crop areas --> Run
    i_crop_s_array = {[3118, 3324], [0], [0], [0]};
    i_crop_e_array = {[3623, 3486], [0], [0], [0]};
    

    
elseif strcmp(subject_id, 'S7') == 1 
    i_start_all =  [[2500, 1, 1441, 1076]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[18389], [19560], [15360], [14360]}; %2. Find ending idx
    
    crop_status_array = [1,1,1,1];
    i_crop_s_array = {[6190, 11160], [15270, 15530, 17590, 19080], [13630], [8342, 10470, 11080]};
    i_crop_e_array = {[6298, 11330], [15390, 15630, 17690, 19180], [13870], [8467, 10590, 11200]};

elseif strcmp(subject_id, 'S8') == 1 
    i_start_all =  [[1, 1, 907, 1]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[1],[20200],[19525],[1]}; %2. Find ending idx
    
    crop_status_array = [1, 0, 1, 1]; %3. Crop areas
    i_crop_s_array = {[10084, 10344], [0], [10930], [15492]};
    i_crop_e_array = {[10163, 10435], [0], [11169], [15630]};
elseif strcmp(subject_id, 'S9') == 1 
    i_start_all =  [[1, 1, 814, 2700]]; % 1. Find Start Idx --> Run
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    
    crop_status_array = [1, 0, 0, 0]; %3. Crop areas --> Run
    i_crop_s_array = {[3118, 3324], [0], [0], [0]};
    i_crop_e_array = {[3623, 3486], [0], [0], [0]};
    
    i_end_idx_array = {[35330],[26434],[22721],[22812]}; %2. Find ending idx

    

elseif strcmp(subject_id, 'S00') == 1 
    i_start_all =  [[2558+1088, 1, 1, 1]]; % 1. Truncate overall
    i_amti_start = [1, 1,1,1];
    i_qtm_start = [1, 1,1,1];
    i_end_idx_array = {[6800],[1],[1],[1]}; %2. Find ending idx
    
    crop_status_array = [0, 0, 0, 0]; %3. Crop areas
    i_crop_s_array = {[0], [0], [0], [0]};
    i_crop_e_array = {[0], [0], [0], [0]};
end


end