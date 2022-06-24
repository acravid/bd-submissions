-- a )
SELECT nome
FROM(
    SELECT tin, nome, COUNT (DISTINCT nome_cat) AS categorias
    FROM retalhista NATURAL JOIN responsavel_por
    GROUP BY tin, nome
) AS foo
WHERE categorias >= ALL (SELECT COUNT (DISTINCT nome_cat)
                         FROM retalhista NATURAL JOIN responsavel_por
                         GROUP BY tin, nome
);


-- b)


SELECT nome 
FROM retalhista
WHERE tin IN (
	SELECT tin FROM responsavel_por 
	WHERE nome_cat IN (
		SELECT nome FROM categoria_simples
	)
);

-- c)

SELECT ean 
FROM product 
EXCEPT(SELECT ean FROM evento_reposicao);


-- d)

SELECT ean FROM evento_reposicao GROUP BY ean HAVING COUNT(DISTINCT tin) = 1;