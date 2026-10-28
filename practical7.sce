clc;
clear;
close;
//=========================================================
// REALIZATION OF IIR DIGITAL FILTER
// USING CASCADE AND PARALLEL STRUCTURES
//=========================================================

// Given IIR filter:
// H(z) = (1 + 0.5z^-1)
// / [(1-0.7z^-1)(1-0.4z^-1+0.16z^-2)]
//=========================================================
// IMPULSE INPUT
//=========================================================

N = 100;
x = [1 zeros(1,N-1)];
//=========================================================
// CASCADE REALIZATION
//=========================================================

// Section 1
b1 = [1 0.5];
a1 = [1 -0.7];
// Section 2
b2 = [1];
a2 = [1 -0.4 0.16];
// First cascade section
y1 = filter(b1,a1,x);
// Second cascade section
y_cascade = filter(b2,a2,y1);
//=========================================================
// PARALLEL REALIZATION
//=========================================================

// Section 1:
// Hp1(z) = (84/37)/(1-0.7z^-1)
bp1 = [84/37];
ap1 = [1 -0.7];
// Section 2:
// Hp2(z) = (-47/37 + (96/185)z^-1)
// /(1-0.4z^-1+0.16z^-2)
bp2 = [-47/37 96/185];
ap2 = [1 -0.4 0.16];
// Parallel sections
y_p1 = filter(bp1,ap1,x);
y_p2 = filter(bp2,ap2,x);
// Add section outputs
y_parallel = y_p1 + y_p2;
//=========================================================
// DISPLAY RESPONSES
//=========================================================

disp("======================================");
disp("CASCADE AND PARALLEL REALIZATION");
disp("======================================");
disp("Given IIR Filter:");
disp("H(z) = (1 + 0.5z^-1)/[(1-0.7z^-1)(1-0.4z^-1+0.16z^-2)]");
disp(" ");
disp("Cascade Impulse Response:");
disp(y_cascade);
disp(" ");
disp("Parallel Impulse Response:");
disp(y_parallel);
//=========================================================
// ERROR BETWEEN RESPONSES
//=========================================================

error_signal = y_cascade - y_parallel;
max_error = max(abs(error_signal));
disp(" ");
disp("Maximum Difference between Cascade and Parallel:");
disp(max_error);
//=========================================================
// TIME-DOMAIN COMPARISON
//=========================================================

n = 0:N-1;
figure(1);
subplot(2,1,1);
plot(n,y_cascade);
title("Impulse Response - Cascade Realization");
xlabel("n");
ylabel("Amplitude");
subplot(2,1,2);
plot(n,y_parallel);
title("Impulse Response - Parallel Realization");
xlabel("n");
ylabel("Amplitude");
//=========================================================
// OVERLAPPED RESPONSE
//=========================================================

figure(2);
plot(n,y_cascade);
plot(n,y_parallel);
title("Comparison of Cascade and Parallel Responses");
xlabel("n");
ylabel("Amplitude");
legend("Cascade","Parallel");
//=========================================================
// MAGNITUDE RESPONSE OF CASCADE AND PARALLEL FILTERS
//=========================================================

// Frequency vector
f = 0:0.001:0.5;

//---------------------------------------------------------
// CASCADE OVERALL TRANSFER FUNCTION
//---------------------------------------------------------

bc = [1 0.5];
ac = [1 -1.1 0.44 -0.112];
// Frequency response of cascade realization
Hc = freq(bc, ac, 2*%pi*f);
//---------------------------------------------------------
// PARALLEL OVERALL TRANSFER FUNCTION
//---------------------------------------------------------

bp1 = [84/37];
ap1 = [1 -0.7];
bp2 = [-47/37 96/185];
ap2 = [1 -0.4 0.16];
// Frequency responses of individual parallel sections
Hp1 = freq(bp1, ap1, 2*%pi*f);
Hp2 = freq(bp2, ap2, 2*%pi*f);
// Add parallel responses
Hp = Hp1 + Hp2;
//=========================================================
// PLOT MAGNITUDE RESPONSE
//=========================================================

figure(3);
plot(f, abs(Hc));
plot(f, abs(Hp));
title("Magnitude Response Comparison");
xlabel("Normalized Frequency (× pi rad/sample)");
ylabel("Magnitude");
legend("Cascade","Parallel");
disp("Magnitude response plotted successfully.");