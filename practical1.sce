# 3.1 Linear Convolution
clc;
clear;
close;

//===================================================
// LINEAR CONVOLUTION OF TWO SIGNALS
//===================================================

x = [1 2 3 4];
h = [1 1 1];
y = convol(x,h);
disp(&quot;Linear Convolution Result:&quot;);
disp(y);

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
plot2d3(1:length(y), y);
title(&quot;Linear Convolution y(n)&quot;);
xlabel(&quot;n&quot;); ylabel(&quot;Amplitude&quot;);

# 3.2 Autocorrelation of a Non-Periodic Signal
clc;
clear;
close;
//===================================================
// AUTOCORRELATION OF A NON-PERIODIC (FINITE) SIGNAL
//===================================================
x = [1 2 3 4 0 0 0 0];
N = length(x);
r = xcorr(x,x);
lags = -(N-1):(N-1);
disp(&quot;Autocorrelation of Non-Periodic Signal:&quot;);
disp(r);

figure(2);
subplot(2,1,1);
plot2d3(1:N, x);
title(&quot;Non-Periodic Signal x(n)&quot;);
xlabel(&quot;n&quot;); ylabel(&quot;Amplitude&quot;);

subplot(2,1,2);
plot2d3(lags, r);
title(&quot;Autocorrelation of Non-Periodic Signal&quot;);
xlabel(&quot;Lag (l)&quot;); ylabel(&quot;Rxx(l)&quot;);


# 3.3 Autocorrelation of a Periodic Signal

clc;
clear;
close;
//===================================================
// AUTOCORRELATION OF A PERIODIC SIGNAL
//===================================================
n = 0:31;
x = sin(2*%pi*n/8); // periodic sinusoid, period = 8
N = length(x);
r = xcorr(x,x);
lags = -(N-1):(N-1);
disp(&quot;Autocorrelation of Periodic Signal computed.&quot;);

figure(3);
subplot(2,1,1);
plot2d3(n, x);
title(&quot;Periodic Signal x(n) = sin(2*pi*n/8)&quot;);
xlabel(&quot;n&quot;); ylabel(&quot;Amplitude&quot;);

subplot(2,1,2);
plot2d(lags, r);
title(&quot;Autocorrelation of Periodic Signal&quot;);
xlabel(&quot;Lag (l)&quot;); ylabel(&quot;Rxx(l)&quot;);


3.4 Autocorrelation of Random Noise
clc;
clear;
close;
//===================================================
// AUTOCORRELATION OF RANDOM NOISE
//===================================================
n = 0:63;
x = rand(1,length(n),&quot;normal&quot;); // random Gaussian noise
N = length(x);
r = xcorr(x,x);
lags = -(N-1):(N-1);
disp(&quot;Autocorrelation of Random Noise computed.&quot;);

figure(4);
subplot(2,1,1);
plot2d(n, x);
title(&quot;Random Noise Signal x(n)&quot;);
xlabel(&quot;n&quot;); ylabel(&quot;Amplitude&quot;);

subplot(2,1,2);
plot2d(lags, r);
title(&quot;Autocorrelation of Random Noise&quot;);
xlabel(&quot;Lag (l)&quot;); ylabel(&quot;Rxx(l)&quot;);