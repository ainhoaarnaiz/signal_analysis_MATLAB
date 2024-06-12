clc; clear all; close all;

A=[0.1:0.1:4]';
for k=1:length(A)
  error=0;
  for i=1:10000
    w=randn(1,1);
    if A(k)/2+w <= 0
      error=error+1;
    end
  end
  Pe(k,1)=error/10000 ;
end
plot(A,Pe(:,1)); %