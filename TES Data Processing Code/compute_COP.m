function [fss_COPx, fss_COPy] = compute_COP(raw_force_data)
% Compute the center of pressure (COP) components from the force data
% Force data can be from AMTI or FSS

% partition force data into individual forces and moments
fx = raw_force_data(:,1);
fy = raw_force_data(:,2);
fz = raw_force_data(:,3); 
mx = raw_force_data(:,4); 
my = raw_force_data(:,5);

% calculate the x- and y-components of COP
az0 = 0.05; % z offset of force plate top surface from the force plate origin (meters)
Mx_ = mx - fy * az0;
My_ = my + fx * az0;
Fz_ = fz;
fss_COPx = (-My_ ./ Fz_ * 1000);
fss_COPy = (Mx_ ./ Fz_ * 1000);

end