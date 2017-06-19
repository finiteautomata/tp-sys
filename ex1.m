clc;
clear;
pkg load signal;


[x, Fs] = wavread("files/Audio.wav"); # audio file


%-----------------Banda ancha-----------------
window=20*Fs/1000; %20mseg
step=10*Fs/1000; %5mseg    rebanada=ventana-overlap
fftn=2^nextpow2(window);
figure();
specgram(x, fftn, Fs, window, window-step);


%----------------Banda angosta----------------
window=67*Fs/1000; %el minimo de banda angosta
step=5*Fs/1000; %5mseg
fftn=2^nextpow2(window);
figure();
specgram(x, fftn, Fs, window, window-step);

window=100*Fs/1000; %100mseg
step; %5mseg
fftn=2^nextpow2(window);
figure();
specgram(x, fftn, Fs, window, window-step);

%Veo como influye el overlap:
window; %100mseg
step=50*Fs/1000; %5mseg
fftn=2^nextpow2(window);
figure();
specgram(x, fftn, Fs, window, window-step);

%Veo como influye la cantidad de fft
window;
step;
fftn=2^12;
figure();
specgram(x, fftn, Fs, window, window-step);

%%se puede observar que con una ventana de 80mseg tengo una buena resolucion en frecuencia y con un overlap de 10mseg (80-70) aumenta el ancho del tiempo
%%%queda a definir cual es el de banda ancha (si con 20mseg estan bien)
