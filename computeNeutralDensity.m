function den = computeNeutralDensity(z, r, thruster_radius)
	n0 = 1e18;
	a = 1 / (1 - 1/(sqrt(2)));
	
	R = sqrt(r.^2 + (z + thruster_radius) .* (z + thruster_radius));
	theta = atan(r ./ (z + thruster_radius));
	
	den = n0 * a * (1 - 1./sqrt(1 + (thruster_radius ./ R) .* (thruster_radius ./ R))).*cos(theta);
end