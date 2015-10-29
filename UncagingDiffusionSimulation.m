function [cca, Duration, tstep, compartments, xmax, xstep] = UncagingDiffusionSimulation(rlaser)

% Simulation of Ca diffusion after uncaging; a Multi-Compartment Model
% 8/19/13 - Julien Azimzadeh

% Parameters of simulation 
Duration = 10e-3;           % seconds   Duration of simulation
tstep = 0.05e-3;            % seconds   Time Step
xmax = 20e-6;               % meters    Distance of simulation
xstep = 0.4e-6;             % meters    Spatial step in simulation
cmax = 1;                   % mM        Maximal concentration

% Parameters of uncaging
rlaser = rlaser;            % meters    Radius of irradiated cylidner
tstart = 0e-3;              % seconds   Onset time of laser
tend = 10e-3;               % seconds   Offset time of laser

% Parameters of diffusion
ccasource = 1e-3;           % mM        [Ca] at source when laser is active
ccainfinity = 0;            % mM        [Ca] at outer limit of simulation
dca = 800e-12;              % m2s-1     Diffusion coeff of Ca2+
dcagel = 220e-12;           % m2s-1     Diffusion coeff of cage in ligated form (Naraghi & Neher 1997, D_coeff for EGTA)
dcagef = dcagel;            % m2s-1     Diffusion coeff of cage in free form

% Calculation of Concentrations %%
compartments = round(xmax/xstep);

% Initialize cca matrix with proper # of compartments and time steps
cca = zeros(round(compartments),round(Duration/tstep));
%cca(1:round(rlaser/xstep),1) = ccasource;   % irradiated compartments start at ccasource

for t = 1:round(Duration/tstep);
    if t == 1;
        cca(1:round(rlaser/xstep),t) = ccasource;
    else
        for n = 1:compartments;
            if n == 1;
                cca(n,t) = cca(n,t-1) + ((dca * tstep) / xstep^2) * ( (2*(n-1)*(cca(n,t-1)-cca(n,t-1)) - 2*n*(cca(n,t-1)-cca(n+1,t-1)))/(2*n - 1)); 
            elseif n == compartments;
                cca(n,t) = cca(n,t-1) + ((dca * tstep) / xstep^2) * ( (2*(n-1)*(cca(n-1,t-1)-cca(n,t-1)) - 2*n*(cca(n,t-1)-ccainfinity))/(2*n - 1)); 
            else
                cca(n,t) = cca(n,t-1) + ((dca * tstep) / xstep^2) * ( (2*(n-1)*(cca(n-1,t-1)-cca(n,t-1)) - 2*n*(cca(n,t-1)-cca(n+1,t-1)))/(2*n - 1));
            end
        end
    end
end

% To Plot Heat Map
tscale = linspace(0,Duration*10^3,Duration/tstep);
dist_scale = linspace(0,xmax*10^6,xmax/xstep);
imagesc(tscale,dist_scale,cca);
title(sprintf('xstep is %d nm, tstep is %d usec',xstep*10^9,tstep*10^6));
xlabel('Time (msec)');
ylabel('Distance (um)');











