# SQL_Queries_Collection
Uma coleção de consultas SQL usadas para análise de dados, vendas, clientes e lojas. Contém consultas para diversas operações, como agregações, junções, filtragem e relatórios detalhados


Aqui está a explicação passo a passo de cada consulta SQL:

1) Quais são todos os produtos vendidos na tabela de vendas? (Somente IDs e quantidades)
SELECT IDProduto, Qtde
FROM Vendas

Explicação:

Objetivo: Retorna todos os produtos vendidos, mostrando apenas o ID do produto (IDProduto) e a quantidade vendida (Qtde).
Fonte de dados: A consulta busca as informações na tabela Vendas, que armazena dados sobre as vendas realizadas.

2) Liste todas as informações dos clientes que realizaram uma compra.


SELECT DISTINCT C.* 
FROM Clientes C
JOIN Vendas V ON C.IDCliente = V.IDCliente
Explicação:

Objetivo: Retorna todas as informações dos clientes que realizaram uma compra.
JOIN: A consulta faz um JOIN entre as tabelas Clientes e Vendas, conectando-as através do campo IDCliente.
DISTINCT: O uso de DISTINCT garante que os clientes não sejam repetidos, mesmo que tenham feito várias compras.

3) Mostre todas as lojas cadastradas.


SELECT * FROM Lojas
Explicação:

Objetivo: Retorna todas as informações de todas as lojas cadastradas na tabela Lojas.
Fonte de dados: A consulta busca dados diretamente da tabela Lojas.

4) Quais são as categorias disponíveis na tabela de categorias?


SELECT Categoria
FROM Categoria
Explicação:

Objetivo: Retorna todas as categorias disponíveis na tabela Categoria.
Fonte de dados: A consulta busca a coluna Categoria da tabela Categoria.


5) Liste os produtos vendidos com a categoria e o valor total das vendas de cada produto.


SELECT P.Produto, C.Categoria,
FORMAT(SUM(V.Valor), 'C', 'pt-BR') as ValorTotalVendas
FROM Produto P
JOIN Categoria C ON P.IDCategoria = C.IDCategoria
JOIN Vendas V ON P.IDProduto = V.IDProduto
GROUP BY P.Produto, C.Categoria
ORDER BY P.Produto
Explicação:

Objetivo: Lista os produtos vendidos junto com a categoria de cada um e o valor total das vendas de cada produto.
JOIN: Faz a junção entre as tabelas Produto, Categoria e Vendas.
A junção entre Produto e Categoria é feita pelo campo IDCategoria.
A junção entre Produto e Vendas é feita pelo campo IDProduto.
GROUP BY: Agrupa os dados por produto e categoria.
SUM(V.Valor): Calcula o valor total das vendas de cada produto.
FORMAT: Formata o valor total das vendas para o formato monetário brasileiro.


6) Mostre os nomes dos clientes e o estado que mais compraram produtos de um determinado segmento, como "Compacto".


SELECT C.NomeCliente, C.Estado, 
SUM(V.Qtde) AS QtdTotal
FROM Vendas V
JOIN Produto P ON V.IDProduto = P.IDProduto
JOIN Clientes C ON V.IDCliente = C.IDCliente
WHERE P.Segmento = 'Compacto'
GROUP BY C.NomeCliente, C.Estado
ORDER BY QtdTotal DESC
Explicação:

Objetivo: Retorna os clientes que mais compraram produtos do segmento "Compacto", com o nome e o estado de cada cliente, e a quantidade total comprada.
JOIN: Faz a junção entre as tabelas Vendas, Produto e Clientes.
WHERE: Filtra os produtos do segmento "Compacto".
GROUP BY: Agrupa os resultados por cliente e estado.
SUM: Soma a quantidade comprada de cada produto por cliente.
ORDER BY: Ordena os resultados pela quantidade total comprada, em ordem decrescente.

7) Encontre todas as devoluções feitas pela Loja 6, exibindo o nome do cliente e o produto devolvido.


SELECT C.NomeCliente, P.Produto
FROM Devolucoes D
JOIN Produto P ON D.IDProduto = P.IDProduto
JOIN Clientes C ON D.IDCliente = C.IDCliente
JOIN Lojas L ON D.IDLoja = L.IDLoja
WHERE L.Loja = 'Loja 6'
Explicação:

Objetivo: Retorna os clientes e os produtos devolvidos pela Loja 6.
JOIN: Faz a junção entre as tabelas Devolucoes, Produto, Clientes e Lojas para conectar as informações.
WHERE: Filtra as devoluções da Loja 6.


8) Quais lojas tiveram o maior número de vendas e qual foi o valor total?


SELECT L.Loja,
SUM(V.Qtde) AS 'QtdTotal',
FORMAT(SUM(V.Valor),'C','pt-BR') AS ValorTotal
FROM Vendas V
JOIN Lojas L ON V.IDloja = L.IDLoja
GROUP BY L.Loja
ORDER BY SUM(Valor) DESC
Explicação:

Objetivo: Retorna as lojas com o maior número de vendas, juntamente com o valor total arrecadado.
JOIN: Faz a junção entre as tabelas Vendas e Lojas.
SUM: Calcula o total de vendas por loja.
FORMAT: Formata o valor total das vendas para o formato monetário brasileiro.
ORDER BY: Ordena os resultados pelo valor total das vendas, em ordem decrescente.


9) Liste os produtos que foram vendidos uma única vez.


SELECT DISTINCT P.Produto
FROM PRODUTO P 
JOIN Vendas V ON P.IDProduto = V.IDProduto
WHERE V.Qtde = 1
Explicação:

Objetivo: Retorna os produtos que foram vendidos apenas uma vez.
JOIN: Faz a junção entre as tabelas Produto e Vendas.
WHERE: Filtra os produtos que foram vendidos com quantidade igual a 1.


10) Exiba os clientes que compraram produtos de pelo menos 3 categorias diferentes.


SELECT V.IDCliente, C.NomeCliente, COUNT(DISTINCT CA.IDCategoria) AS CategoriaComprada
FROM Vendas V
JOIN Clientes C ON V.IDCliente = C.IDCliente
JOIN Produto P ON V.IDProduto = P.IDProduto
JOIN Categoria CA ON P.IDCategoria = CA.IDCategoria
GROUP BY V.IDCliente , C.NomeCliente
HAVING COUNT(DISTINCT CA.IDCategoria) >= 3
Explicação:

Objetivo: Retorna os clientes que compraram produtos de pelo menos 3 categorias diferentes.
JOIN: Faz a junção entre as tabelas Vendas, Clientes, Produto e Categoria.
COUNT(DISTINCT): Conta o número de categorias distintas compradas por cada cliente.
HAVING: Filtra os clientes que compraram produtos de 3 ou mais categorias.


11) Mostre os 5 produtos mais vendidos, exibindo o nome do produto, quantidade total e o valor total arrecadado.


SELECT TOP 5 P.Produto, 
  SUM(V.Qtde) AS Quant_Total,
  FORMAT(SUM(V.Valor), 'C','pt-BR') AS Valor_Total
FROM Vendas V
JOIN Produto P ON V.IDProduto = P.IDProduto
GROUP BY P.Produto
ORDER BY Quant_Total DESC
Explicação:

Objetivo: Retorna os 5 produtos mais vendidos, com a quantidade total e o valor total arrecadado.
JOIN: Faz a junção entre as tabelas Vendas e Produto.
TOP 5: Limita os resultados aos 5 produtos mais vendidos.
SUM: Soma a quantidade e o valor das vendas por produto.
ORDER BY: Ordena os resultados pela quantidade total, em ordem decrescente.


12) Calcule o total de devoluções por estado, mostrando o nome do estado, quantidade devolvida e valor total.


SELECT C.Estado, 
SUM(D.Qtde) AS QtdTotal, 
FORMAT(SUM(D.Valor), 'C','pt-BR') AS ValorTotal
FROM Devolucoes D
JOIN Clientes C ON D.IDCliente = C.IDCliente
GROUP BY C.Estado
ORDER BY QtdTotal DESC
Explicação:

Objetivo: Retorna o total de devoluções por estado, mostrando a quantidade devolvida e o valor total das devoluções.
JOIN: Faz a junção entre as tabelas Devolucoes e Clientes.
SUM: Soma a quantidade e o valor das devoluções por estado.
ORDER BY: Ordena os resultados pela quantidade devolvida, em ordem decrescente.


