% Load the time series data
data = load('roll_motion.mat');
roll_motion = data.roll_motion; % Assuming variable name inside .mat file
Fs = 20; % Sampling frequency in Hz

% Compute the FFT
N = length(roll_motion);
Y = fft(roll_motion);

% Compute the two-sided power spectral density (PSD)
Pxx = abs(Y).^2 / N;

% Frequency axis (Full range from 0 to Fs)
f = (0:N-1)*(Fs/N); 

% Plot the Power Spectral Density on a linear scale
figure;
plot(f, Pxx);
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (deg²·s)');
title('Power Density Spectrum');
grid on;
xlim([0 20]); % Ensure the x-axis extends to 20 Hz
