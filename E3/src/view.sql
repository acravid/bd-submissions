
DROP VIEW IF EXISTS vendas;
CREATE VIEW vendas(
    ean, cat, ano, trimestre, mes, dia_mes, dia_semana, distrito, concelho, unidades)
AS
SELECT  ean AS ean,
        cat AS cat,
        EXTRACT(YEAR FROM instante) AS ano,
        EXTRACT(QUARTER FROM instante) AS trimestre,
        EXTRACT(MONTH FROM instante) AS mes,
        EXTRACT(DAY FROM instante) AS dia_mes,
        EXTRACT(DOW FROM instante) AS dia_semana,
        distrito AS distrito,
        concelho AS concelho,
        unidades AS unidades
FROM evento_reposicao
    NATURAL JOIN produto
    NATURAL JOIN categoria
    NATURAL JOIN planograma
    NATURAL JOIN prateleira
    NATURAL JOIN ivm
    NATURAL JOIN instalada_em
    JOIN ponto_de_retalho ON instalada_em.local = ponto_de_retalho.nome
;