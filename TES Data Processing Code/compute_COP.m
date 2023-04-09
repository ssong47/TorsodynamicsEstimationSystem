function [fss_COPx, fss_COPy] = compute_COP(raw_force_data)
% This file is used for processing data from the Torso-dynamics Estimation System (TES) Validation Study.
    % Link to corresponding paper: https://doi.org/10.36227/techrxiv.22336843.v1
% All code files (including this one) can be found here: https://github.com/ssong47/TorsodynamicsEstimationSystem
% The data can be found here: https://ieee-dataport.org/documents/validation-study-torso-dynamics-estimation-system-tes-hands-free-physical-human-robot

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
