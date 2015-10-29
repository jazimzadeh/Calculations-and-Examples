%% Define time vector
samplingFrequency = 20000;       % Hz
timeStep = 1/samplingFrequency; % sec
T = 0.4;                        % sec
Tp = 0.16;                      % duration of pulse train
S = T * samplingFrequency;      % # samples
SP = Tp * samplingFrequency;    % # samples in pulse train
samples = 1:S;                  % samples
samplesP = 1:SP;                % samples in pulse train
time = samples * timeStep;      % sec
timeP = samplesP * timeStep;    % sec time vector for pulse train

%%
pulseFrequency = 500;           % Hz
pulses = square(timeP*pulseFrequency*2*pi);
pulses = (pulses + 1)/2;
delay = zeros(0.1*20000,1)';
padding = zeros(0.14*20000,1)';
pulses = [delay,pulses,padding];
%squareWave = [delay, pulses, padding];
plot(time,pulses)
set(gca,'YLim',[-0.1 3.1])

%% Make convolution kernel
r = [-22:1:22];
f = exp(-((r-0).^2)/(2*(22.^2)));

%%
squareWavef = conv(pulses,f);
squareWavef = [0,squareWavef,0];
figure(4)
plot(convtime+1,squareWavef);
hold on
plot(time,pulses,'r')