clc
pkg load signal

[audio, fs] = wavread("Audio.wav");

figure();
plot(audio);


win = fix(100 * fs / 1000);
stp = fix(50 * fs / 1000);
fftn = 2^11;
[S, f, t] = specgram(audio, fftn, fs, win, win-stp);
%figure();
%specgram(audio, fftn, fs, win, win-stp);

S_ext=[S;conj(S(end-1:-1:2, :))];%%%Flipeo y conjugo
ifft_S=real(ifft(S_ext));
ifft_normalizada=ifft_S(1:win, :)./hanning(win);
%figure();
%plot(abs(ifft_normalizada));



offset=10;
nuevo_audio=ifft_normalizada(offset:stp+offset-1,:)(:);%%%CLAVE!
principio=ifft_normalizada(1:offset-1,1);
fin=ifft_normalizada(stp+offset:win,end);
nuevo_audio=[principio;nuevo_audio;fin];
figure();
plot(nuevo_audio(1:1000));%%%Se puede ver que la señal reconstruida es parecida a la original, solo que le faltan 10 muestras que se consideran insignificante frente a 16000???
wavwrite(nuevo_audio,fs, "frankestein10.wav");
[audio_reconstruido, fs] = wavread("frankestein10.wav");
%figure();                        %%%se puede utilizar el espectrorama para ver el ruido feo
%specgram(audio, fftn, fs, win, win-stp);
plot(audio(1:600000)-audio_reconstruido(1:600000));
