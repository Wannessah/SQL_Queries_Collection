--1)Quais são todos os produtos vendidos na tabela de vendas? (Somente IDs e quantidades).

SELECT  IDProduto, Qtde
FROM Vendas

--2)Liste todas as informações dos clientes que realizaram uma compra.

SELECT DISTINCT C. * 
FROM Clientes C
JOIN Vendas V ON C.IDCliente = V.IDCliente

--3)Mostre todas as lojas cadastradas.
SELECT * FROM Lojas

--4)Quais são as categorias disponíveis na tabela de categorias?
SELECT Categoria
FROM Categoria

--5)Liste os produtos vendidos com a categoria e o valor total das vendas de cada produto.
SELECT * FROM Vendas
SELECT * FROM Categoria
SELECT * FROM Produto

SELECT P.Produto, C.Categoria,
FORMAT (SUM (V.Valor), 'C', 'pt-BR') as ValorTotalVendas
FROM Produto P
JOIN Categoria C ON P.IDCategoria = C.IDCategoria
JOIN Vendas V ON P.IDProduto = V.IDProduto
GROUP BY P.Produto, C.Categoria
ORDER BY P.Produto

--6)Mostre os nomes dos clientes e o estado que mais compraram produtos de um determinado segmento, como "Compacto".
SELECT C.NomeCliente, C.Estado, 
SUM(V.Qtde) AS QtdTotal
FROM Vendas V
JOIN Produto P ON V.IDProduto = P.IDProduto
JOIN Clientes C ON V.IDCliente = C.IDCliente
WHERE P.Segmento = 'Compacto'
GROUP BY C.NomeCliente, C.Estado
ORDER BY QtdTotal DESC

--7)Encontre todas as devoluções feitas pela Loja 6 , exibindo o nome do cliente e o produto devolvido.

SELECT C.NomeCliente, P.Produto
FROM Devolucoes d
JOIN Produto P ON D.IDProduto = P.IDProduto
JOIN Clientes C ON D.IDCliente = C.IDCliente
JOIN Lojas L ON D.IDloja = L.IDLoja
WHERE L.Loja = 'Loja 6'

--8)Quais lojas tiveram o maior número de vendas e qual foi o valor total?
SELECT L.Loja,
SUM(V.Qtde) AS 'QtdTotal',
FORMAT(SUM (V.Valor),'C','pt-BR') AS ValorTotal
FROM Vendas V
JOIN Lojas L ON V.IDloja = L.IDLoja
GROUP BY L.Loja
ORDER BY SUM(Valor) desc

--9)Liste os produtos que foram vendidos uma unica vez.
 SELECT DISTINCT P.Produto
 FROM PRODUTO P 
 JOIN Vendas V ON P.IDProduto = V.IDProduto
 WHERE V.Qtde = 1

 --10)Exiba os clientes que compraram produtos de pelo menos 3 categorias diferentes.

 SELECT V.IDCliente, C.NomeCliente, COUNT(DISTINCT CA.IDCategoria) AS CategoriaComprada
 FROM Vendas V
 JOIN Clientes C ON V.IDCliente = C.IDCliente
 JOIN Produto P ON V.IDProduto = P.IDProduto
 JOIN Categoria CA ON P.IDCategoria = CA.IDCategoria
 GROUP BY V.IDCliente , C.NomeCliente
 HAVING COUNT(DISTINCT CA.IDCategoria) >=1

 --11)Mostre os 5 produtos mais vendidos, exibindo o nome do produto, quantidade total e o valor total arrecadado.
 
 SELECT TOP 5 P.Produto, 
  SUM (V.Qtde) AS Quant_Total,
 FORMAT (SUM (v.Valor), 'C','Pt-BR') AS Valor_Total
 FROM Vendas V
 JOIN Produto P ON V.IDProduto = P.IDProduto
 GROUP BY P.Produto
 ORDER BY Quant_Total DESC
 
 --12)Calcule o total de devoluções por estado, mostrando o nome do estado, quantidade devolvida e valor total.
 SELECT C.Estado, 
 SUM (D.Qtde) AS QtdTotal, 
 FORMAT(SUM(D.Valor), 'C','pt-BR') AS ValorTotal
 FROM Devolucoes D
 JOIN Clientes C ON D.IDCliente = C.IDCliente
 GROUP BY C.Estado
 ORDER BY QtdTotal DESC

 --13)Encontre as lojas que venderam produtos de uma determinada Segmento, exibindo o nome da loja e o valor total arrecadado.
 SELECT l.Loja, P.Segmento,
 FORMAT(SUM (v.Valor),'C','Pt-BR') AS Valor_Arrecadado
 FROM VENDAS V
 JOIN Lojas L ON L.IDLoja = V.IDloja
 JOIN Produto P ON P.IDProduto = V.IDProduto
 WHERE P.Segmento = 'SUBCOMPACTO'
 GROUP BY L.Loja, P.Segmento
 ORDER BY Valor_Arrecadado DESC

 

 