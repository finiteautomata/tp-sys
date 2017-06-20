clc;
clear;
pkg load signal;


function filtered_audio = do_filter(x, Fs, wc)
    orden_filtro=10;
    [b,a] = butter(orden_filtro,wc);

    filtered_audio=filter(b, a, x); %se aplica el filtro con el audio orginal
endfunction

[x, Fs] = wavread("files/Audio.wav");
step = fix(50*Fs/1000);
window = fix(100*Fs/1000);
fftn=2^nextpow2(window)

specgram( x, fftn, Fs, window, window-step);

filtered_audio = do_filter(x, Fs, 0.5);

figure();
specgram( filtered_audio, fftn, Fs, window, window-step);


hf = figure();

decimated_audio = filtered_audio(1:2:end); %agarro una muestra cada 2 del audio original
wavwrite(decimated_audio, Fs, "files/generated/audio_4_decimated.wav");
specgram( decimated_audio, fftn, Fs, window, window-step);

print(hf, "images/specgram_4_decimated.pdf");

