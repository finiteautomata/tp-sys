clc
pkg load signal


[audio, fs] = wavread("files/Audio.wav");


win = fix(200 * fs / 1000);
stp = fix(100 * fs / 1000);
fftn = 2^nextpow2(win);

[S, f, t] = specgram(audio, fftn, fs, win, win-stp);

new_audio = reconstruct(S, win, stp, 100);

hf = figure()
plot(new_audio(100:end) - audio(100:length(new_audio)));

print(hf, "images/difference_reconstruction_5.pdf");