DROP TRIGGER IF EXISTS verifica_evento_repo ON evento_reposicao;

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