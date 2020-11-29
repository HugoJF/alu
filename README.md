Entidade addsub
A operação desta entidade deve ser a seguinte: se o sinal de entrada "operation" = 1, o sinal de saída recebe o resultado da operação aritmética "A - B"; se o sinal de entrada "operation" = 0, o sinal de saída recebe o resultado da operação aritmética "A + B". Sempre que os sinais de entrada mudam de valor, a saída é atualizada.

A entidade addsub é composta de um parâmetro genérico N que define a largura dos sinais de entrada e saída. Os sinais de entrada que representam os operandos são nomeados A e B; o sinal de entrada que representa a seleção da operação a ser aplicada nos operados é nomeado "operation"; o sinal de saída que representa o resultado da operação aplicada é nomeado "S".

A tabela verdade abaixo define o comportamento da entidade addsub:

Comportamento	Valor de "operation"
S = A + B	0 (soma)
S = A - B	1 (subtração)