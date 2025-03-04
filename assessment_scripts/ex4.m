% Load the time series data
data = load('roll_motion.mat');
roll_motion = data.roll_motion; % Extract roll motion time series
Fs = 20; % Sampling frequency in Hz
N = length(roll_motion);

% Chebyshev Type II Low-pass Filter Parameters
fc = 0.1114; % Cutoff frequency in Hz
order = 10; % Filter order
stopband_attenuation = 40; % Stopband attenuation in dB

% Design the Chebyshev Type II low-pass filter
[z, p, k] = cheby2(order, stopband_attenuation, fc/(Fs/2), 'low');
sos = zp2sos(z, p, k); % Convert to second-order sections (better stability)

% Apply the filter using zero-phase filtering
roll_motion_filtered = filtfilt(sos, 1, roll_motion);

% Compute FFT for both original and filtered signals
Y_original = fft(roll_motion);
Y_filtered = fft(roll_motion_filtered);

% Compute the Power Spectral Density (PSD)
Pxx_original = abs(Y_original).^2 / N; 
Pxx_filtered = abs(Y_filtered).^2 / N; 

% Frequency axis (Adjusted for low-frequency marine waves)
f = (0:N/2)*(Fs/N);

% Plot the time-domain signals
figure;

subplot(2,1,1); % First plot: Time domain
plot(1:N, roll_motion, 'b'); hold on;
plot(1:N, roll_motion_filtered, 'r');
xlabel('Time (s)');
ylabel('Roll Amplitude (deg)');
title('Time-Domain Roll Motion vs. Filtered Signal');
legend('Original Roll Motion', 'Filtered Roll Motion');
grid on;

% Plot PSD comparison
subplot(2,1,2); % Second plot: PSD
plot(f, Pxx_original(1:N/2+1), 'b'); hold on;
plot(f, Pxx_filtered(1:N/2+1), 'r');
xlabel('Frequency (Hz)');
ylabel('S(f) (deg²·s)');
title('Power Spectral Density: Original vs. Filtered');
legend('Original Roll Spectrum', 'Filtered Roll Spectrum');
grid on;
xlim([0 0.5]); % Adjust x-axis to match expected range
