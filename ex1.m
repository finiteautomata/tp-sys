pkg load signal

fs = 16000


# Una muestra cada 0.2 segundos
#

step = ceil(200* fs / 1000);
window = ceil(1000 * fs / 1000);

audio = wavread("files/Audio.wav");

specgram(audio, window, fs, window, window - step);
