clear;
close all;

plot_at = 5;
    
figure;
x0=200;
y0=100;
width = 1200;
height = 1200;
set(gcf,'position',[x0,y0,width,height]);

% simulation_type = "takizuka";
% simulation_title = "Takizuka Collisions";

% simulation_type = "burger";
% simulation_title = "Burger Collisions";

% simulation_type = "brieda";
% simulation_title = "Brieda Collisions";

simulation_type = "collisionless";
simulation_title = "Collisionless";

vidName = "results/ES_expanding_beam_" + simulation_type + ".mp4";
vidObj = VideoWriter(vidName, 'MPEG-4');
vidObj.FrameRate = 60;
open(vidObj);

q_elec = -1.602e-19;
q_ion = -q_elec;
m_XE = 2.18e-25;	% Xenon mass, 131.3 AMU

eps_0 = 8.8541878e-17; % Vacuum Permittivity (F/m)

neut_vth = sqrt(2*1.38e-23/m_XE);

thruster_radius = .15;

injection_rate = 25; % Inject 25 particles per timestep.
N_p = 0;
T_final = .001;

N_ions = 128*128*10;
N_electrons = N_ions/8;

n_bar_ions = N_ions;
n_bar_eles = N_electrons;

w_ele = n_bar_eles / N_electrons;
w_ion = n_bar_ions / N_ions;

qm = q_ion/m_XE;

% 2 indices for location, 2 for velocity, 1 for number of collisions
% All masses and charges are identical
particles = zeros(0,5);

N = 32;
a_x = 0;
b_x = 2;
a_y = -1;
b_y = 1;

x = linspace(a_x,b_x,N);
y = linspace(a_y,b_y,N);

dx = x(2) - x(1);
dy = y(2) - y(1);

dt = 1e-7; % From Brieda's site

N_steps = ceil(T_final / dt);

Nx = N;
Ny = N;

Ex_external = zeros(Ny,Nx);
Ey_external = zeros(Ny,Nx);

E_smooth = @(x_arg) exp(-(x_arg/(4*thruster_radius)).^2);

E0 = 50;

disp(simulation_title);

for i = 1:Nx
    for j = 1:Ny
        % if (x(i) < 4*thruster_radius)
		theta = 5*(pi/180);
		Ex = -sin(theta)*E0 * E_smooth(x(i));
		Ey = cos(theta)*E0 * E_smooth(x(i));
        if (y(j) < 0)
            Ey = -Ey;
        end
        Ex_external(j,i) = Ex;
        Ey_external(j,i) = Ey;
        % end
    end
end

% No particles, so fields are zero initially (other than external from
% thruster)
phi_full = zeros(Ny,Nx);

t = 0;
t_hist = zeros(N_steps,1);

tic

for i = 1:N_steps
    % Inject Particles
    inject_particles;

    % Collide Particles
    % collide_particles
    % collide_takizuka;

    % Move Particles
    move_particles;
    
    t = t+dt;

    if (mod(i,plot_at) == 0)
        visualize;
    end
    
    t_hist(i) = t;
end

toc

close(vidObj);

figure;
tickVals = linspace(0,4,5);
tickLabels = ["0","1","2","3",">=4"];
% colormap('hot');
scatter(particles(:,1),particles(:,2),5,particles(:,5),'filled');
% scatter(particles(:,1),particles(:,2),5,zeros(length(particles(:,5)),1),'filled');
axis([a_x b_x a_y b_y]);
% colorbar('Ticks',tickVals,'TickLabels',tickLabels);
clim([0,4]);
xlabel("x");
ylabel("y");
title(simulation_title + ", Particle Locations");
% colorTitleHandle = get(colorbar,'Label');
% set(colorTitleHandle,'String',"Number of Collisions");

saveas(gcf,"results/ES_expanding_beam_" + simulation_type + '.jpg');