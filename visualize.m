collided_particles = particles(particles(:,5) >= 1,:);

tickVals = linspace(0,4,5);
tickLabels = ["0","1","2","3",">=4"];
subplot(2,2,1);
% colormap('hot');
scatter(particles(:,1),particles(:,2),5,particles(:,5),'filled');
% scatter(collided_particles(:,1),collided_particles(:,2),5);
axis([a_x b_x a_y b_y]);
colorbar('Ticks',tickVals,'TickLabels',tickLabels);
clim([0,4]);
xlabel("x");
ylabel("y");
title("Particle Locations");
% colorbar.Label.String = "Number of Collisions";
colorTitleHandle = get(colorbar,'Label');
set(colorTitleHandle,'String',"Number of Collisions");

% colormap('jet');

collision_0 = sum(particles(:,5) == 0);
collision_1 = sum(particles(:,5) == 1);
collision_2 = sum(particles(:,5) == 2);
collision_3 = sum(particles(:,5) == 3);
collision_4 = sum(particles(:,5) >= 4);

coll_counts = [collision_0, collision_1, collision_2, collision_3, collision_4] / size(particles,1);

subplot(2,2,2);
% histogram(particles(:,5),"Normalization",'probability');
bar(tickLabels,coll_counts);
ylim([0,1]);
title("Probability of n Collisions")
xlabel("Number of Collisions");
ylabel("Probability");

subplot(2,2,3);
surf(x,y,phi_full);
xlabel("x");
ylabel("y");
title("$\phi$","Interpreter","Latex");

subplot(2,2,4);
surf(x,y,rho_mesh);
xlabel("x");
ylabel("y");
title("$\rho$","Interpreter","Latex");

% sgtitle("Burger's Collisional Operator, t = " + num2str(t,'%0.9f'));
% sgtitle("Takizuka's Collisional Operator, t = " + num2str(t,'%0.7f'));
% sgtitle("Collisionless, t = " + num2str(t,'%0.7f'));
sgtitle(simulation_title + ", t = " + num2str(t,'%0.7f'));
drawnow;

currFrame = getframe(gcf);
writeVideo(vidObj, currFrame);