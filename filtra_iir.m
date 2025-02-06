function y = filtra_iir(b, a, xn)
  % Comprimento do sinal de entrada
  N = length(xn);
  % Ordem do filtro (número de coeficientes do numerador)
  od = length(b);
  % Inicializa o vetor de saída y com zeros
  y = zeros(1, N);

  % Loop para calcular o filtro recursivo
  for jn = od:(N-od)
    % Extrai uma fatia do vetor de entrada xn e inverte a ordem
    x_slice = flip(xn(jn-od+1:jn));

    % Extrai uma fatia do vetor de saída y e inverte a ordem
    y_slice = flip(y(jn-od+2:jn));

    % Calcula o valor atual de y usando os coeficientes b e a
    % Multiplicação ponto a ponto com .*
    y(jn) = sum(b .* x_slice') - sum(a(1:end) .* y_slice');
  endfor

  % Calcula o ganho como a razão entre os desvios padrão
  gain = std(xn) / std(y);

  % Ajusta o sinal de saída com base no ganho
  y = gain * y;
endfunction
