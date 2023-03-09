function [torso_frame, seat_frame, origin_frame] = get_mocap_frames(torso_mocap, seat_mocap, origin_mocap)
% Calculates the frames of the torso, FSS seat, and mocap system origin

% Find length of data (# of samples)
N = length(torso_mocap(:,1));

% initialize arrays
torso_pos = zeros(N, 3);
torso_frame = zeros(3,3,N);
seat_pos = zeros(N, 3);
seat_frame = zeros(3,3,N);
origin_frame = zeros(3,3,N);

    for idx = 1:N
        %% Calculate torso frame
        % partition torso mocap data into 3D coordinates for top, right, and
        % left torso mocap markers
        torso_top = torso_mocap(idx, 1:3);
        torso_right = torso_mocap(idx, 4:6);
        torso_left = torso_mocap(idx, 7:9);

        % calculate torso position by taking average of the 3 torso mocap marker
        % positions
        torso_pos(idx, :) = mean(torso_top + torso_left + torso_right, 1);

        % calculate the torso frame
        torso_y =  torso_right - torso_left; 
        torso_z = (torso_left + torso_right)./2 - torso_top ;
        torso_x = cross(torso_y, torso_z);

        torso_frame(:,1,idx) = torso_x / norm(torso_x);
        torso_frame(:,2,idx) = torso_y / norm(torso_y);
        torso_frame(:,3,idx) = torso_z / norm(torso_z);


        %% Calculate FSS seat frame
        % partition FSS seat mocap data into 3D coordinates for the 4 seat mocap
        % markers
        % fl = front left corner, br = back right corner, etc.
        seat_fl = seat_mocap(idx, 1:3); 
        seat_fr = seat_mocap(idx, 4:6); 
        seat_br = seat_mocap(idx, 7:9);
        seat_bl = seat_mocap(idx, 10:12);

        % calculate seat position by taking average of the 4 seat mocap marker
        % positions
        seat_pos(idx, :) = mean(seat_fl + seat_fr + seat_bl + seat_br, 1);

        % calculate the FSS seat frame
        seat_x = seat_fl - seat_bl;
        seat_y = seat_fl - seat_fr; 
        seat_z = cross(seat_x, seat_y);

        seat_frame(:,1,idx) = seat_x / norm(seat_x);
        seat_frame(:,2,idx) = seat_y / norm(seat_y);
        seat_frame(:,3,idx) = seat_z / norm(seat_z);


        %% Calculate mocap system origin frame
        % calculate the mocap system origin frame
        % use coordinates of Qualisys L-frame markers (origin_mocap)
        origin_x = origin_mocap(idx,4:6) - origin_mocap(idx,1:3);
        origin_y = origin_mocap(idx,7:9) - origin_mocap(idx,10:12) ; 
        origin_z = cross(origin_x, origin_y);

        origin_frame(:,1,idx) = origin_x / norm(origin_x);
        origin_frame(:,2,idx) = origin_y / norm(origin_y);
        origin_frame(:,3,idx) = origin_z / norm(origin_z);


    end

end