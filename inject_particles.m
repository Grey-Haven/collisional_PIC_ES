new_particles = zeros(injection_rate,5);
% starting x location is 0
new_particles(:,2) = thruster_radius*(-1+2*rand(injection_rate,1));
new_particles(:,3) = 29000;
new_particles(:,4) = -2000 + rand(injection_rate,1)*4000;
% starting collision number is 0

particles = [particles;new_particles];