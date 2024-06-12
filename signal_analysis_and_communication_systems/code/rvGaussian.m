% Generation of Rayleigh random variable
clc; clear all; close all;

m=0; % mean
sgma=2; 
n=10000; % number or random numbers
U=rand(1,n); % n uniform r.v.
% Gaussian r.v. from from U
R=m+sqrt(2)*sgma*erfcinv(2*(1-U));
disp('Generated Gaussian random numbers are')
% R
figure(1),
hist(R,50);

% plot the pdf
x=(m-5*sgma):0.01:(m+5*sgma); % define x-axis 
y=1/(sqrt(2*pi*sgma)).*exp(-0.5*((x-m)/sgma).^2); % Gaussian pdf

figure(2),
plot (x,y)
ylabel('probability density function'); xlabel('random variable');
title('Gaussian pdf');
