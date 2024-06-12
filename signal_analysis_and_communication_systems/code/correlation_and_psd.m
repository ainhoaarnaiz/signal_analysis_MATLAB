% correlation of two signals
close all; clear all; clc;
N = 1024; % number of samples to generate
f1 = 3; % frequency of the sinewave
f2 = 10; % frequency of the sinewave
fs = 200; % sampling frequency
n = 0:N-1; % sampling index
x = 3*sin(2*pi*f1*n/fs)+sin(2*pi*f2*n/fs); % generating x[n]
y = x+2*randn(1,N); % generating y[n]=x[n]+w[n]

figure,
subplot(2,1,1),plot(x),axis([0 1024 -8 8]),title('pure sinewave'),grid;
subplot(2,1,2),plot(y),axis([0 1024 -8 8]),title('noisy sinewave'),grid;
