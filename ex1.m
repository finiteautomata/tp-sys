clc;
clear;
pkg load signal;


[x, Fs] = wavread("files/Audio.wav"); # audio file


function do_specgram(x, Fs, window_ms, step_ms, filename='')
    window=window_ms*Fs/1000; %20mseg
    step=step_ms*Fs/1000; %5mseg    rebanada=ventana-overlap
    fftn=2^nextpow2(window);
    window
    fftn
    hf = figure();
    specgram(x, fftn, Fs, window, window-step);
    
    if filename 
      print(hf, filename);
    endif
endfunction

%-----------------Banda ancha-----------------


%----------------Banda angosta----------------

do_specgram(x, Fs, 16, 8, "images/specgram_w16s8.pdf");
do_specgram(x, Fs, 34, 17, "images/specgram_w34s17.pdf");
do_specgram(x, Fs, 68, 34, "images/specgram_w68s34.pdf");
do_specgram(x, Fs, 100, 50, "images/specgram_w100s50.pdf");
