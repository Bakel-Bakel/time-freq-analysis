## **EXERCISE 1**

## **RESULT OF CODE**

![Screenshot from 2025-03-04 19-15-22](https://github.com/user-attachments/assets/492acd95-f805-4b08-bf46-04282ea7528f)


## **Step-by-Step Explanation of the MATLAB Code**

### **1. Load the Roll Motion Data**
```matlab
data = load('roll_motion.mat'); 
roll_motion = data.roll_motion; % Extract roll motion time series
Fs = 20; % Sampling frequency in Hz
```
- The code loads the dataset, which contains the **roll motion of a ship** recorded over time.
- The roll motion is measured in **degrees** (°), representing how much the ship tilts side to side.
- The sampling frequency (`Fs = 20 Hz`) means the data was recorded **20 times per second**.

### **2. Compute the FFT (Fast Fourier Transform)**
```matlab
N = length(roll_motion); % Find the total number of data points
Y = fft(roll_motion);    % Compute the FFT of roll motion
```
- The **FFT converts the roll motion from the time domain to the frequency domain**.
- This allows us to analyze how different wave frequencies affect the ship’s roll.

### **3. Compute the Power Spectral Density (PSD)**
```matlab
Pxx = abs(Y).^2 / N; % Compute the Power Spectral Density
```
- The **PSD tells us how much energy is present at each frequency**.
- Higher PSD values at certain frequencies indicate **stronger wave influence** at those frequencies.

### **4. Define the Frequency Axis**
```matlab
f = (0:N-1)*(Fs/N); % Create the frequency axis (0 to Fs)
```
- This step creates a **frequency scale** from **0 Hz to 20 Hz**.
- In marine wave studies, **low-frequency waves** (0-5 Hz) are usually large ocean swells, while **high-frequency waves** (10-20 Hz) are shorter, wind-driven waves.

### **5. Plot the Power Spectral Density**
```matlab
figure;
plot(f, Pxx);
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (deg²·s)');
title('Power Density Spectrum of Ship Roll Motion');
grid on;
xlim([0 20]); % Set x-axis to show up to 20 Hz
```
- The plot **shows which wave frequencies contribute the most to the ship’s rolling motion**.
- Peaks in the PSD plot indicate **dominant wave frequencies** affecting the ship.
- This information helps engineers design **better stabilizers, hull shapes, and control systems** to minimize roll effects.

# EXERCISE 2
![image](https://github.com/user-attachments/assets/1f75b45a-0bba-4572-9f29-ad1b6e09826c)

