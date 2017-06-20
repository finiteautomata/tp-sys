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
[S, f, t] = specgram(filtered_audio, fftn, Fs, window, window-step);
S=S(:,1:2:end);

new_audio = reconstruct(S, window, step, 100);
wavwrite(new_audio, Fs, "files/generated/audio_7_decimated.wav");


hf = figure();
specgram(new_audio, fftn, Fs, window, window-step);

print(hf, "images/specgram_7_decimated.pdf");