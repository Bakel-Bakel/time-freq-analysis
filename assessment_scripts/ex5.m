% Load the roll motion data
data = load('roll_motion.mat');
roll_motion = data.roll_motion; % Extract roll motion time series
Fs = 20; % Sampling frequency in Hz
N = length(roll_motion);
t = (0:N-1) / Fs; % Time vector

% Perform Empirical Mode Decomposition (EMD)
imf = emd(roll_motion); % Decomposes into Intrinsic Mode Functions (IMFs)
num_imfs = size(imf, 2); % Count the number of IMFs

% Plot original signal and IMFs
figure;
subplot(num_imfs + 1, 1, 1);
plot(t, roll_motion);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

for i = 1:num_imfs
    subplot(num_imfs + 1, 1, i + 1);
    plot(t, imf(:, i));
    title(['IMF ', num2str(i)]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
end
