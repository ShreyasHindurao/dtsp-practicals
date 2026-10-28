clc;
clear;
close;

// Input discrete-time signal
x = [1 2 3 4 3 2 1 0];

// Length of signal
N = length(x);

// Time index
n = 0:N-1;

// ---------------- DFT ----------------

// Initialize DFT
X_DFT = zeros(1, N);

// Calculate DFT using definition
for k = 0:N-1
for n = 0:N-1
X_DFT(k+1) = X_DFT(k+1) + ...
x(n+1) * exp(-%i * 2 * %pi * k * n / N);
end
end
// ---------------- FFT ----------------

// Calculate FFT using Scilab built-in function
X_FFT = fft(x, -1);

// Frequency index
k = 0:N-1;

// Magnitude spectrum
Mag_DFT = abs(X_DFT);
Mag_FFT = abs(X_FFT);

// Phase spectrum
Phase_DFT = atan(imag(X_DFT), real(X_DFT));
Phase_FFT = atan(imag(X_FFT), real(X_FFT));

// Convert phase from radians to degrees
Phase_DFT = Phase_DFT * 180 / %pi;
Phase_FFT = Phase_FFT * 180 / %pi;

// ---------------- Display Results ----------------

disp(&quot;Original Signal:&quot;);
disp(x);

disp(&quot;DFT:&quot;);
disp(X_DFT);
disp(&quot;FFT:&quot;);
disp(X_FFT);

// ---------------- Plot ----------------

// Original discrete-time signal
scf(1);
subplot(3,1,1);
plot2d3(n, x);
xlabel(&quot;n&quot;);
ylabel(&quot;Amplitude&quot;);
title(&quot;Discrete-Time Signal&quot;);

// Magnitude spectrum
subplot(3,1,2);
plot2d3(k, Mag_DFT);
xlabel(&quot;Frequency Index k&quot;);
ylabel(&quot;|X(k)|&quot;);
title(&quot;Magnitude Spectrum using DFT&quot;);

// Phase spectrum
subplot(3,1,3);
plot2d3(k, Phase_DFT);
xlabel(&quot;Frequency Index k&quot;);
ylabel(&quot;Phase (degrees)&quot;);
title(&quot;Phase Spectrum using DFT&quot;);
// ---------------- FFT Spectra ----------------

scf(2);

subplot(2,1,1);
plot2d3(k, Mag_FFT);
xlabel(&quot;Frequency Index k&quot;);
ylabel(&quot;|X(k)|&quot;);
title(&quot;Magnitude Spectrum using FFT&quot;);

subplot(2,1,2);
plot2d3(k, Phase_FFT);
xlabel(&quot;Frequency Index k&quot;);
ylabel(&quot;Phase (degrees)&quot;);
title(&quot;Phase Spectrum using FFT&quot;);