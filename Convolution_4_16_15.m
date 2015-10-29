% Julien Azimzadeh - April 2015

% This code generates an input signal and a convolution kernel. It then
% convolves the two and plots the resulting response.
% Finally it deconvolves the input signal and the convolved response to
% obtain the convolution kernel. The deconvolution is done by least squares
% deconvolution, using the approach found here: http://eeweb.poly.edu/iselesni/lecture_notes/least_squares/LeastSquares_SPdemos/deconvolution/html/deconv_demo.html

%% Case 1: Single input pulse, no noise
clear; clf; 

% Settings:
lam = 1;                            % Regularization parameter  
beginning = 0.02;                   % Delay before step
step_duration = 0.01;               % Duration of step
theta = 1;                          % Set theta                           
Fs = 20000;                         % Sampling frequency
duration = 0.1;                     % 0.1 seconds
points = Fs * duration;             % Number of points
period = 1/Fs;                      % Period between points
t = linspace(0,duration,points);    % Time vector
endpoint = beginning + step_duration;    % End time of step

% Input Pulse:
input_pulse = zeros(1,length(t));
input_pulse(beginning*Fs : endpoint*Fs) = 1;
input_pulse = input_pulse';

% Kernel:
kernel = exp( (-(log(t./0.0005)).^2) / ((2*theta).^2));     % Define kernel

% Convolution:
%conv_response = conv(input_pulse,kernel)./sum(kernel);
conv_response = conv(input_pulse,kernel);
conv_response = conv_response(1:points);
conv_response = conv_response';

% Plots:
subplot(4,1,1)
plot(t,input_pulse)
axis([0 0.1 -0.1 1.1])
title('Input Signal')
subplot(4,1,2)
plot(t,kernel)
axis([0 0.1 -0.1 1.1])
title('Convolution Kernel')
subplot(4,1,3)
plot(t,conv_response)
axis([0 0.1 -10 80])
title('Convolved Response')

% Deconvolution
H = convmtx(input_pulse,points);
H = H(1:points,:);
g = ((H'*H + lam*eye(points)))\(H'*conv_response);      % deconvolution
subplot(4,1,4)
plot(t,g)
axis([0 0.1 -0.1 1.1])
title('Deconvolved Kernel')
xlabel('Time (sec)')

%% Case 2: Convolution with a pulse train, no noise
clf
lam = 1;                            % Regularization parameter    
theta = 1;                          % Set theta
Fs = 20000;                         % Sampling frequency
duration = 0.1;                     % 0.1 seconds
points = Fs * duration;             % Number of points
period = 1/Fs;                      % Period between points
t = linspace(0,duration,points);    % Time vector

% Generate input pulse train:
d = 0.02 : 0.003 : duration-0.02;   % Vector of times for each pulse 
input_pulse = pulstran(t,d,'rectpuls',0.002); % 4th parameter sets pulses' widths
input_pulse = input_pulse';

% Generate kernel:
kernel = exp( (-(log(t./0.0005)).^2) / ((2*theta).^2));
% kernel = (1./(t.*theta*sqrt(2*pi))) .* exp(-((log(t)-mu).^2)/(2.*mu.^2));
% kk = exp(-((log(t)-mu).^2)/(2.*mu.^2));

% Convolve input pulse train and kernel:
%conv_response = conv(input_pulse,kernel)./sum(kernel);
conv_response = conv(input_pulse,kernel);
conv_response = conv_response(1:points);
conv_response = conv_response';

% Plots:
subplot(4,1,1)
plot(t,input_pulse)
axis([0 0.1 -0.1 1.1])
title('Input Signal')
subplot(4,1,2)
plot(t,kernel)
axis([0 0.1 -0.1 1.1])
title('Convolution Kernel')
subplot(4,1,3)
plot(t,conv_response)
axis([0 0.1 -10 80])
title('Convolved Response')

% Deconvolution
H = convmtx(input_pulse,points);
H = H(1:points,:);
g = ((H'*H + lam*eye(points)))\(H'*conv_response);      % deconvolution
subplot(4,1,4)
plot(t,g)
axis([0 0.1 -0.1 1.1])
title('Deconvolved Kernel')
xlabel('Time (sec)')

%% Case 3: Single input pulse, with noise
clear; clf; 

% Settings:
lam = 100;                            % Regularization parameter  
beginning = 0.02;                   % Delay before step
step_duration = 0.01;               % Duration of step
theta = 1;                          % Set theta                           
Fs = 20000;                         % Sampling frequency
duration = 0.1;                     % 0.1 seconds
points = Fs * duration;             % Number of points
period = 1/Fs;                      % Period between points
t = linspace(0,duration,points);    % Time vector
endpoint = beginning + step_duration;    % End time of step

% Input Pulse:
input_pulse = zeros(1,length(t));
input_pulse(beginning*Fs : endpoint*Fs) = 1;
input_pulse = input_pulse';

% Kernel:
kernel = exp( (-(log(t./0.0005)).^2) / ((2*theta).^2));     % Define kernel

% Convolution:
%conv_response = conv(input_pulse,kernel)./sum(kernel);
conv_response = conv(input_pulse,kernel);
conv_response = conv_response(1:points);
randn('state', 0);                      % reset noise for reproducability
conv_response = conv_response' + 0.6*randn(points,1);


% Plots:
subplot(4,1,1)
plot(t,input_pulse)
axis([0 0.1 -0.1 1.1])
title('Input Signal')
subplot(4,1,2)
plot(t,kernel)
axis([0 0.1 -0.1 1.1])
title('Convolution Kernel')
subplot(4,1,3)
plot(t,conv_response)
axis([0 0.1 -10 80])
title('Convolved Response w/noise')

% Deconvolution
H = convmtx(input_pulse,points);
H = H(1:points,:);
g = ((H'*H + lam*eye(points)))\(H'*conv_response);      % deconvolution
subplot(4,1,4)
plot(t,g)
axis([0 0.1 -0.1 1.1])
title('Deconvolved Kernel')
xlabel('Time (sec)')

%% Case 4: Convolution with a pulse train, with noise
clf
lam = 1;                            % Regularization parameter    
theta = 1;                          % Set theta
Fs = 20000;                         % Sampling frequency
duration = 0.1;                     % 0.1 seconds
points = Fs * duration;             % Number of points
period = 1/Fs;                      % Period between points
t = linspace(0,duration,points);    % Time vector

% Generate input pulse train:
d = 0.02 : 0.003 : duration-0.02;   % Vector of times for each pulse 
input_pulse = pulstran(t,d,'rectpuls',0.002); % 4th parameter sets pulses' widths
input_pulse = input_pulse';

% Generate kernel:
kernel = exp( (-(log(t./0.0005)).^2) / ((2*theta).^2));
% kernel = (1./(t.*theta*sqrt(2*pi))) .* exp(-((log(t)-mu).^2)/(2.*mu.^2));
% kk = exp(-((log(t)-mu).^2)/(2.*mu.^2));

% Convolve input pulse train and kernel:
%conv_response = conv(input_pulse,kernel)./sum(kernel);
conv_response = conv(input_pulse,kernel);
conv_response = conv_response(1:points);
randn('state', 0);                      % reset noise for reproducability
conv_response = conv_response' + 0.6*randn(points,1);

% Plots:
subplot(4,1,1)
plot(t,input_pulse)
axis([0 0.1 -0.1 1.1])
title('Input Signal')
subplot(4,1,2)
plot(t,kernel)
axis([0 0.1 -0.1 1.1])
title('Convolution Kernel')
subplot(4,1,3)
plot(t,conv_response)
axis([0 0.1 -10 80])
title('Convolved Response')

% Deconvolution
H = convmtx(input_pulse,points);
H = H(1:points,:);
g = ((H'*H + lam*eye(points)))\(H'*conv_response);      % deconvolution
subplot(4,1,4)
plot(t,g)
axis([0 0.1 -0.1 1.1])
title('Deconvolved Kernel')
xlabel('Time (sec)')

%% Case 5: Single input pulse, new kernel
clear; clf; 

% Settings:
lam = 1;                            % Regularization parameter  
beginning = 0.02;                   % Delay before step
step_duration = 0.01;               % Duration of step
theta = 1;                          % Set theta                           
Fs = 20000;                         % Sampling frequency
duration = 0.1;                     % 0.1 seconds
points = Fs * duration;             % Number of points
period = 1/Fs;                      % Period between points
t = linspace(0,duration,points);    % Time vector
endpoint = beginning + step_duration;    % End time of step

% Input Pulse:
input_pulse = zeros(1,length(t));
input_pulse(beginning*Fs : endpoint*Fs) = 1;
input_pulse = input_pulse';

% Kernel:
%kernel = exp( (-(log(t./0.0005)).^2) / ((2*theta).^2));     % Define kernel
gau = 0.04*exp(-((t-0.02).^2)/(2*0.01^2));
kernel = (exp( (-(log(t./0.0003)).^2) / ((2*theta).^2))) - gau; 

% Convolution:
%conv_response = conv(input_pulse,kernel)./sum(kernel);
conv_response = conv(input_pulse,kernel);
conv_response = conv_response(1:points);
conv_response = conv_response';

% Plots:
subplot(4,1,1)
plot(t,input_pulse)
axis([0 0.1 -0.1 1.1])
title('Input Signal')
subplot(4,1,2)
plot(t,kernel)
axis([0 0.1 -0.2 1.1])
title('Convolution Kernel')
subplot(4,1,3)
plot(t,conv_response)
axis([0 0.1 -10 40])
title('Convolved Response')

% Deconvolution
H = convmtx(input_pulse,points);
H = H(1:points,:);
g = ((H'*H + lam*eye(points)))\(H'*conv_response);      % deconvolution
subplot(4,1,4)
plot(t,g)
axis([0 0.1 -0.1 1.1])
title('Deconvolved Kernel')
xlabel('Time (sec)')

%% Case 6: Convolution with a pulse train, with noise, with kernel that goes negative
clf
lam = 10;                            % Regularization parameter    
theta = 1;                          % Set theta
Fs = 20000;                         % Sampling frequency
duration = 0.1;                     % 0.1 seconds
points = Fs * duration;             % Number of points
period = 1/Fs;                      % Period between points
t = linspace(0,duration,points);    % Time vector

% Generate input pulse train:
d = 0.02 : 0.002 : duration-0.04;   % Vector of times for each pulse 
input_pulse = pulstran(t,d,'rectpuls',0.001); % 4th parameter sets pulses' widths
input_pulse = input_pulse';

% Generate kernel:
%kernel = exp( (-(log(t./0.0005)).^2) / ((2*theta).^2));
gau = 0.04*exp(-((t-0.02).^2)/(2*0.02^2));                  % Generate a gaussian to subtract from the kernel
kernel = (exp( (-(log(t./0.0003)).^2) / ((2*theta).^2))) - gau; 
% kernel = (1./(t.*theta*sqrt(2*pi))) .* exp(-((log(t)-mu).^2)/(2.*mu.^2));
% kk = exp(-((log(t)-mu).^2)/(2.*mu.^2));

% Convolve input pulse train and kernel:
%conv_response = conv(input_pulse,kernel)./sum(kernel);
conv_response = conv(input_pulse,kernel);
conv_response = conv_response(1:points);
randn('state', 0);                      % reset noise for reproducability
conv_response = conv_response' + 0.6*randn(points,1);

% Plots:
subplot(4,1,1)
plot(t,input_pulse)
axis([0 0.1 -0.1 1.1])
title('Input Signal')
subplot(4,1,2)
plot(t,kernel)
axis([0 0.1 -0.1 1.1])
title('Convolution Kernel')
subplot(4,1,3)
plot(t,conv_response)
axis([0 0.1 -15 35])
title('Convolved Response')

% Deconvolution
H = convmtx(input_pulse,points);
H = H(1:points,:);
g = ((H'*H + lam*eye(points)))\(H'*conv_response);      % deconvolution
subplot(4,1,4)
plot(t,g)
axis([0 0.1 -0.1 1.1])
title('Deconvolved Kernel')
xlabel('Time (sec)')

