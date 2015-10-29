% A = 10;           % higher means larger starting amplitude
% b = 1/5;          % higher means faster decay; time constant is 1/b
% x = [0:0.1:10];
% y = A*exp(-b*x);
% plot(x,y)         % To see the kernel

% Our stimulus pulse is a square wave of width 2a, where a = 1 ms
% We are convolving that pulse with a kernel of the form y = A * exp(-b*t)
% The kernel exponentially decays with a time constant = 1/b
% When t < a the two curves don't overlap
clf
set(0, 'DefaultAxesColorOrder', ametrine(3));

for b = [1/3, 1/5, 1/7]
    
t = [0:0.1:100];                            % time vector; 100 ms
a = 1;                                      % ms        
A = 1;
%b= 1/4;
signal = zeros(1,length(t));                % create empty vector to contain convolved signal

for i = 1:length(t)
   time = t(i);
   if time <= a
       signal(i) = 0;
   end
   if -a < time < a
       signal(i) = (-A/b) * exp(-b*(time+a));
   end
   if time >= a
       signal(i) = (A/b) * (-exp(-b*(time+a)) + exp(-b*(time-a)) );
   end
       
end

%plot(t,signal);


% Let's add multiple of these responses together
addition = signal;
for i = 1:10
   shifted_signal = zeros(1,length(t));     % initiate the shifted signal vector
   for s = 1: length(signal)                % generate the shifted signals
      shifted_signal(s+(i*20)) =  signal(s);
   end
   shifted_signal(1002:end) = [];           % truncate shifted signal
   addition = addition +  shifted_signal;
end

plot(t,addition);
hold all
end

xlabel('Time (ms)')
ylabel('Amplitude (arbitrary)')
legend('T_o = 3 ms','T_o = 5 ms', 'T_o = 7 ms')
%axis([-5 50 -0.5 7])

