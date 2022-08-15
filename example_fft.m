disp("Testing Radix-2 FFT Implementation.");
s = zeros(1, 512);
s(100:200) = 1;
freqs = fft_simple(s, 512);
xaxis_frequencies = linspace(-1/2, 11/2, 512);

mag_raw = abs(freqs);
mag = [mag_raw(257:end), mag_raw(1:256)];
phase_raw = angle(freqs) * 180 / pi;
phase = [phase_raw(257:end), phase_raw(1:256)];

subplot(2, 1, 1);
plot(xaxis_frequencies, mag);
ylabel("FFT Magnitude");
xlabel("Digital Frequency");
subplot(2, 1, 2);
plot(xaxis_frequencies, phase);
ylabel("FFT Angle (Degrees)");
xlabel("Digital Frequency");

function freqs = fft_simple(signal, N)
    % Recursive base case
    if N == 1
        freqs = signal;
        return;
    end
    
    % Recursive case
    freqs = zeros(1, N);
    odd_fft = fft_simple(signal(1:2:end), N/2);
    even_fft = fft_simple(signal(2:2:end), N/2);
    
    for k=1:N/2
        freqs(k) = odd_fft(k) + exp(1j*2*pi*k/N) * even_fft(k);
        freqs(k+N/2) = odd_fft(k) - exp(1j*2*pi*k/N) * even_fft(k);
    end
end
