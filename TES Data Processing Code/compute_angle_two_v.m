function angle = compute_angle_two_v(u, v)
% Computes the angle between two vectors u and v in 3D space (x, y, z)

% solve for cos(theta) using formula for angle between two 3D vectors
cos_theta = max(min(dot(u,v)/(norm(u)*norm(v)),1),-1);

% solve for the angle theta
angle = real(acosd(cos_theta)); % in degrees

end