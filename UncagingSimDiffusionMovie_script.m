% Julien Azimzadeh - 8/19/13

% This script runs the UncagingDiffusionSimulation function for 3 different
% laser radii.
% The results are plotted into subplots, which are stored in a video file

[cca2_5, Duration, tstep, compartments, xmax, xstep] = UncagingDiffusionSimulation(2.5e-6);
[cca2,   Duration, tstep, compartments, xmax, xstep] = UncagingDiffusionSimulation(2e-6);
[cca1_5, Duration, tstep, compartments, xmax, xstep] = UncagingDiffusionSimulation(1.5e-6);

% Create avi object
nFrames = Duration/tstep;
vidObj = VideoWriter('TripleUncaging.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 24;
open(vidObj);

xscale = linspace(0, xmax*10^6,round(xmax/xstep));     % Scale the x axis to show um instead of compartment #
for i = 1:(Duration/tstep)
    subplot(1,3,1)
    plot(xscale,cca2_5(:,i))
    axis([0 xmax*10^6 0 1e-3])
    title('rlaser = 2.5')
    xlabel('Distance (um)')
    
    subplot(1,3,2)
    plot(xscale,cca2(:,i))
    axis([0 xmax*10^6 0 1e-3])
    title('rlaser = 2.0')
    xlabel('Distance (um)')
    
    subplot(1,3,3)
    plot(xscale,cca1_5(:,i))
    axis([0 xmax*10^6 0 1e-3])
    title('rlaser = 1.5')
    xlabel('Distance (um)')
    writeVideo(vidObj, getframe(gcf));  % take the current frame (with all 3 subplots) as one video frame
    %F(i) = getframe;   
end
close(gcf)

close(vidObj);

%movie(F,1,5);