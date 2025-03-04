% Load the time series data
data = load('roll_motion.mat');
roll_motion = data.roll_motion; % Assuming variable name inside .mat file
Fs = 20; % Sampling frequency in Hz

% Compute the FFT
N = length(roll_motion);
Y = fft(roll_motion);

% Compute the amplitude spectrum (two-sided)
Amp = abs(Y) / N; 

% Compute the phase spectrum (two-sided)
Phase = angle(Y);

% Frequency axis (Full range from 0 to Fs)
f = (0:N-1) * (Fs/N); 

% Create figure with subplots
figure;

% Plot the Amplitude Spectrum
subplot(1,2,1);
plot(f, Amp);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Amplitude Spectrum');
grid on;
xlim([0 20]); % Ensure the x-axis extends to 20 Hz

% Plot the Phase Spectrum
subplot(1,2,2);
plot(f, Phase);
xlabel('Frequency (Hz)');
ylabel('Phase (Radians)');
title('Phase Spectrum');
grid on;
xlim([0 20]); % Ensure the x-axis extends to 20 Hz
