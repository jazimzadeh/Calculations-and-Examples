function tone_gen(tone)
% Tone Generator
% Input the frequency you want to play, in Hertz

Fs = 40000;
nSeconds = 1;    % Duration
y = sin(linspace(0,nSeconds * tone * 2 * pi, round(nSeconds * Fs)));
sound(y,Fs)



