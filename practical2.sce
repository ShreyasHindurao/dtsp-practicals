// ============================================================
// Linear Convolution of a Swept-Frequency (Chirp) Signal
// with LPF and HPF Impulse Responses (Time Domain)
// ============================================================
clear;
clc;
close;
// ---------------- 1. Generate Swept Frequency (Chirp) Signal ----------------
fs = 1000; // Sampling frequency (Hz)
T = 1; // Duration (s)
t = 0:1/fs:T; // Time vector
f0 = 5; // Start frequency (Hz)
f1 = 100; // End frequency (Hz)
k = (f1 - f0)/T; // Chirp rate
x = sin(2*%pi*(f0*t + (k/2)*t.^2)); // Swept frequency sinusoidal signal
N = length(x);
// ---------------- 2. Design FIR Low Pass Filter (LPF) ----------------------
Fc_lpf = 20/(fs/2); // Normalized cutoff frequency for LPF
M = 33; // Filter order/length (odd, for symmetry)
wft = window(&#39;hn&#39;, M); // Hanning window
hlp = wfir(&#39;lp&#39;, M, [Fc_lpf, 0], &#39;hn&#39;, [0, 0]); // FIR LPF impulse response
hlp = hlp&#39;; // make it a row vector if needed
// ---------------- 3. Design FIR High Pass Filter (HPF) ---------------------
Fc_hpf = 20/(fs/2);
hhp = wfir(&#39;hp&#39;, M, [Fc_hpf, 0], &#39;hn&#39;, [0, 0]); // FIR HPF impulse response
hhp = hhp&#39;;
// ---------------- 4. Linear Convolution in Time Domain ---------------------
y_lpf = convol(x, hlp); // Convolution of chirp signal with LPF
y_hpf = convol(x, hhp); // Convolution of chirp signal with HPF
n1 = 0:length(y_lpf)-1;
n2 = 0:length(y_hpf)-1;
// ---------------- 5. Plot Results ------------------------------------------
scf(1);
subplot(3,1,1);
plot(t, x);
xtitle(&#39;Swept Frequency (Chirp) Input Signal&#39;, &#39;Time (s)&#39;, &#39;Amplitude&#39;);
subplot(3,1,2);
plot(n1/fs, y_lpf);
xtitle(&#39;Output after Convolution with LPF (Low Frequencies Retained)&#39;, &#39;Time (s)&#39;, &#39;Amplitude&#39;);
subplot(3,1,3);
plot(n2/fs, y_hpf);
xtitle(&#39;Output after Convolution with HPF (High Frequencies Retained)&#39;, &#39;Time (s)&#39;, &#39;Amplitude&#39;);
// ---------------- 6. Plot Filter Impulse Responses --------------------------
scf(2);
subplot(2,1,1);
plot2d3(&#39;gnn&#39;, (1:M), hlp);
xtitle(&#39;Impulse Response of LPF&#39;, &#39;n&#39;, &#39;h(n)&#39;);
subplot(2,1,2);
plot2d3(&#39;gnn&#39;, (1:M), hhp);
xtitle(&#39;Impulse Response of HPF&#39;, &#39;n&#39;, &#39;h(n)&#39;);