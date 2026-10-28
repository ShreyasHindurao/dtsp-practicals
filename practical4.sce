1 Circular Convolution using DFT
clc;
clear;
close;
//=========================================================
// CIRCULAR CONVOLUTION USING DFT
//=========================================================
x = [1 2 3 4];
h = [1 1 1];
Nx = length(x);
Nh = length(h);
Nc = max(Nx, Nh);
xc = [x, zeros(1, Nc - Nx)];
hc = [h, zeros(1, Nc - Nh)];
Xc = fft(xc, -1);
Hc = fft(hc, -1);
Yc = Xc .* Hc;
y_circ = real(fft(Yc, 1));
disp(&quot;Circular Convolution Result:&quot;);
disp(y_circ);
figure(1);
subplot(3,1,1);
plot2d3(1:length(x), x);
title(&quot;Input Signal x(n)&quot;);
xlabel(&quot;n&quot;); ylabel(&quot;Amplitude&quot;);
subplot(3,1,2);
plot2d3(1:length(h), h);
title(&quot;Impulse Response h(n)&quot;);
xlabel(&quot;n&quot;); ylabel(&quot;Amplitude&quot;);
subplot(3,1,3);
plot2d3(1:length(y_circ), y_circ);
title(&quot;Circular Convolution y_circ(n)&quot;);
xlabel(&quot;n&quot;); ylabel(&quot;Amplitude&quot;);

2 Linear Convolution using DFT (Zero Padding)
clc;
clear;
close;
//=========================================================
// LINEAR CONVOLUTION USING DFT (ZERO PADDING)
//=========================================================
x = [1 2 3 4];
h = [1 1 1];
Nx = length(x);
Nh = length(h);
Nl = Nx + Nh - 1;
xl = [x, zeros(1, Nl - Nx)];
hl = [h, zeros(1, Nl - Nh)];
Xl = fft(xl, -1);
Hl = fft(hl, -1);
Yl = Xl .* Hl;
y_lin = real(fft(Yl, 1));
disp(&quot;Linear Convolution (via DFT) Result:&quot;);
disp(y_lin);
// Verify against built-in function
y_check = convol(x, h);
disp(&quot;Linear Convolution using convol(x,h):&quot;);
disp(y_check);
disp(&quot;Difference (should be ~0):&quot;);
disp(y_lin - y_check);
figure(2);
subplot(3,1,1);
plot2d3(1:length(x), x);
title(&quot;Input Signal x(n)&quot;);
xlabel(&quot;n&quot;); ylabel(&quot;Amplitude&quot;);
subplot(3,1,2);
plot2d3(1:length(h), h);
title(&quot;Impulse Response h(n)&quot;);
xlabel(&quot;n&quot;); ylabel(&quot;Amplitude&quot;);
subplot(3,1,3);
plot2d3(1:length(y_lin), y_lin);
title(&quot;Linear Convolution y_lin(n) via DFT&quot;);
xlabel(&quot;n&quot;); ylabel(&quot;Amplitude&quot;);

3 Comparison of Spectra (With and Without Zero Padding)
clc;
clear;
close;
//=========================================================
// COMPARISON: CIRCULAR vs LINEAR CONVOLUTION SPECTRA
//=========================================================
x = [1 2 3 4];
h = [1 1 1];
Nl = length(x) + length(h) - 1; // = 6
xp = [x, zeros(1, Nl - length(x))];
hp = [h, zeros(1, Nl - length(h))];
Xp = fft(xp, -1);
Hp = fft(hp, -1);
Yp = Xp .* Hp;
y_circ_padded = real(fft(Yp, 1)); // N-point circular conv, N = Nl
disp(&quot;N-point Circular Convolution (N = Nx+Nh-1) equals Linear Convolution:&quot;);
disp(y_circ_padded);
figure(3);
subplot(2,1,1);
plot2d3(1:length(x), abs(fft(x,-1)));
title(&quot;Magnitude Spectrum |X(k)| (N=4, unpadded)&quot;);
xlabel(&quot;k&quot;); ylabel(&quot;|X(k)|&quot;);
subplot(2,1,2);
plot2d3(1:Nl, abs(Xp));
title(&quot;Magnitude Spectrum |X(k)| (N=6, zero-padded)&quot;);
xlabel(&quot;k&quot;); ylabel(&quot;|X(k)|&quot;);