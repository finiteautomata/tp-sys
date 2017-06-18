clc
pkg load signal

[audio, fs] = wavread("Audio.wav");

figure();
plot(audio(1:1000));
win = fix(100 * fs / 1000);
stp = fix(50 * fs / 1000);
fftn = 2^11;
[S, f, t] = specgram(audio, fftn, fs, win, win-stp);
%Espectrograma original
figure();
specgram(audio, fftn, fs, win, win-stp);





function S_inter = interpolate_spec(S)
    S_inter= zeros(size(S)(1),2*size(S)(2));
    S_inter(:,1:2:end)=S;
    S_inter = S_inter + 0.5 *(circshift(S_inter, [0 1]) + circshift(S_inter, [0 -1]));
endfunction

S=interpolate_spec(S);






S_ext=[S;conj(S(end-1:-1:2, :))];
ifft_S=real(ifft(S_ext));
ifft_normalizada=ifft_S(1:win, :)./hanning(win);
%figure();
%plot(abs(ifft_normalizada));
offset=10;
nuevo_audio=ifft_normalizada(offset:stp+offset-1,:)(:);%%%CLAVE!
principio=ifft_normalizada(1:offset-1,1);
fin=ifft_normalizada(stp+offset:win,end);
nuevo_audio=[principio;nuevo_audio;fin];

wavwrite(nuevo_audio,fs, "Audio_spec_interp6.wav");
[audio_reconstruido, fs] = wavread("Audio_spec_interp6.wav");
figure();                       
specgram(audio_reconstruido, fftn, fs, win, win-stp);

