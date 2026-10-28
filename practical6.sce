clc;
clear;
close;
//=========================================================
// FIR LOW-PASS FILTER USING HAMMING WINDOW
//=========================================================
// Sampling frequency
Fs = 8000;
// Duration
T = 2;
// Time vector
t = 0:1/Fs:T-1/Fs;
//=========================================================
// GENERATE SPEECH-LIKE REAL-WORLD SIGNAL
//=========================================================
// Low-frequency speech components
x1 = 0.8*sin(2*%pi*300*t);
x2 = 0.5*sin(2*%pi*700*t);
x3 = 0.3*sin(2*%pi*1200*t);
// High-frequency unwanted noise
noise = 0.5*sin(2*%pi*3500*t);
// Composite input signal
x = x1 + x2 + x3 + noise;
//=========================================================
// FIR FILTER SPECIFICATIONS
//=========================================================
// Filter order
order = 50;
// Cutoff frequency
fc = 2000;
// Normalized cutoff frequency
Wc = fc/Fs;
//=========================================================
// DESIGN FIR FILTER USING HAMMING WINDOW
//=========================================================
[h, hm, fr] = wfir("lp", order, [Wc 0], "hm", [0 0]);
// Display filter information
disp("======================================");
disp("FIR LOW-PASS FILTER");
disp("======================================");
disp("Filter Type : FIR Low-Pass");
disp("Window Type : Hamming");
disp("Filter Order : ");
disp(order);
disp("Sampling Frequency (Hz) : ");
disp(Fs);
disp("Cut-off Frequency (Hz) : ");
disp(fc);
disp("FIR Filter Coefficients :");
disp(h);
//=========================================================
// APPLY FIR FILTER
//=========================================================
y = filter(h, 1, x);
//=========================================================
// TIME DOMAIN PLOT
//=========================================================
// Display only first 0.1 second
M = round(0.1*Fs);
figure(1);
subplot(2,1,1);
plot(t(1:M), x(1:M));
title("Original Input Signal");
xlabel("Time (s)");
ylabel("Amplitude");
subplot(2,1,2);
plot(t(1:M), y(1:M));
title("Filtered Output Signal");
xlabel("Time (s)");
ylabel("Amplitude");
//=========================================================
// FREQUENCY DOMAIN ANALYSIS
//=========================================================
N = length(x);
X = fft(x);
Y = fft(y);
f = (0:N-1)*(Fs/N);
//=========================================================
// MAGNITUDE SPECTRUM
//=========================================================
figure(2);
subplot(2,1,1);
plot(f(1:floor(N/2)), abs(X(1:floor(N/2))));
title("Magnitude Spectrum of Input Signal");
xlabel("Frequency (Hz)");
ylabel("Magnitude");
subplot(2,1,2);
plot(f(1:floor(N/2)), abs(Y(1:floor(N/2))));
title("Magnitude Spectrum of Filtered Signal");
xlabel("Frequency (Hz)");
ylabel("Magnitude");
//=========================================================
// FIR FILTER FREQUENCY RESPONSE
//=========================================================
figure(3);
plot(fr*Fs, abs(hm));
title("Frequency Response of FIR Hamming Window Filter");
xlabel("Frequency (Hz)");
ylabel("Magnitude");
//=========================================================
// COMPLETION MESSAGE
//=========================================================
disp(" ");
disp("Filtering completed successfully.");