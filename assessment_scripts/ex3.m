% Load the time series data
data = load('roll_motion.mat');
roll_motion = data.roll_motion; % Extract roll motion time series
Fs = 20; % Sampling frequency in Hz
N = length(roll_motion);

% Apply the Blackman window
blackman_window = blackman(N);
roll_motion_windowed = roll_motion .* blackman_window; % Apply window

% Compute FFT for both original and windowed signals
Y_original = fft(roll_motion);
Y_windowed = fft(roll_motion_windowed);

% Compute the Power Spectral Density (PSD)
Pxx_original = abs(Y_original).^2 / N; 
Pxx_windowed = abs(Y_windowed).^2 / N; 

% Frequency axis (Adjusted for low-frequency marine waves)
f = (0:N/2)*(Fs/N);

% Plot time-domain signals
figure;

subplot(2,1,1); % First plot: Time domain
plot(1:N, roll_motion, 'b'); hold on;
plot(1:N, roll_motion_windowed, 'r');
xlabel('Time (s)');
ylabel('Roll Amplitude (deg)');
title('Time-Domain Roll Motion vs. Windowed Signal');
legend('Roll Motion', 'Windowed Roll Motion');
grid on;

% Plot PSD comparison
subplot(2,1,2); % Second plot: PSD
plot(f, Pxx_original(1:N/2+1), 'b'); hold on;
plot(f, Pxx_windowed(1:N/2+1), 'r');
xlabel('Frequency (Hz)');
ylabel('S(f) (deg²·s)');
title('Power Spectral Density: Original vs. Windowed');
legend('Roll Spectrum', 'Spectrum of Windowed Roll');
grid on;
xlim([0 0.5]); % Adjust x-axis to match expected range
