-- 1
SELECT (ano, mes, dia_mes), dia_semana, concelho, SUM(unidades)
FROM vendas
GROUP BY CUBE ((dia_mes, mes, ano), dia_semana, concelho);

-- 2
SELECT dia_semana, cat, concelho, SUM(unidades)
FROM vendas WHERE distrito = 'Santarém'
GROUP BY CUBE (dia_semana, cat, concelho);