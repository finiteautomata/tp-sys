clc;
clear;
pkg load signal;
pkg load audio;


[x, Fs] = auload(file_in_loadpath("Audio.wav")); # audio file
largo_window=100; %100mseg
largo_rebanada=50; %50mseg para que sea la mitad de overlap
fftn=2^11;%2^11=2048
step = fix(largo_rebanada*Fs/1000);    
window = fix(largo_window*Fs/1000);
[S,t,f]=specgram( x, fftn, Fs, window-step); %(X, N, FS, WINDOW, OVERLAP)

%----decimar-----
%%%%%Configuracion Filtro Butterworth
wc=Fs/4;
nysq=Fs/2;
orden_filtro=10;
[b,a] = butter(orden_filtro,wc/nysq);

audio_filtrado=filter(b, a, x); %se aplica el filtro con el audio orginal
audio_decimado=audio_filtrado(1:2:end); %agarro una muestra cada 2 del audio original

figure();
plot(audio_decimado);
figure();
plot(x);
wavwrite(audio_decimado, Fs, "audio_decimado4.wav");
figure();
specgram(audio_decimado,Fs);