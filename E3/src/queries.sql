



-- c)

SELECT ean 
FROM product 
EXCEPT(SELECT ean FROM evento_reposicao);


-- d)

SELECT ean FROM evento_reposicao GROUP BY ean HAVING COUNT(DISTINCT tin) = 1;