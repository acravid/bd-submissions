DROP TRIGGER IF EXISTS trigger_unidades_repostas ON evento_reposicao;
DROP TRIGGER IF EXISTS nao_circularidade ON tem_outra;

CREATE OR REPLACE FUNCTION verifica_evento_repo()
RETURNS TRIGGER AS $$
DECLARE unidades_atuais NUMERIC (20);
BEGIN
    SELECT unidades
    INTO unidades_atuais
    FROM planograma
    WHERE (ean, nro, num_serie, fabricante) = (NEW.ean, NEW.nro, NEW.num_serie, NEW.fabricante);

-- Verificação por null?

    IF NOT unidades_atuais >= NEW.unidades
    THEN 
        RAISE EXCEPTION 'Evento de reposição inválido'
        USING HINT = 'Número de unidades repostas inválido';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_unidades_repostas
BEFORE INSERT OR UPDATE ON evento_reposicao
FOR EACH ROW EXECUTE PROCEDURE verifica_evento_repo();

CREATE OR REPLACE FUNCTION verifica_circularidade() -- a mais?
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.categoria = NEW.super_categoria
    THEN
        RAISE EXCEPTION 'Categorias inválidas (circularidade)'
        USING HINT = '';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eh_apresentado_em_prateleira()
RETURNS TRIGGER AS $$
DECLARE n_categorias NUMERIC (20);
BEGIN
    SELECT COUNT(nome) INTO n_categorias
    FROM (
            SELECT nome
            FROM planograma
                NATURAL JOIN prateleira

            INTERSECT

            SELECT nome
            FROM tem_categoria
        ) AS foo;

    IF NOT n_categorias > 0
    THEN
        RAISE EXCEPTION 'A prateleira não apresenta categorias do produto'
    USING HINT = '';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER produto_prateleira
BEFORE INSERT OR UPDATE ON evento_reposicao
FOR EACH ROW EXECUTE PROCEDURE eh_apresentado_em_prateleira();