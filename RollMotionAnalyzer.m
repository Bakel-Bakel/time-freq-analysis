classdef RollMotionAnalyzer
    properties
        Data
        Fs % Sampling frequency
    end
    
    methods
        % Constructor: Load data and set sampling frequency
        function obj = RollMotionAnalyzer(filename, fs)
            loadedData = load(filename);
            obj.Data = loadedData.roll_motion;
            obj.Fs = fs;
        end
        function exercise1(obj)
            % Compute power spectral density using Welch's method
            window = blackman(length(obj.Data)); % Apply Blackman window
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
        end

        % Compute and plot Amplitude & Phase Spectrum (Exercise 2)
        function computeAmplitudePhase(obj)
            N = length(obj.Data);
            f = (0:N/2-1) * (obj.Fs/N);
            X = fft(obj.Data);
            amplitude_spectrum = abs(X(1:N/2));
            phase_spectrum = angle(X(1:N/2));
            
            figure;
            subplot(2,1,1);
            plot(f, amplitude_spectrum, 'b', 'LineWidth', 1.5);
            xlabel('Frequency (Hz)'); ylabel('Amplitude');
            title('Amplitude Spectrum');
            grid on;

            subplot(2,1,2);
            plot(f, phase_spectrum, 'r', 'LineWidth', 1.5);
            xlabel('Frequency (Hz)'); ylabel('Phase (radians)');
            title('Phase Spectrum');
            grid on;
        end

        % Apply Blackman window and compute PSD (Exercise 3)
        function computeBlackmanPSD(obj)
            N = length(obj.Data);
            w = blackman(N);
            data_windowed = obj.Data .* w;
            [pxx_original, f] = pwelch(obj.Data, [], [], [], obj.Fs);
            [pxx_windowed, f] = pwelch(data_windowed, [], [], [], obj.Fs);

            figure;
            plot(f, 10*log10(pxx_original), 'b', 'LineWidth', 1.5); hold on;
            plot(f, 10*log10(pxx_windowed), 'r--', 'LineWidth', 1.5);
            xlabel('Frequency (Hz)'); ylabel('Power/Frequency (dB/Hz)');
            title('PSD: Original vs. Blackman Windowed');
            legend('Original PSD', 'Blackman Windowed PSD');
            grid on;
        end

        % Apply Chebyshev Type II Lowpass Filter and compute PSD (Exercise 4)
        function computeChebyshevFilter(obj)
            fc = 0.1114;
            order = 10;
            attenuation = 40;
            [b, a] = cheby2(order, attenuation, fc/(obj.Fs/2), 'low');
            filtered_data = filtfilt(b, a, obj.Data);
            
            [pxx_original, f] = pwelch(obj.Data, [], [], [], obj.Fs);
            [pxx_filtered, f] = pwelch(filtered_data, [], [], [], obj.Fs);

            figure;
            plot(f, 10*log10(pxx_original), 'b', 'LineWidth', 1.5); hold on;
            plot(f, 10*log10(pxx_filtered), 'g--', 'LineWidth', 1.5);
            xlabel('Frequency (Hz)'); ylabel('Power/Frequency (dB/Hz)');
            title('PSD: Original vs. Chebyshev Lowpass Filtered');
            legend('Original PSD', 'Filtered PSD');
            grid on;
        end

        % Apply Hilbert-Huang Transform (Exercise 5)
        function computeHHT(obj)
            imf = emd(obj.Data);
            fs = obj.Fs;
            t = (0:length(obj.Data)-1) / fs;

            figure; hold on;
            for k = 1:size(imf, 2)
                analytic_signal = hilbert(imf(:, k));
                inst_amplitude = abs(analytic_signal);
                inst_frequency = fs/(2*pi) * diff(unwrap(angle(analytic_signal)));
                scatter(t(1:end-1), inst_frequency, 1, inst_amplitude(1:end-1));
            end
            xlabel('Time (s)'); ylabel('Frequency (Hz)');
            title('Hilbert-Huang Transform: Instantaneous Frequency');
            colorbar;
            grid on;
        end
    end
end
