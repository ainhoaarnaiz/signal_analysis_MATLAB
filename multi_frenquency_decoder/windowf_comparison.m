filename = "pin_4.wav";
sample_number = 2000;                   % ENTER THE SAMPLE NUMBER YOU WANT
digit1 =[1,sample_number];              
[y,Fs] = audioread(filename,digit1);

n = length(y);

y_hann = y.*hann(n);                    % Hanning window
y_hamm = y.*hamming(n);                 % Hamming window
y_rect = y.*rectwin(n);                 % Rectangular window
y_black = y.*blackman(n);               % Blackman window

m1 = abs(fft(y_hann));
m2 = abs(fft(y_hamm));
m3 = abs(fft(y_rect));
m4 = abs(fft(y_black));

f = Fs*(0:n-1)/n;

%Plot the window funtions comparison
figure(1);
plot(f,m1,"r",f,m2,"b",f,m3,"k",f,m4,"g"); grid;
axis([650 900 0 300])
legend('Hanning window','Hamming window','Rectangular window','Blackman window','Location','NorthEast')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title("Window functions comparison")