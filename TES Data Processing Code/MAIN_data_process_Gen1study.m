% NOTE: This is for FSS Gen 1.0 ONLY! To get master data and plots for 
% FSS Gen 2.0, use MAIN_data_process_Gen2study.m
    % This code processes the FSS, QTM (Qualisys motion capture), VN IMU, and
    % AMTI force plate data for the Gen 1.0 FSS design validation study
% FSS load cells are used to calculate 3 forces, 3 moments, and 2 COP coordinates
    % FSS data are compared to the gold standard, AMTI force plate
% VN IMU signals are used to calculate torso angles (yaw, pitch, roll)
    % IMU data are compared to the gold standard, Qualisys motion capture
    
% This code should be run for one subject and one trial at a time. Follow
% the instructions in the comments to change the subject and trial number


%% NOTE: Need to change all directories here
restoredefaultpath; clc; clear all; close all; 
% general directories
% follow this format for the general directories:
    % cd 'C:\ ....... \TES Design Validation Study'
    % addpath(genpath("C:\ ....... \TES Design Validation Study\TES Data Processing Code"));
    % addpath(genpath("C:\ ....... \TES Design Validation Study\FSS Gen 1.0 Data"));
    % addpath(genpath("C:\ ....... \TES Design Validation Study\FSS Gen 1.0 Figures"));
cd ''; % main folder
addpath(genpath("")); % folder with code
addpath(genpath("")); % folder with data
addpath(genpath("")); % folder for figures

% directory for saving new data
% follow this format for data file directory:
    % save_dir = 'C:\ ....... \TES Design Validation Study\FSS Gen 1.0 Data\Processed_Data_Gen1\';
save_dir = '';


%% Define subjects (NOTE: need to change "subjects" here and "i_trial" later on)
subjects = {'S8'}; % choose ONE subject's data to process, use a capitalized "S"
raw_plot_status = 0; % 1 - PLOT RAW DATA, 0 - NO PLOT RAW DATA
plot_status = 1; % 1 - PLOT PROCESSED DATA, 0 - NO PLOT PROCESSED DATA
save_status = 1; % 1 - SAVE, 0 - NO SAVE


%% Define offsets
% Note: Since data collection was not synchonized, time offsets needed to be found. 
% get offsets for aligning all data in the time axis
[i_start_all, i_amti_start, i_qtm_start, i_end_idx_array,...
 crop_status_array, i_crop_s_array, i_crop_e_array] = Gen1_get_offsets(subjects{1}); 


%% Insert mWCU's AMTI data into QTM data
rmse = zeros(4,11); % initialize
lw = 1; 

for i_subject = subjects % loop through all subjects
    
    for i_trial = 3 % Choose the proper trial for each subject. See below

% Note: this applies only for the Gen 1.0 FSS study        
% SubjectID     Proper trial #
% s1            4
% s2            4
% s3            4
% s4            1   
% s5            1
% s6            4
% s7            3
% s8            3
% s9            3

        
        disp(i_trial)
        crop_status = crop_status_array(i_trial);
        i_crop_s = i_crop_s_array{i_trial};
        i_crop_e = i_crop_e_array{i_trial};
        
        
        %% Load FSS data file
        fss_filename = strcat(i_subject{1}, '_TRIAL', num2str(i_trial), '_FSS.txt');
        raw_fss_data = readmatrix(fss_filename);
        fss_lc_data_ = raw_fss_data(:, 2:7); % FSS load cell data

        vn_data_table = process_imu_vn_data(raw_fss_data(:,18:20));
        vn_data__ = table2array(vn_data_table);
        vn_data_ = vn_data__(1:end,:); % processed VN IMU data
        
        
        %% Load AMTI data file
        amti_filename = strcat(i_subject{1}, '_TRIAL', num2str(i_trial), '_AMTI.txt');       
        raw_amti_data = readmatrix(amti_filename);
        amti_data__ = rmmissing(raw_amti_data); % AMTI force plate data
        % compute COP from the AMTI data
        [cop_x, cop_y] = compute_COP(amti_data__);
        amti_data_ = [amti_data__, cop_x, cop_y]; % AMTI + COP data
        idx_master_amti = [1:length(amti_data_)]';

        
        %% Load QTM (Qualisys motion capture) data file
        qtm_filename = strcat(i_subject{1}, '_TRIAL', num2str(i_trial), '_QTM.mat');
        qtm_data_all = load(qtm_filename);
        
        qtm_name = genvarname(strcat(i_subject{1}, '_TRIAL', num2str(i_trial), '_QTM'));

        qtm_raw_data_ = qtm_data_all.(qtm_name).Trajectories.Labeled.Data; % raw Qualisys mocap data
        qtm_raw_data = [];
        idx_master_qtm = [1:length(qtm_raw_data_)]';

        
        for idx = 1:length(qtm_raw_data_) % NEED TO TAKE CARE OF HIDDEN MARKERS
            if ~isnan(qtm_raw_data_(11,1,idx))
                qtm_raw_data(:,:,idx) = qtm_raw_data_(:,:,idx);
            else
                if idx ~= 1
                    qtm_raw_data(:,:,idx) = qtm_raw_data(:,:,idx-1);
                elseif idx == 1
                    qtm_raw_data(:,:,idx) = zeros(11,4);
                end
            end
        end
        
        % partition mocap marker data into FSS seat markers (x4), mocap origin
        % markers (x4), and torso markers (x3) 
        fss_mocap = qtm_raw_data(1:4,:, :);
        origin_mocap = qtm_raw_data(5:8,:, :);
        torso_mocap = qtm_raw_data(9:11,:, :);

        raw_mocap_data = zeros(length(fss_mocap), 33); % initialize

        % rearrange raw mocap data: rows = time steps, 
        % columns =  3 coordinates (x,y,z) of each mocap marker (4 FSS markers, 
        % 4 origin markers, 3 torso markers)
        for idx = 1:length(fss_mocap) % loop through all time points
            
            raw_mocap_data(idx,:) = [fss_mocap(1, 1, idx), fss_mocap(1, 2, idx), fss_mocap(1, 3, idx),...
                        fss_mocap(2, 1, idx), fss_mocap(2, 2, idx), fss_mocap(2, 3, idx),...
                        fss_mocap(3, 1, idx), fss_mocap(3, 2, idx), fss_mocap(3, 3, idx),...
                        fss_mocap(4, 1, idx), fss_mocap(4, 2, idx), fss_mocap(4, 3, idx),...
                        origin_mocap(1,1,idx), origin_mocap(1,2,idx), origin_mocap(1,3,idx),...
                        origin_mocap(2,1,idx), origin_mocap(2,2,idx), origin_mocap(2,3,idx),...
                        origin_mocap(3,1,idx), origin_mocap(3,2,idx), origin_mocap(3,3,idx),...
                        origin_mocap(4,1,idx), origin_mocap(4,2,idx), origin_mocap(4,3,idx),...
                        torso_mocap(1,1,idx), torso_mocap(1,2,idx), torso_mocap(1,3,idx),...
                        torso_mocap(2,1,idx), torso_mocap(2,2,idx), torso_mocap(2,3,idx),...
                        torso_mocap(3,1,idx), torso_mocap(3,2,idx), torso_mocap(3,3,idx)];
        end
        
        % process the mocap marker data to get torso angles (yaw, pitch,
        % roll)
        % Note: motion capture is gold standard for torso angles
        [processed_mocap_data, seat_angle_x, seat_angle_y] = process_mocap_data(raw_mocap_data);
        mocap_angles__ = table2array(processed_mocap_data);
        mocap_angles_ = mocap_angles__;
        
        
        %% Calibration matrix
        m = fss_lc_data_';
        load('jacobian_matrix.mat')
        W_pred = (- E) * m;
        W_pred_t_ = W_pred';
        
        
        %% Start at roughly same index 
        % use offsets that were found earlier with Gen1_get_offsets.m to
        % align all data in the time axis
        if i_end_idx_array{i_trial} == 1
            i_end_idx = length(W_pred_t_) - i_start_all(i_trial);
        else
            i_end_idx = i_end_idx_array{i_trial};
        end
        
        amti_data = amti_data_(i_amti_start(i_trial) + i_start_all(i_trial):end,:);
        mocap_angles = mocap_angles_(i_qtm_start(i_trial) + i_start_all(i_trial):end,:) - ...
                       mocap_angles_(i_qtm_start(i_trial) + i_start_all(i_trial),:);

        fss_lc_data = fss_lc_data_(i_start_all(i_trial):i_start_all(i_trial) + i_end_idx, :);
        W_pred_t = W_pred_t_(i_start_all(i_trial):i_start_all(i_trial)+i_end_idx,:);
        vn_data = vn_data_(i_start_all(i_trial):i_start_all(i_trial)+i_end_idx,:) - ...
                  vn_data_(i_start_all(i_trial),:);
        
              
        %% Plot raw data
        if raw_plot_status == 1
            fss_labels = {'F_x (N)', 'F_y (N)', 'F_z (N)', 'M_x (Nm)', 'M_y (Nm)', 'M_z (Nm)'};
            figure()
            sgtitle('Raw FSS Data for Gen 1.0')
            for i_subplot = 1:6
                subplot(3,2,i_subplot)
                yyaxis left
                plot(amti_data(:,i_subplot))
                yyaxis right
                plot(W_pred_t(:,i_subplot))
                legend('AMTI', 'FSS Gen 1.0')
                xlim([0 25000]);
                ylabel(fss_labels{i_subplot});
            end

            imu_labels = {'Yaw (deg)', 'Pitch (deg)', 'Roll (deg)'};
            figure()
            sgtitle('Raw IMU Data for Gen 1.0')
            for i_subplot = 1:3
                subplot(3,1,i_subplot)
                yyaxis left
                plot(mocap_angles(:,i_subplot))
                yyaxis right
                plot(vn_data(:,i_subplot))
                legend('MoCap', 'VN-100 IMU')
                xlim([0 25000]);
                ylabel(imu_labels{i_subplot});
            end
        end

              
        %% Find delay of AMTI data
        idx_delay_amti_array = [0,0,0,0];
        idx_c = 1;
        for idx = [1,2,4,5]
            idx_delay_amti_array(idx_c) = finddelay(W_pred_t(:,idx), amti_data(:,idx));
            idx_c = idx_c + 1;
        end
        
        
        idx_delay_amti = round(mean(idx_delay_amti_array));
        if idx_delay_amti == 0
            idx_delay_amti  = 1;
        end
        W_pred_final = W_pred_t;
        amti_data_final_ = amti_data(idx_delay_amti:end, :);
        
        
        %% Find delay of QTM data
        idx_delay_qtm_array = [0,0,0];
        for idx = 1:3
            idx_delay_qtm_array(idx) = finddelay(vn_data(:,idx), mocap_angles(:,idx));
        end
        
        idx_delay_qtm = round(mean(idx_delay_qtm_array(1)));
        vn_data_final = vn_data;
        
        if any(idx_delay_qtm > 0) 
            mocap_angles_final = mocap_angles(idx_delay_qtm:end, :);
        else
            mocap_angles_final = padarray(mocap_angles, abs(idx_delay_qtm), 0,'pre');
        end
        

        %% Remove Y-offset from FSS, QTM, and VM IMU data
        fss_final_ = W_pred_final - W_pred_final(1,:) + amti_data_final_(1,1:6); 
        qtm_final_ = mocap_angles_final - mocap_angles_final(1,:);
        vn_final_ = vn_data_final - vn_data_final(1,:); 
        
        
        %% Match lengths of data arrays (all data needs to have same number of samples)
        N_data = min([length(fss_final_), length(qtm_final_), length(vn_final_), length(amti_data_final_)]);
        fss_final = fss_final_(1:N_data,:);
        amti_final = amti_data_final_(1:N_data,:);
        fss_lc_final = fss_lc_data(1:N_data, :);
        qtm_final = qtm_final_(1:N_data,:);
        vn_final = vn_final_(1:N_data,:);
        
                
        %% Crop data if necessary
        if crop_status == 1 
            disp('cropped...')
            for i_crop = 1:length(i_crop_s)
                idx_crop_s = i_crop_s(i_crop);
                idx_crop_e = i_crop_e(i_crop);
                amti_final(idx_crop_s:idx_crop_e, :) = [];
                fss_lc_final(idx_crop_s:idx_crop_e, :) = [];
                fss_final(idx_crop_s:idx_crop_e,:) = [];
                vn_final(idx_crop_s:idx_crop_e,:) = [];
                qtm_final(idx_crop_s:idx_crop_e,:) = [];
            end
        end
        
        
        %% Compute COP using FSS data
        [fss_cop_x, fss_cop_y] = compute_COP(fss_final); 
        fss_final = [fss_final fss_cop_x fss_cop_y];
        
        
        %% Plot FSS data
        if plot_status == 1
            w_label = {'F_x (N)','F_y (N)', 'F_z (N)', 'M_x (Nm)', 'M_y (Nm)', 'M_z (Nm)', 'COP_x (mm)', 'COP_y(mm)'};
            figure()
            sgtitle('Processed FSS Data for Gen 1.0')
            for i_subplot = 1:8
                subplot(4,2,i_subplot)
                plot(amti_final(:, i_subplot), 'k','Linewidth', lw)
                hold on 
                plot(fss_final(:, i_subplot), '-.','Linewidth', lw)
                legend('AMTI', 'FSS Gen 1.0')
                ylabel(w_label{i_subplot});
                xlabel('data indices');
            end

            
            %% Plot IMU data
            ylabel_angles = {'Yaw (deg)', 'Pitch (deg)', 'Roll (deg)'};
            figure()
            sgtitle('Processed IMU Data for Gen 1.0')
            for i_subplot = 1:3
                subplot(3,1,i_subplot)
                plot(qtm_final(:,i_subplot), 'k','Linewidth', lw)
                hold on
                plot(vn_final(:,i_subplot), '-.','Linewidth', lw)
                legend('mocap', 'VN-100 IMU')
                ylabel(ylabel_angles{i_subplot})
                xlabel('data indices');
            end
        end
        
        
        %% Compute RMSE
        for idx = 1:8
            rmse(i_trial,idx) = compute_rmse(fss_final(:, idx), amti_final(:, idx));
        end

        for idx = 1:3
            rmse(i_trial,idx + 8) = compute_rmse(vn_final(:, idx), qtm_final(:, idx));
        end

        
        %% Store data in master array
        amti_table = array2table(amti_final);
        amti_table.Properties.VariableNames = {'Fx(N)', 'Fy(N)', 'Fz(N)',...
                                               'Mx(Nm)', 'My(Nm)', 'Mz(Nm)',...
                                               'COPx(mm)', 'COPy(mm)'};

        fss_table = array2table(fss_final);
        fss_table.Properties.VariableNames = {'Fx(N)', 'Fy(N)', 'Fz(N)',...
                                        'Mx(Nm)', 'My(Nm)', 'Mz(Nm)',...
                                        'COPx(mm)', 'COPy(mm)'};
        qtm_table = array2table(qtm_final);
        qtm_table.Properties.VariableNames = {'Yaw(deg)', 'Pitch(deg)', 'Roll(deg)'};
        
        vn_table = array2table(vn_final);
        vn_table.Properties.VariableNames = {'Yaw(deg)', 'Pitch(deg)', 'Roll(deg)'};
        
        master_data = struct;
        master_data.amti = amti_table;
        master_data.fss = fss_table;
        master_data.qtm = qtm_table;
        master_data.vn = vn_table;
        
        
        %% Save new data
        if save_status
            
            save_name = strcat(save_dir, 'GEN1FSS_', i_subject{1}, '_MASTER_DATA_TRIAL_', num2str(i_trial), '.mat');
            save(save_name, 'master_data');

        end
               
    end
end

disp(rmse) % Most important metric columns: 3, 4, 5, 7, 8, 9 
