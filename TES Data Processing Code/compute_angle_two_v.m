function angle = compute_angle_two_v(u, v)
% This file is used for processing data from the Torso-dynamics Estimation System (TES) Validation Study.
    % Link to corresponding paper: https://doi.org/10.36227/techrxiv.22336843.v1
% All code files (including this one) can be found here: https://github.com/ssong47/TorsodynamicsEstimationSystem
% The data can be found here: https://ieee-dataport.org/documents/validation-study-torso-dynamics-estimation-system-tes-hands-free-physical-human-robot

% Computes the angle between two vectors u and v in 3D space (x, y, z)

% solve for cos(theta) using formula for angle between two 3D vectors
cos_theta = max(min(dot(u,v)/(norm(u)*norm(v)),1),-1);

% solve for the angle theta
angle = real(acosd(cos_theta)); % in degrees

end
