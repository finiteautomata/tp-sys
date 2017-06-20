clc
pkg load signal

[audio, fs] = wavread("files/Audio.wav");

win = fix(200 * fs / 1000);
stp = fix(100 * fs / 1000);
fftn = 2^nextpow2(win);

figure();
specgram(audio, fftn, fs, win, win-stp);


function S_inter = interpolate_spec(S)
    S_inter= zeros(size(S)(1),2*size(S)(2));
    S_inter(:,1:2:end)=S;
    S_inter = S_inter + 0.5 *(circshift(S_inter, [0 1]) + circshift(S_inter, [0 -1]));
endfunction

S=interpolate_spec(S);

new_audio = reconstruct(S, win, stp, 300);

hf = figure();
specgram(new_audio, fftn, fs, win, win-stp);

print(hf, "images/specgram_6_interpolated.pdf")