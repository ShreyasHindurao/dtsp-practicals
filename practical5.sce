clc;
clear;
close;
//=========================================================
// DESIGN OF IIR BUTTERWORTH LOW-PASS FILTER
//=========================================================
// Sampling frequency
Fs = 1000;
// Number of samples
N = 1000;
// Time vector
t = (0:N-1)/Fs;
//=========================================================
// GENERATE INPUT SIGNAL
//=========================================================
// Low-frequency component = 50 Hz
f1 = 50;
x_low = sin(2*%pi*f1*t);
// High-frequency component = 250 Hz
f2 = 250;
x_high = 0.7*sin(2*%pi*f2*t);
// Composite input signal
x = x_low + x_high;
//=========================================================
// IIR FILTER DESIGN
//=========================================================
// Filter order
order = 4;
// Cut-off frequency
fc = 100;
// Normalized frequency
// Scilab iir() uses 0 &lt; frq &lt; 0.5
Wn = fc/Fs;
// Design Butterworth Low-Pass IIR filter
H = iir(order, &quot;lp&quot;, &quot;butt&quot;, Wn, [0 0]);
// Display transfer function
disp(&quot;======================================&quot;);
disp(&quot;IIR BUTTERWORTH LOW-PASS FILTER&quot;);
disp(&quot;======================================&quot;);
disp(&quot;Filter Transfer Function:&quot;);
disp(H);
//=========================================================
// CONVERT FILTER INTO B AND A COEFFICIENTS
//=========================================================
// q is the delay operator
q = poly(0, &quot;q&quot;);
// Convert H(z) into H(q) where q = z^(-1)
Hq = horner(H, 1/q);
// Obtain numerator and denominator
num_poly = Hq.num;
den_poly = Hq.den;
// Obtain coefficients
b = coeff(num_poly);
a = coeff(den_poly);
// Normalize coefficients
b = b/a(1);
a = a/a(1);
// Display coefficients
disp(&quot; &quot;);
disp(&quot;Numerator coefficients B:&quot;);
disp(b);
disp(&quot;Denominator coefficients A:&quot;);
disp(a);
//=========================================================
// FILTER THE INPUT SIGNAL
//=========================================================
y = filter(b, a, x);
// Remove possible numerical imaginary part
y = real(y);
//=========================================================
// TIME DOMAIN PLOTS
//=========================================================
figure(1);
subplot(3,1,1);
plot(t, x_low);
title(&quot;Low-Frequency Component (50 Hz)&quot;);
xlabel(&quot;Time (s)&quot;);
ylabel(&quot;Amplitude&quot;);
subplot(3,1,2);
plot(t, x);
title(&quot;Composite Input Signal&quot;);
xlabel(&quot;Time (s)&quot;);
ylabel(&quot;Amplitude&quot;);
subplot(3,1,3);
plot(t, y);
title(&quot;Filtered Output Signal&quot;);
xlabel(&quot;Time (s)&quot;);
ylabel(&quot;Amplitude&quot;);
//=========================================================
// FREQUENCY DOMAIN ANALYSIS
//=========================================================
X = fft(x);
Y = fft(y);
f = (0:N-1)*(Fs/N);
//=========================================================
// MAGNITUDE SPECTRUM
//=========================================================
figure(2);
subplot(2,1,1);
plot(f(1:N/2), abs(X(1:N/2)));
title(&quot;Magnitude Spectrum of Input Signal&quot;);
xlabel(&quot;Frequency (Hz)&quot;);
ylabel(&quot;Magnitude&quot;);
subplot(2,1,2);
plot(f(1:N/2), abs(Y(1:N/2)));
title(&quot;Magnitude Spectrum of Filtered Output&quot;);
xlabel(&quot;Frequency (Hz)&quot;);
ylabel(&quot;Magnitude&quot;);
//=========================================================
// DISPLAY FILTER SPECIFICATIONS
//=========================================================
disp(&quot; &quot;);
disp(&quot;======================================&quot;);
disp(&quot;FILTER SPECIFICATIONS&quot;);
disp(&quot;======================================&quot;);
disp(&quot;Filter Type : Butterworth Low-Pass IIR&quot;);
disp(&quot;Filter Order : 4&quot;);
disp(&quot;Sampling Frequency : 1000 Hz&quot;);
disp(&quot;Cut-off Frequency : 100 Hz&quot;);
disp(&quot;Low Frequency Component : 50 Hz&quot;);
disp(&quot;High Frequency Component : 250 Hz&quot;);
disp(&quot; &quot;);
disp(&quot;Filtering completed successfully.&quot;);