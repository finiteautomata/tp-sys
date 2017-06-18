pkg load signal

fs = 16000

[audio, Fs] = wavread("Audio.wav");

# Agrego ceros

function new_audio = interpolate(audio)
    new_audio = zeros(2* length(audio), 1);
    new_audio(2:2:end) = audio;
    new_audio = new_audio + 0.5 *(circshift(new_audio, 1) + circshift(new_audio, -1));
endfunction


new_audio = interpolate(audio);

window=100*Fs/1000;%100mseg
step=50*Fs/1000; %5mseg    rebanada=ventana-overlap
fftn=2^11;%2^9=512
figure();
specgram(audio, fftn, Fs, window, window-step);
figure();
specgram(new_audio, fftn, Fs, window, window-step);
wavwrite(new_audio,Fs,"Audio_inter3.wav");