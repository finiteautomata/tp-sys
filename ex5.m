clc
pkg load signal


[audio, fs] = wavread("files/Audio.wav");


win = fix(200 * fs / 1000);
stp = fix(100 * fs / 1000);
fftn = 2^nextpow2(win);

[S, f, t] = specgram(audio, fftn, fs, win, win-stp);

new_audio = reconstruct(S, win, stp, 10);

plot(new_audio - audio(1:length(new_audio)));
