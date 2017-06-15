pkg load signal

fs = 16000

[audio, fs] = wavread("files/Audio.wav");

# Agrego ceros

function new_audio = interpolate(audio)
    new_audio = zeros(2* length(audio), 1);
    new_audio(2:2:end) = audio;
    new_audio = new_audio + 0.5 *(circshift(new_audio, 1) + circshift(new_audio, -1));
endfunction


new_audio = interpolate(audio);

