pkg load signal

function new_audio = reconstruct(S, win, stp, offset=10)
  
  % Agrego flipeado y conjugado para reconstruir la DFT entera
  % Agrego zero padding de una fila ademas
 
  S_ext=[S;zeros(1,size(S)(2)); conj(S(end:-1:2, :))];
  % Calculo ifft y me quedo s
  ifft_S=real(ifft(S_ext));
  
  % Normalizo por la ventana utilizada1
  ifft_S=ifft_S(1:win, :)./hanning(win);
  % Aca me voy quedando solo con stp elementos 
  
  new_audio=ifft_S(offset:stp+offset-1,:)(:);
  % Finalmente, agrego el principio que corte y el final
  first=ifft_S(1:offset-1,1);
  last=ifft_S(stp+offset:win,end);
  new_audio=[first;new_audio;last];
endfunction