**📊 Análise de Dados: Regressão Polinomial de Temperatura Média**

Foco: Implementação de um modelo de regressão polinomial para analisar e extrapolar séries temporais de temperatura média (TAVE) ao longo de 100 anos, demonstrando proficiência em modelagem estatística e validação de dados.


**1. OBJETIVO E METODOLOGIA**

Este projeto resolve o problema de extrapolação de dados em uma série temporal longa (1914–2013). O objetivo é construir o modelo estatístico mais preciso para prever a temperatura média do ano subsequente (2014) e quantificar o erro dessa previsão.

Metodologia: Otimização do Grau Polinomial

A abordagem principal foi baseada na seleção do melhor modelo através da avaliação iterativa. O script testa polinômios de diferentes graus (de 1 a 4) e seleciona aquele com o menor Erro Quadrático Médio (MSE) na base de dados de treino.

Vantagem: Garante que o modelo escolhido seja o mais robusto, minimizando o risco de overfitting aos dados históricos.



**2. DADOS E PRÉ-PROCESSAMENTO**

Fonte de Dados: Série histórica de temperatura média (TAVE) no período de 1914 a 2013.

Etapas de Pré-processamento:

Filtro de Dados: Tratamento inicial dos dados brutos para garantir que apenas valores numéricos válidos fossem utilizados na modelagem.

Centralização: Os valores dos anos foram centralizados (subtraindo o ano base) antes da modelagem. Esta técnica melhora a estabilidade numérica e a precisão dos coeficientes do polinômio, prática essencial em estatística.


**3. MODELAGEM E VALIDAÇÃO**


3.1. Seleção e Criação do Modelo

O modelo de regressão é criado utilizando a função polyfit. A melhor versão (o grau polinomial que minimiza o MSE) é automaticamente selecionada para a extrapolação final, garantindo a escolha metodológica.

3.2. Extrapolação e Cálculo do Erro

Extrapolação: O modelo otimizado é usado para prever o valor da TAVE para o ano de 2014.

Métrica de Validação: A Diferença Corrigida entre o valor previsto e o valor real de 2014 (média real) é calculada, servindo como a métrica final de performance da extrapolação.


**4. RESULTADOS VISUAIS (Gráfico de Extrapolação)**


O resultado final é apresentado em um gráfico que visualiza a aderência do modelo aos dados históricos e a precisão da extrapolação.

Linha Azul: Série de dados históricos (1914–2013).

Linha Tracejada Vermelha: Curva do Modelo Polinomial (melhor grau selecionado).

Ponto Verde: Valor previsto pelo modelo para 2014 (Extrapolação).

Ponto Roxo: Valor real observado para 2014.


<img width="350" height="301" alt="image" src="https://github.com/user-attachments/assets/768bd16f-8820-4ef0-8532-52c4036f9ec2" />



**5. TECNOLOGIAS E FERRAMENTAS**

Linguagem: Octave/MATLAB (utilizado para o código de modelagem e lógica de programação).

Biblioteca: pkg load io para manipulação de arquivos de dados (Excel).

Funções-chave: polyfit (criação do modelo) e polyval (avaliação/previsão).
