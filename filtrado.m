pkg load signal

fs = 16000

[audio, fs] = wavread("files/Audio.wav");

function ret = hr(n, wc, L)
    // Función de filtro ideal
    // n = vector de elementos (1:n)
    // wc = frecuencia de corte
    // L = ganancia

    ret = wc* L * sinc(wc * n) / pi;
endfunction

x = 1:length(audio);

// No está andando muy bien
filtered_audio = fftconv(audio, hr(x, pi/2, 3))(1:length(audio));