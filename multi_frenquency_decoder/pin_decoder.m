
filename = "pin_4.wav";
[y,Fs] = audioread(filename);
disp("Sampling frequency = " +Fs+ "Hz");

% Calculating pulse width and spacing
t = (1/Fs)*(1:length(y));
T = t(Fs/4);                                % period in sec (each digit has 2000 samples, 0.25 sec of audio)

count1 = 0;
count2 = 0;
for i = 1:1:2000
    if y(i) == 0
        count1 = count1 + 1;
    else
        count2 = count2 + 1;
    end

end

dc = count2/(count1 + count2);
disp("Duty cycle = " + round(dc*100) + "%");
pw = dc*T;                                  % pulse width in sec
ps = T-pw;                                  % pulse spacing in sec
disp("Pulse width = " + round(pw*1000) + "ms");
disp("Pulse spacing = " + round(ps*1000) + "ms");

% Isolating individual tones
digit1 =[1,length(y)-(0.85*Fs)];            % digit 1, 1200 samples
digit2 =[(0.25*Fs),length(y)-(0.6*Fs)];     % digit 2, 1200 samples
digit3 =[(0.5*Fs),length(y)-(0.35*Fs)];     % digit 3, 1200 samples
digit4 =[(0.75*Fs),length(y)-(0.1*Fs)];     % digit 4, 1200 samples

disp("Pin decoded:");

for i = 1:1:4
    if i == 1
        [y] = audioread(filename,digit1);   % first 0.25 seconds of audio
    elseif i == 2
        [y] = audioread(filename,digit2);   % from 0.25 to 0.5 seconds
    elseif i == 3
        [y] = audioread(filename,digit3);   % from 0.5 to 0.75 seconds
    elseif i == 4
        [y] = audioread(filename,digit4);   % from 0.75 to 1 seconds
    end
    
    % Applying Hanning window and fourier
    n = length(y);
    y_hann = y.*hann(n);                    % change n to see results, n = 2001
    m = abs(fft(y_hann));
    f = Fs*(0:n-1)/n;
    
    % Identifying the numbers
    [peaks] = unique(maxk(m(:,1), 3));      % find the 2 energy peaks
    index1 = find(m==peaks(1),1);           % find the index of those energy peaks
    index2 = find(m==peaks(2),1);
    z = [m f.'];                            % combine magnitudes and frequencies in a unique matrix (.' = traspose matrix)
    a = z(index1,2);                        % find the frequencies of those energy peaks
    b = z(index2,2);

    % Find the digit/number
    if (1901 <= a+b) && (a+b <= 1916)
        digit = 1;
    elseif (2028 <= a+b) && (a+b <= 2043)
        digit = 2;
    elseif (2169 <= a+b) && (a+b <= 2184)
        digit = 3;
    elseif (1974 <= a+b) && (a+b <= 1989)
        digit = 4;
    elseif (2101 <= a+b) && (a+b <= 2116)
        digit = 5;
    elseif (2242 <= a+b) && (a+b <= 2257)
        digit = 6;
    elseif (2056 <= a+b) && (a+b <= 2071)
        digit = 7;
    elseif (2183 <= a+b) && (a+b <= 2198)
        digit = 8;
    elseif (2324 <= a+b) && (a+b <= 2339)
        digit = 9;
    elseif (2145 <= a+b) && (a+b <= 2160)
        digit = "*";
    elseif (2272 <= a+b) && (a+b <= 2287)
        digit = 0;
    elseif (2413 <= a+b) && (a+b <= 2428)
        digit = "#";
    end

    disp(digit);
    
    %Plot the Magnitude spectra of the digit
    subplot(2,2,i)
    plot(f,m); grid;
    axis([500 1600 0 200])                  % (200 is 300 without windowing)
    xlabel('Frequency (Hz)')
    ylabel('Amplitude')
    title("Magnitude Spectra of digit " +digit+" (freq. " +round(a)+ "Hz and " +round(b)+ "Hz)")
    
end

set(gcf, 'WindowState', 'maximized');

