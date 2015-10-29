% This scipt plots the laser beam power at the objective lens for the Oxxius 375
% nm uncaging laser.
% The power is plotted as function of displacement of a blocking probe
% The probe was gradually advanced, and power was recorded at each step.
% 
% Subplot 1 shows the raw data (inverted so that it's analogous to the
% probe being retracted.

% Subplot 2 shows an interpolation of the same data

% Subplot 3 shows the derivative of the power with respect to displacement,
% and draws a line at the 1/e^2 decay level

% The beam width is thus ~ 12 um

% Julien Azimzadeh 7/26/14

clear; clc; clf

intensity =[4.6200    1.0000    0.5714;
    4.6800    4.0000    2.2857;
    4.5500    7.0000    4.0000;
    4.4600   10.0000    5.7143;
    4.3300   13.0000    7.4286;
    4.0200   16.0000    9.1429;
    3.4300   19.0000   10.8571;
    2.3800   22.0000   12.5714;
    1.4300   25.0000   14.2857;
    0.6300   28.0000   16.0000;
    0.1900   31.0000   17.7143;
    0.0800   34.0000   19.4286;
    0.0800   37.0000   21.1429];
intensity(:,4)=flipud(intensity(:,3));
clf
subplot(3,1,1)
plot(intensity(:,4),intensity(:,1),'.')
ylabel('Power (mW')
ylabel('Power (mW)')
title('Finding beam width - 3V laser command')

subplot(3,1,2)
x2 = [1:0.5:21];
y2spline = interp1(intensity(:,4),intensity(:,1),x2,'spline');
plot(x2,y2spline,'.','color','r')
title('Interpolated Points')
ylabel('Power (mW')

d1=diff(y2spline)./diff(x2);
subplot(3,1,3)
plot(x2(1:length(x2)-1),d1,'.','color','r')
d2=diff(intensity(:,1))./diff(intensity(:,4));
hold on
plot(intensity(1:length(intensity)-1,4),d2,'.')
title('dPower/dX')
xlabel('Displacement of blocker (um)')

line([0 25],[0.0829 0.0829],'color','k')
text(16,0.15,'1/e^2')
