% Convolution practice - 4/13/15
%% Define Time Vector
samplingFrequency = 1000;       % Hz
timeStep = 1/samplingFrequency; % sec
T = 1;                          % sec
S = T * samplingFrequency;      % # samples
samples = 1:S;                  % samples
time = samples * timeStep;      % sec

%% Generate square wave
 pulseFrequency = 5;            % Hz
 squareWave = square(time*pulseFrequency*2*pi,10);

%%
delay = zeros(0.1*20000);
pulseFrequency = 1000;          % Hz
pulses = square(time*pulseFrequency*2*pi);

%% Plot square wave
figure(1);
plot(time,squareWave,'b')
title([num2str(pulseFrequency) ' Hz Square Pulse'])

%% Adjust amplitude
squareWavePos = (squareWave + 1)/2;     
close(1)
figure(1)
plot(time,squareWavePos,'r')
set(gca,'YLim',[-0.1 1.1])

%% Convolution with linear decay signal
lds = fliplr(time)/sum(time);               % generate linear decay signal
squareWaveLDS = conv(squareWavePos,lds);    % convolve
convtime = (-S:1:S) * timeStep;             % Extend time vector to match convolved signal
squareWaveLDS = [0,squareWaveLDS,0];        % Pad convolved signal wiht zeros
plot(convtime+1, squareWaveLDS);
hold on
plot(time,squareWavePos/5,'r')
set(gca,'YLim',[-0.05,.3])

%% Convolution with exponential decay signal
eds = exp(-time);
eds = eds/sum(eds);
squareWaveEDS = conv(squareWavePos,eds);
squareWaveEDS = [0,squareWaveEDS,0];
figure(4)
plot(convtime+1,squareWaveEDS)
hold on
plot(time,squareWavePos/5,'r')



