-- 1 - esquema de base de dados

DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS categoria_simples;
DROP TABLE IF EXISTS super_categoria;
DROP TABLE IF EXISTS tem_outra;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS tem_categoria;
DROP TABLE IF EXISTS IVM;
DROP TABLE IF EXISTS ponto_de_retalho;
DROP TABLE IF EXISTS instalada_em;
DROP TABLE IF EXISTS prateleira;
DROP TABLE IF EXISTS planograma;
DROP TABLE IF EXISTS retalhista;
DROP TABLE IF EXISTS responsavel_por;
DROP TABLE IF EXISTS evento_reposicao;


CREATE TABLE categoria(
    nome VARCHAR(150) NOT NULL,
    PRIMARY KEY(nome)
);

CREATE TABLE categoria_simples(
    nome VARCHAR(150) NOT NULL,
    PRIMARY KEY(nome), 
    FOREIGN KEY (nome) REFERENCES categoria(nome)

);

CREATE TABLE super_categoria(
    nome VARCHAR(150) NOT NULL,
    PRIMARY KEY (nome),
    FOREIGN KEY (nome) REFERENCES categoria(nome)

);

CREATE TABLE tem_outra(
    super_categoria VARCHAR(150) NOT NULL,
    categoria VARCHAR(150) NOT NULL,
    PRIMARY KEY (categoria),
    FOREIGN KEY (super_categoria) REFERENCES super_categoria(nome),
    FOREIGN KEY (categoria) REFERENCES categoria(nome),
    UNIQUE (super_categoria, categoria),
    CHECK (super_categoria != categoria)
);

CREATE TABLE produto(
    ean NUMERIC(13,0) NOT NULL CHECK (ean >= 0),
    cat VARCHAR(150) NOT NULL, 
    descr VARCHAR(150) NOT NULL,
    PRIMARY KEY (ean),
    FOREIGN KEY (cat) REFERENCES categoria(nome)
    -- add constraint 
);

CREATE TABLE tem_categoria(
    ean NUMERIC(13,0) NOT NULL CHECK (ean >= 0),
    nome VARCHAR(150),
    PRIMARY KEY (ean,nome),
    FOREIGN KEY (ean) REFERENCES produto(ean),
    FOREIGN KEY (nome) REFERENCES categoria(nome)
);

CREATE TABLE IVM(
    --   ean           NUMERIC(13)   NOT NULL CHECK (ean >= 0), -- EAN tem sempre 13 digitos
    -- population INT NOT NULL CHECK (population >= 0)
    num_serie INT NOT NULL CHECK (num_serie >= 0),
    fabricante VARCHAR(150) NOT NULL,
    PRIMARY KEY (num_serie,fabricante)
    -- UNIQUE(num_serie)
);

CREATE TABLE ponto_de_retalho(
    nome VARCHAR(150) NOT NULL,
    distrito VARCHAR(150) NOT NULL,
    concelho VARCHAR(150) NOT NULL,
    PRIMARY KEY (nome)
);

CREATE TABLE instalada_em(
    num_serie INT NOT NULL CHECK (num_serie >= 0),
    fabricante VARCHAR(150) NOT NULL,
    loc VARCHAR(150) NOT NULL,
    PRIMARY KEY (num_serie,fabricante),
    FOREIGN KEY (num_serie,fabricante) REFERENCES IVM(num_serie,fabricante),
    FOREIGN KEY (loc)  REFERENCES ponto_de_retalho(nome)
);

CREATE TABLE prateleira(
    --a(nro, num_serie, fabricante, altura, nome)
    nro SMALLINT NOT NULL,
    num_serie INT NOT NULL CHECK (num_serie >= 0),
    fabricante VARCHAR(150) NOT NULL,
    altura SMALLINT NOT NULL CHECK (altura > 0),
    nome VARCHAR(150) NOT NULL,
    PRIMARY KEY (nro,num_serie,fabricante),
    FOREIGN KEY (num_serie,fabricante) REFERENCES IVM(num_serie,fabricante),
    FOREIGN KEY (nome) REFERENCES categoria(nome)
);

CREATE TABLE planograma(
    --ma(ean, nro, num_serie, fabricante, faces, unidades, loc)
    ean NUMERIC(13,0) NOT NULL CHECK (ean >= 0),
    nro SMALLINT NOT NULL,
    num_serie INT NOT NULL CHECK (num_serie >= 0),
    fabricante VARCHAR(150) NOT NULL,
    faces SMALLINT NOT NULL CHECK (faces >= 0),
    unidades INT NOT NULL CHECK (unidades > 0),
    loc VARCHAR(150) NOT NULL,
    PRIMARY KEY (ean,nro,num_serie,fabricante),
    FOREIGN KEY (ean) REFERENCES produto(ean),
    FOREIGN KEY (nro,num_serie,fabricante) REFERENCES prateleira(nro,num_serie,fabricante)
);

CREATE TABLE retalhista(
    tin NUMERIC(9,0) NOT NULL CHECK (tin >= 0),
    nome VARCHAR(150) NOT NULL,
    PRIMARY KEY (tin),
    UNIQUE(nome) 
);

CREATE TABLE responsavel_por(
    nome_cat VARCHAR(150) NOT NULL,
    tin NUMERIC(9,0) NOT NULL CHECK (tin >= 0),
    num_serie INT NOT NULL CHECK (num_serie >= 0),
    fabricante VARCHAR(150) NOT NULL,
    PRIMARY KEY (num_serie,fabricante),
    FOREIGN KEY (num_serie,fabricante) REFERENCES IVM(num_serie,fabricante),
    FOREIGN KEY (tin) REFERENCES retalhista(tin),
    FOREIGN KEY (nome_cat) REFERENCES categoria(nome)
);

CREATE TABLE evento_reposicao(
    ean NUMERIC(13,0) NOT NULL CHECK (ean >= 0),
    nro SMALLINT NOT NULL,
    num_serie INT NOT NULL CHECK (num_serie >= 0),
    fabricante VARCHAR(150) NOT NULL,
    instante TIMESTAMP  NOT NULL,
    unidades INT NOT NULL CHECK (unidades > 0),
    tin NUMERIC(9,0) NOT NULL CHECK (tin >= 0),
    PRIMARY KEY (ean,nro,num_serie,fabricante,instante),
    FOREIGN KEY (ean,nro,num_serie,fabricante) REFERENCES planograma(ean,nro,num_serie,fabricante),
    FOREIGN KEY (tin) REFERENCES retalhista(tin)
);