function [mocap_angles_table, seat_angle_x, seat_angle_y] = process_mocap_data(mocap_data)
% Uses mocap data to calculate the mocap torso angles (table), FSS seat x angle,
% and FSS seat y angle
% mocap_angles_table = torso angles calculated from mocap data (yaw, pitch, roll)
% seat_angle_x = x angle of FSS seat
% seat_angle_y = y angle of FSS seat
% for all three outputs, row = sample #

% partition mocap data into FSS, mocap origin, and torso data
fss_mocap = mocap_data(:, 1:12);
origin_mocap = mocap_data(:, 13:24);
torso_mocap = mocap_data(:, 25:33);

% find frames for torso, FSS seat, and mocap origin
[torso_frame, seat_frame, origin_frame] = get_mocap_frames(torso_mocap, fss_mocap, origin_mocap);
% compute angles of the torso (yaw, pitch, roll) from mocap data
mocap_angles = compute_mocap_angle(torso_frame, origin_frame);
% remove initial offset from mocap torso angles
mocap_angles = mocap_angles - mocap_angles(1,:);

% compute the x and y angles of the FSS seat in mocap coordinate system
[seat_angle_x, seat_angle_y] = compute_seat_angle(origin_mocap, fss_mocap);

mocap_angles = mocap_angles(1:end,:);

% convert array of mocap torso angles to a table
mocap_angles_table = array2table(mocap_angles);
mocap_angles_table.Properties.VariableNames = {'yaw(deg)', 'pitch(deg)', 'roll(deg)'};

end