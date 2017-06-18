clc;
clear;
pkg load signal;
pkg load audio;


[x, fs] = auload(file_in_loadpath("Audio.wav")); # audio file

%Aplico primero el filtro
wc=fs/4;
nysq=fs/2;
orden_filtro=10;
[b,a] = butter(orden_filtro,wc/nysq);

x=filter(b, a, x); %se aplica el filtro con el audio orginal

%%Luego realizo espectrograma


win = fix(100 * fs / 1000);
stp = fix(50 * fs / 1000);
fftn = 2^11;
[S, f, t] = specgram(x, fftn, fs, win, win-stp);


%%Decimar

S=S(:,1:2:end);



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
wavwrite(nuevo_audio,fs, "audio_spec_dosX_7.wav");

specgram(nuevo_audio, fftn, fs, win, win-stp);
