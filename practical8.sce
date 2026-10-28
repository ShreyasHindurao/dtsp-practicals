clc;
clear;
close;
// Original system coefficients
b = [0.5 0.3 0.2];
a = [1 -0.4 0.2];
// Number of fractional bits
N = 3;
// Quantization step
q = 2^(-N);
// --------------------------------------------------
// 1. Coefficient Quantization using Truncation
// --------------------------------------------------
b_trunc = floor(b/q) * q;
a_trunc = floor(a/q) * q;
// --------------------------------------------------
// 2. Coefficient Quantization using Rounding
// --------------------------------------------------
b_round = round(b/q) * q;
a_round = round(a/q) * q;
// Display coefficients
disp(&quot;Original numerator coefficients:&quot;);
disp(b);
disp(&quot;Original denominator coefficients:&quot;);
disp(a);
disp(&quot;Coefficients after Truncation:&quot;);
disp(&quot;b_trunc = &quot;);
disp(b_trunc);
disp(&quot;a_trunc = &quot;);
disp(a_trunc);
disp(&quot;Coefficients after Rounding:&quot;);
disp(&quot;b_round = &quot;);
disp(b_round);
disp(&quot;a_round = &quot;);
disp(a_round);
// --------------------------------------------------
// Input signal
// --------------------------------------------------
n = 0:30;
x = sin(0.2*%pi*n);
// --------------------------------------------------
// System output using original coefficients
// --------------------------------------------------
y_original = filter(b, a, x);
// Output using truncated coefficients
y_trunc = filter(b_trunc, a_trunc, x);
// Output using rounded coefficients
y_round = filter(b_round, a_round, x);
// --------------------------------------------------
// Plot the outputs
// --------------------------------------------------
scf(1);
subplot(3,1,1);
plot(n, y_original);
xtitle(&quot;Output with Original Coefficients&quot;, &quot;n&quot;, &quot;Amplitude&quot;);
xgrid();
subplot(3,1,2);
plot(n, y_trunc);
xtitle(&quot;Output with Truncated Coefficients&quot;, &quot;n&quot;, &quot;Amplitude&quot;);
xgrid();
subplot(3,1,3);
plot(n, y_round);
xtitle(&quot;Output with Rounded Coefficients&quot;, &quot;n&quot;, &quot;Amplitude&quot;);
xgrid();
// --------------------------------------------------
// Calculate quantization error
// --------------------------------------------------
error_trunc = y_original - y_trunc;
error_round = y_original - y_round;
disp(&quot;Maximum output error due to truncation:&quot;);
disp(max(abs(error_trunc)));
disp(&quot;Maximum output error due to rounding:&quot;);
disp(max(abs(error_round)));