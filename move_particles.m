% Velocity half step
particles = update_velocity(particles, qm, Ex_external, Ey_external, x, y, phi_full, dx, dy, dt / 2);
% Space full step
particles = update_location(particles, dt);
% Eliminate particles out of bounds
particles = remove_particles(particles,a_x,b_x,a_y,b_y);
% Scatter charge
rho_mesh = scatter_charge_2D(particles(:,1), particles(:,2), q_ion, w_ion, x, y, Nx, Ny);
% Compute potential
% phi_ele = -poisson_solver(rho_mesh,dx,dy,A_inv);
% phi_full = phi_ion + phi_ele;
solve_poisson;
% Velocity half step
particles = update_velocity(particles, qm, Ex_external, Ey_external, x, y, phi_full, dx, dy, dt / 2);