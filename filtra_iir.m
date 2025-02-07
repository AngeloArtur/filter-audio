function y = filtra_iir(b, a, x)

  N = length(x);     % tamanho do vetor de entrada
  M = length(b);     % ordem do numerador (número de coeficientes b)
  P = length(a);     % ordem do denominador (número de coeficientes a)

  y = zeros(1, N);   % inicializa o vetor de saída com zeros

  % Loop principal para calcular a saída do filtro
  for n = 1:N
    y(n) = 0;

    % Calcula a parte do numerador
    for m = 1:M
      if n-m+1 > 0   % Verifica se o índice é válido
        y(n) = y(n) + b(m) * x(n-m+1);
      endif
    endfor

    % Calcula a parte do denominador
    for p = 2:P
      if n-p+1 > 0
        y(n) = y(n) - a(p) * y(n-p+1);
      endif
    endfor
  endfor
endfunction
