pkg load signal

fs = 16000

[audio, Fs] = wavread("files/Audio.wav");

# Agrego ceros

function new_audio = interpolate(audio)
    new_audio = zeros(2* length(audio), 1);
    new_audio(2:2:end) = audio;
    new_audio = new_audio + 0.5 *(circshift(new_audio, 1) + circshift(new_audio, -1));
endfunction


new_audio = interpolate(audio);

window=100*Fs/1000;%100mseg
step=50*Fs/1000; %5mseg    rebanada=ventana-overlap
fftn=2^nextpow2(window);%2^9=512

hf = figure();
specgram(new_audio, fftn, Fs, window, window-step);

print(hf, "images/specgram_3_interpolated.pdf");
wavwrite(new_audio,Fs,"files/generated/audio_3_interp.wav");