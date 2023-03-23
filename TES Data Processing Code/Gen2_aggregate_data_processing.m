% NOTE: This is for FSS Gen 2.0 ONLY! To get table for FSS Gen 1.0, use
% Gen1_aggregate_data_processing.m
% This code generates a table of averages and standard errors of the RMSE,
% max, and min for data of two subject groups
% Data: Fx, Fy, Fz, Mx, My, Mz, COPx, COPy, yaw, pitch, roll
% Subject groups: able-bodied users (ABUs) and manual wheelchair users
% (mWCUs)


%% Define directories
restoredefaultpath; clc; clear all; close all; 
% general directories
% follow this format for the general directories:
    % cd 'C:\ ....... \TES Design Validation Study'
    % addpath(genpath("C:\ ....... \TES Design Validation Study\TES Data Processing Code"));
    % addpath(genpath("C:\ ....... \TES Design Validation Study\FSS Gen 2.0 Data"));
    % addpath(genpath("C:\ ....... \TES Design Validation Study\FSS Gen 2.0 Figures"));
cd ''; % main folder
addpath(genpath("")); % folder with code
addpath(genpath("")); % folder with data
addpath(genpath("")); % folder for figures

% directory for pooled data
% follow this format for the pooled data directory:
    % file_dir = 'C:\ ....... \TES Design Validation Study\FSS Gen 1.0 Data\Processed_Data_Gen2\';
file_dir = '';

% directory for saving final table (your choice)
table_dir = '';


%% Define Subjects
subjects = {'S1','S2','S3','S4','S5','S6','S7','S8'}; % DO NOT CHANGE
trials = [1,3,3,2,1,2,1,3]; % best trials for each subject, DO NOT CHANGE
n_sub = length(subjects);
n_param = 11; % number of parameters: 3 forces, 3 moments, 2 COP, 3 torso angles


%% Pooling Data
master_pooled_data = cell(n_param, (n_sub + 1) * 2 + 1); % initialize

for i_subject = 1:n_sub % loop through all subjects
    
    % For the designated trial 
    i_trial = trials(i_subject);
    
    % Open Subject data
    data_name = strcat(file_dir,'GEN2FSS_', subjects{i_subject}, '_MASTER_DATA_TRIAL_',num2str(i_trial),'.mat');
    load(data_name);

    % Pool data
    for i_param = 1:n_param
        
        % For FSS Data: 3 forces, 3 moments, 2 COP components
        if i_param < 9
            data_est = table2array(master_data.fss); % estimated: from FSS
            data_gold = table2array(master_data.amti); % gold standard: from AMTI force plate
            data_to_insert = [data_est(:,i_param), data_gold(:,i_param)];
            
            % For pooling RMSE data
            if i_subject == 1 && i_trial == 1
                master_pooled_data{i_param, 2*(i_subject-1)+1} = data_to_insert;

                master_pooled_data{i_param, (n_sub+1)*2-1} = compute_rmse(data_to_insert(:,1), data_to_insert(:,2));
            else
                master_pooled_data{i_param, 2*(i_subject-1)+1} =...
                            [master_pooled_data{i_param, 2*(i_subject-1)+1};
                             data_to_insert];

                master_pooled_data{i_param, (n_sub+1)*2-1} = ...
                        [master_pooled_data{i_param, (n_sub+1)*2-1};...
                        compute_rmse(data_to_insert(:,1), data_to_insert(:,2))];
            end

            % For pooling max value data
            master_pooled_data{i_param, 2*(i_subject)} = [master_pooled_data{i_param, 2*(i_subject)};...
                                                          max(data_est(:,i_param))];
            master_pooled_data{i_param, 2*(n_sub+1)} = [master_pooled_data{i_param, 2*(n_sub+1)};...
                                                        max((data_est(:,i_param)))];
            master_pooled_data{i_param, 2*(n_sub+1)+1} = [master_pooled_data{i_param, 2*(n_sub+1)+1};...
                                                        min(data_est(:,i_param))];
                                                    
        % For IMU Data: torso yaw, pitch, and roll    
        else
            % For pooling RMSE data
            data_est = table2array(master_data.vn); % estimated: from VN IMU
            data_gold = table2array(master_data.qtm); % gold standard: from Qualisys motion capture
            data_to_insert = [data_est(:,i_param-8), data_gold(:,i_param-8)];

            if i_subject == 1 && i_trial == 1
                master_pooled_data{i_param, 2*(i_subject-1)+1} = data_to_insert;
                master_pooled_data{i_param, (n_sub+1)*2-1} = compute_rmse(data_to_insert(:,1), data_to_insert(:,2));
            else
                master_pooled_data{i_param, 2*(i_subject-1)+1} =...
                            [master_pooled_data{i_param, 2*(i_subject-1)+1};
                             data_to_insert];

                master_pooled_data{i_param, (n_sub+1)*2-1} = [master_pooled_data{i_param, (n_sub+1)*2-1};...
                                                              compute_rmse(data_to_insert(:,1), data_to_insert(:,2))];
            end

            % For pooling max value data
            master_pooled_data{i_param, 2*(i_subject)} = [master_pooled_data{i_param, 2*(i_subject)};...
                                                          max(data_est(:,i_param-8))];
            master_pooled_data{i_param, 2*(n_sub+1)} = [master_pooled_data{i_param, 2*(n_sub+1)};...
                                                          max((data_est(:,i_param-8)))];
            master_pooled_data{i_param, 2*(n_sub+1)+1} = [master_pooled_data{i_param, 2*(n_sub+1)+1};...
                                                          min(data_est(:,i_param-8))];
        end
    end        
end


%% Organize data into table

table_array = zeros(n_param*2, 6); % initialize


for i_sub_group = 1:2 % loop through 2 subject groups: ABUs and mWCUs
    for i_col = 1:3
        for i_param = 1:n_param
            table_data = master_pooled_data{i_param, i_col + 16};
            
            % For ABUs 
            if i_sub_group == 1
                abu_data = table_data(1:6);                
                % Computing RMSE avg and standard dev values for ABUs
                if i_col == 1
                    table_array(2*(i_param-1)+1, 3*(i_sub_group-1) + i_col) = mean(abu_data);
                    table_array(2*(i_param), 3*(i_sub_group-1) + i_col) = std(abu_data);
                elseif i_col == 2  
                    table_array(2*(i_param-1)+1, 3*(i_sub_group-1) + i_col) = max(abu_data);
                elseif i_col == 3
                    table_array(2*(i_param-1)+1, 3*(i_sub_group-1) + i_col) = min(abu_data);
                end                

            % For mWCUs
            elseif i_sub_group == 2
                mwcu_data = table_data(7:8);
                % Computing RMSE avg and standard dev values for mWCUs
                if i_col == 1
                    table_array(2*(i_param-1)+1, 3*(i_sub_group-1) + i_col) = mean(mwcu_data);
                    table_array(2*(i_param), 3*(i_sub_group-1) + i_col) = std(mwcu_data);
                elseif i_col == 2  
                    table_array(2*(i_param-1)+1, 3*(i_sub_group-1) + i_col) = max(mwcu_data);
                elseif i_col == 3
                    table_array(2*(i_param-1)+1, 3*(i_sub_group-1) + i_col) = min(mwcu_data);
                end    
            end
        end
    end
end

% generate final table of Gen 2.0 FSS data
final_table_fss_2 = array2table(table_array);
% add row labels
final_table_fss_2.Properties.RowNames = {'Fx(N) AVG','Fx(N) SE',...
                                         'Fy(N) AVG','Fy(N) SE',...
                                         'Fz(N) AVG', 'Fz(N) SE',...
                                         'Mx(Nm) AVG', 'Mx(Nm) SE',... 
                                         'My(Nm) AVG', 'My(Nm) SE',...
                                         'Mz(Nm) AVG', 'Mz(Nm) SE',...
                                         'COPx(mm) AVG', 'COPx(mm) SE',...
                                         'COPy(mm) AVG', 'COPy(mm) SE',...
                                         'Yaw(deg) AVG', 'Yaw(deg) SE',... 
                                         'Pitch(deg) AVG', 'Pitch(deg) SE',... 
                                         'Roll(deg) AVG', 'Roll(deg) SE'};
% add column labels
final_table_fss_2.Properties.VariableNames = {'[ABU] RMSE', '[ABU] MAX', '[ABU] MIN',...
                                              '[MWCU] RMSE', '[MWCU] MAX', '[MWCU] MIN'};

% export final table as an Excel spreadsheet
table_name = strcat(table_dir, 'FSS_Gen_2.0_table.xls');
writetable(final_table_fss_2, table_name);
disp(final_table_fss_2)
