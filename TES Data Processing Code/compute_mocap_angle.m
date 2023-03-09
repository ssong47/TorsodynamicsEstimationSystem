function mocap_angles_filt = compute_mocap_angle(body_frame, world_frame)
% Compute angles of the torso (yaw, pitch, roll) from mocap data
% given the body frame (torso frame) and the world frame (mocap origin
% frame)

% initialize parameters and arrays
N = length(body_frame);
mocap_angles = zeros(N,3);
counter = 1;

    %%
    for idx = 1:N
    
    R_body_frame = body_frame(:,:,idx);
    R_world_frame = world_frame(:,:,idx);

        % compute rotation matrix in body frame and world frame
        if isnan(R_body_frame(1,1))

            if counter == 1 
                R_body_frame = zeros(3);
                R_world_frame = zeros(3);
            else
                R_body_frame = body_frame(:,:,idx-counter);
                R_world_frame = world_frame(:,:,idx-counter);
                counter = counter + 1;
            end

        else
            counter = 1;
        end

    % compute final rotation matrix 
    R = compute_R_from_basis(R_body_frame, R_world_frame);

    % compute Euler Angles
    r23 = R(2,3);
    r33 = R(3,3);
    r13 = R(1,3);
    r12 = R(1,2);
    r11 = R(1,1);

    % calculate the body angles (torso yaw, pitch, roll) from mocap data
    mocap_angles(idx,:) = [atan2d(r12, r11),...
                   -asind(r13),...
                   atan2d(r23, r33)];
    % mocap_angles(idx,:) = rotm2eul(R) * 180/pi;

    end

% filter the mocap body angles (torso yaw, pitch, roll)
mocap_angles_filt = filter_data(mocap_angles, 'low', 4, 2, 100);

end