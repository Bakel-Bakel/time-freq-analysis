% Load the roll motion data
data = load('roll_motion.mat'); % Ensure the file is in the working directory
roll_motion = data.roll_motion; % Assuming the variable is named 'roll_motion'
Fs = 20; % Sampling frequency in Hz

% Compute power spectral density using Welch's method
window = blackman(length(roll_motion)); % Apply Blackman window
noverlap = round(length(window) * 0.5); % 50% overlap
nfft = 2^nextpow2(length(roll_motion)); % Optimal FFT length

[pxx, f] = pwelch(roll_motion, window, noverlap, nfft, Fs);

% Plot the Power Spectral Density (PSD)
figure;
plot(f, 10*log10(pxx), 'b', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title('Power Spectral Density of Roll Motion');
grid on;
