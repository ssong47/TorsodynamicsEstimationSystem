function [seat_theta_x_array_post, seat_theta_y_array_post] =...
                        compute_seat_angle(origin_pts, seat_pts)
% Uses mocap data (origin_pts, seat_pts) to calculate theta_x and theta_y, the FSS seat angles
% origin_pts = origin points of mocap system (markers on Qualisys L-frame)
% seat_pts = mocap markers on corners of FSS seat

%     Initialize output arrays
    N = length(origin_pts(:,1));
    seat_theta_x_array = zeros(N,1);
    seat_theta_y_array = zeros(N,1);

%     Find projection of seat vectors on reference vectors 
    for idx = 1:N
        
        % origin_pts = (ox2, ox1, oy1, oy2)
        % origin of mocap system
        ox2 = origin_pts(idx, 1:3);
        ox1 = origin_pts(idx, 4:6);
        oy1 = origin_pts(idx, 7:9);
        oy2 = origin_pts(idx, 10:12);

        % seat_pts = (seat_fl, fr, br, bl)
        % corners of FSS seat: fl = front left, br = back right, etc.
        seat_fl = seat_pts(idx, 1:3);
        seat_fr = seat_pts(idx, 4:6);
        seat_br = seat_pts(idx, 7:9);
        seat_bl = seat_pts(idx, 8:10);
        
    %     Obtain reference X,Y,Z vectors
        ox = (ox2 - ox1) / norm(ox2 - ox1); 
        oy = (oy2 - oy1) / norm((oy2 - oy1));
        oz = cross(ox, oy) / norm(cross(ox, oy));

    %     Obtain seat X,Y,Z vectors
        seat_x = (seat_fr - seat_br) / norm(seat_fr - seat_br);
        seat_y = (seat_bl - seat_br) / norm(seat_bl - seat_br);
        seat_z = cross(seat_x, seat_y) / norm(cross(seat_x, seat_y));
%         seat_center = [(seat_fl(:,1) + seat_br(:,2))/2, (seat_fl(:,2) + seat_br(:,2))/2, (seat_fr(:,3) + seat_br(:,3))/2];

        proj_zx = dot(seat_z, ox);
        proj_zy = dot(seat_z, oy);
        proj_zz = dot(seat_z, oz); 
        seat_theta_x_array(idx) = -atan2d(proj_zy, proj_zz); 
        seat_theta_y_array(idx) = -atan2d(proj_zx, proj_zz);
        
    end
    
    % save final theta arrays
    seat_theta_x_array_post = seat_theta_x_array;
    seat_theta_y_array_post = seat_theta_y_array;
    
    % remove NaNs from theta arrays
    seat_theta_x_array_post(isnan(seat_theta_x_array_post))=0; %;rmmissing(seat_theta_x_array);
    seat_theta_y_array_post(isnan(seat_theta_y_array_post))=0; %;rmmissing(seat_theta_y_array);
    
end