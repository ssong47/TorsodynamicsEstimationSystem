function R = compute_R_from_basis(body_frame, world_frame)
% This file is used for processing data from the Torso-dynamics Estimation System (TES) Validation Study.
    % Link to corresponding paper: https://doi.org/10.36227/techrxiv.22336843.v1
% All code files (including this one) can be found here: https://github.com/ssong47/TorsodynamicsEstimationSystem
% The data can be found here: https://ieee-dataport.org/documents/validation-study-torso-dynamics-estimation-system-tes-hands-free-physical-human-robot

% Compute final rotation matrix given the rotation matrix in body frame
% (torso frame) and world frame (mocap origin frame)

% partition rotation matrix in body frame into x, y, z
b_x = body_frame(:,1);
b_y = body_frame(:,2);
b_z = body_frame(:,3);

% partition rotation matrix in world frame into x, y, z
w_x = world_frame(:,1);
w_y = world_frame(:,2);
w_z = world_frame(:,3);

% compute the final rotation matrix
R = [cosd(compute_angle_two_v(b_x, w_x)), cosd(compute_angle_two_v(b_x, w_y)), cosd(compute_angle_two_v(b_x, w_z));
     cosd(compute_angle_two_v(b_y, w_x)), cosd(compute_angle_two_v(b_y, w_y)), cosd(compute_angle_two_v(b_y, w_z));
     cosd(compute_angle_two_v(b_z, w_x)), cosd(compute_angle_two_v(b_z, w_y)), cosd(compute_angle_two_v(b_z, w_z))];

end
