function vn_angles = process_imu_vn_data(raw_vn_angles)
% This file is used for processing data from the Torso-dynamics Estimation System (TES) Validation Study.
    % Link to corresponding paper: https://doi.org/10.36227/techrxiv.22336843.v1
% All code files (including this one) can be found here: https://github.com/ssong47/TorsodynamicsEstimationSystem
% The data can be found here: https://ieee-dataport.org/documents/validation-study-torso-dynamics-estimation-system-tes-hands-free-physical-human-robot

% Computes torso angles (yaw, pitch, roll) from VN IMU data

vn_angles = raw_vn_angles;

% remove initial offset from IMU angles
vn_angles(:,1:3) = vn_angles(:,1:3) - vn_angles(1,1:3);

% export IMU angles as a table
vn_angles = array2table(vn_angles);

end
