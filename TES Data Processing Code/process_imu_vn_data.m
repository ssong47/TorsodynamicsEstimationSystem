function vn_angles = process_imu_vn_data(raw_vn_angles)
% Computes torso angles (yaw, pitch, roll) from VN IMU data

vn_angles = raw_vn_angles;

% remove initial offset from IMU angles
vn_angles(:,1:3) = vn_angles(:,1:3) - vn_angles(1,1:3);

% export IMU angles as a table
vn_angles = array2table(vn_angles);

end