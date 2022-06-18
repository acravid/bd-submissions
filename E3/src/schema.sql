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
    nome VARCHAR(150)
);

CREATE TABLE categoria_simples(
    nome VARCHAR(150)
);

CREATE TABLE super_categoria(
    nome VARCHAR(50)
);

CREATE TABLE tem_outra(
    super_categoria VARCHAR(50),
    categoria VARCHAR(50)
);

CREATE TABLE produto(
    ean NUMERIC(13,0),
    cat VARCHAR(50),
    descr VARCHAR(50)
);

CREATE TABLE tem_categoria(
    ean NUMERIC(13,0),
    nome VARCHAR(50),
);

CREATE TABLE IVM(
    num_serie NUMERIC(13,0),
    fabricante VARCHAR(50),
);

CREATE TABLE ponto_de_retalho(
    nome VARCHAR(50),
    distrito VARCHAR(50),
    concelho VARCHAR(50)
);

CREATE TABLE instalada_em(
    num_serie NUMERIC(13,0),
    fabricante VARCHAR(50),
    local VARCHAR(50)
);

CREATE TABLE prateleira(
    num_serie NUMERIC(13,0),
    fabricante VARCHAR(50),
    nome VARCHAR(50)
);

CREATE TABLE planograma(
    ean NUMERIC(13,0),
    num_serie NUMERIC(13,0),
    fabricante VARCHAR(50),
    nome VARCHAR(50)
);

CREATE TABLE retalhista(
    tin NUMERIC(13,0),
    name VARCHAR(50)
);

CREATE TABLE responsavel_por(
    num_serie NUMERIC(13,0),
    fabricante VARCHAR(50),
    nome_cat VARCHAR(50)
);

CREATE TABLE evento_reposicao();