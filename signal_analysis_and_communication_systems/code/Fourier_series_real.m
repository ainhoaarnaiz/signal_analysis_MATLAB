clear all; close all; clc;

T = 5; % period
w0 = 2*pi/T;

F = @(s) [10.*(0<=s & s<1) + 0.*(1<=s & s<=5)];

N = 1000; % 2*N+1 is number of terms in the sum
B = N/T; % The highest frequency is B=N/T
dt = 1/(3*B); % the Nyquist rate is 1/(2*B)

a0 = 2; % mean value over the period
An = zeros(N); phase = zeros(N); 

t = -6:dt:7; 

sum = a0*ones(size(t));
for n=1:N
   an = (4/n/w0)*sin(n*w0);     % Fourier coefficients
   bn = (4/n/w0)*(1-cos(n*w0)); % are given analytically
   sum = sum + an*cos(n*w0*t) + bn*sin(n*w0*t);
end

figure,
plot(t,sum,'linewidth',1.5)
axis([-6 7 0 11])
grid
xlabel('time t')
ylabel('signal')
title(['Pulse waveform, N=',num2str(N),' dt=',num2str(dt)])

