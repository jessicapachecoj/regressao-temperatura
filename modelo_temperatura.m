clc;
clear all;

%-------------------------------------------------
% Carrega o pacote para ler arquivos Excel (.xlsx)
%-------------------------------------------------
pkg load io;

%-------------------------------------------------
% Lê os dados da planilha (anos e temperaturas médias)
%-------------------------------------------------
[~, ~, bruto] = xlsread('dadosmeteorologia.xlsx');

% Coluna E = anos, coluna F = TAVE
dadosAnos = bruto(3:end, 5);  % coluna E
dadosTAVE = bruto(3:end, 6);  % coluna F

% Cria vetores vazios para armazenar os valores válidos
anos = [];
tave = [];

% Filtra apenas as linhas com números válidos
for i = 1:length(dadosAnos)
    if isnumeric(dadosAnos{i}) && isnumeric(dadosTAVE{i})
        anos(end+1) = dadosAnos{i};
        tave(end+1) = dadosTAVE{i};
    end
end

%-------------------------------------------------
% Separa os dados de 1914 até 2013 para treino
%-------------------------------------------------
indiceTreino = find(anos <= 2013);
anos_treino = anos(indiceTreino);
tave_treino = tave(indiceTreino);

% Valor real de 2014
indice2014 = find(anos == 2014);
tave_2014_real = tave(indice2014);

%-------------------------------------------------
% Centraliza os anos para melhorar precisão numérica
%-------------------------------------------------
ano_base = anos_treino(1);
anos_treino = anos_treino - ano_base;
ano2014 = 2014 - ano_base;

%-------------------------------------------------
% Testa polinômios de grau 1 até 4
%-------------------------------------------------
graus = 1:4;
erros = zeros(size(graus));

for i = 1:length(graus)
    grau = graus(i);
    p = polyfit(anos_treino, tave_treino, grau);          % modelo
    tave_pred = polyval(p, anos_treino);                  % previsão
    erros(i) = mean((tave_pred - tave_treino).^2);        % erro quadrático médio
end

%-------------------------------------------------
% Escolhe o grau com menor erro
%-------------------------------------------------
[~, idxMelhor] = min(erros);
grau_melhor = graus(idxMelhor);
fprintf('Melhor grau do polinômio: %d\n', grau_melhor);

%-------------------------------------------------
% Gera o modelo final com o melhor grau
%-------------------------------------------------
p_melhor = polyfit(anos_treino, tave_treino, grau_melhor);

% Previsão para 2014 (com ano centralizado)
tave_2014_previsto = polyval(p_melhor, ano2014);
fprintf('Temperatura prevista para 2014: %.2f\n', tave_2014_previsto);

%-------------------------------------------------
% Calcula a média real de 2014 e compara
%-------------------------------------------------
media_2014_real = mean(tave_2014_real);
fprintf('Temperatura média real de 2014: %.2f\n', media_2014_real);

diferenca_corrigida = tave_2014_previsto - media_2014_real;
fprintf('Diferença entre previsto e média real: %.2f\n', diferenca_corrigida);

%-------------------------------------------------
% Plota os dados, o modelo e os pontos de 2014
%-------------------------------------------------
figure;
plot(anos_treino + ano_base, tave_treino, 'b', 'linewidth', 1.5);  % dados reais
hold on;
plot(anos_treino + ano_base, polyval(p_melhor, anos_treino), 'r--', 'linewidth', 2); % modelo
plot(2014, tave_2014_previsto, 'ko', 'markerfacecolor', 'g', 'markersize', 8); % previsão 2014
plot(2014, media_2014_real, 'ko', 'markerfacecolor', 'm', 'markersize', 8);     % média real 2014

xlabel('Ano');
ylabel('Temperatura Média (°C)');
legend('Dados Reais', 'Modelo Polinomial', 'Previsão 2014', 'Média Real 2014');
title('Regressão Polinomial da Temperatura Média (1914–2014)');
grid on;


