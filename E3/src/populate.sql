-- 1 - esquema de base de dados

DROP TABLE IF EXISTS evento_reposicao;
DROP TABLE IF EXISTS responsavel_por;
DROP TABLE IF EXISTS retalhista;
DROP TABLE IF EXISTS planograma;
DROP TABLE IF EXISTS instalada_em;
DROP TABLE IF EXISTS ponto_de_retalho;
DROP TABLE IF EXISTS prateleira;
DROP TABLE IF EXISTS IVM;
DROP TABLE IF EXISTS tem_outra;
DROP TABLE IF EXISTS categoria_simples;
DROP TABLE IF EXISTS super_categoria;
DROP TABLE IF EXISTS tem_categoria;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS categoria;

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
    "local" VARCHAR(150) NOT NULL,
    PRIMARY KEY (num_serie,fabricante),
    FOREIGN KEY (num_serie,fabricante) REFERENCES IVM(num_serie,fabricante),
    FOREIGN KEY ("local")  REFERENCES ponto_de_retalho(nome)
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
-- 2 - dados de teste

INSERT INTO categoria VALUES ('Bilheteria de Concertos');
INSERT INTO categoria VALUES ('Concerto Jazz');
INSERT INTO categoria VALUES ('Rock in Rio');
INSERT INTO categoria VALUES ('Pastelaria');
INSERT INTO categoria VALUES ('Pastelaria Tradicional Portuguesa');
INSERT INTO categoria VALUES ('Pastelaria Russa');
INSERT INTO categoria VALUES ('Jogos');
INSERT INTO categoria VALUES ('Jogos de Tabuleiro');
INSERT INTO categoria VALUES ('Jogos de Cartas e Colecionaveis');
INSERT INTO categoria VALUES ('Puzzles');
INSERT INTO categoria VALUES ('Jogos Educativos e Didáticos');
INSERT INTO categoria VALUES ('BD E MANGA');
INSERT INTO categoria VALUES ('Comics');
INSERT INTO categoria VALUES ('Graphic Novels');
INSERT INTO categoria VALUES ('Manga');
INSERT INTO categoria VALUES ('BD Franco-Belga');
INSERT INTO categoria VALUES ('Vegetais');
INSERT INTO categoria VALUES ('Batatas');
INSERT INTO categoria VALUES ('Batatas Redondas');
INSERT INTO categoria VALUES ('Batatas Ovais');
INSERT INTO categoria VALUES ('Batatas Redondas Portuguesas');
INSERT INTO categoria VALUES ('Batatas Redondas Espanholas');
INSERT INTO categoria VALUES ('Batatas Ovais Portuguesas');
INSERT INTO categoria VALUES ('Batatas Ovais Espanholas');

INSERT INTO categoria_simples VALUES ('Concerto Jazz');
INSERT INTO categoria_simples VALUES ('Rock in Rio');
INSERT INTO categoria_simples VALUES ('Pastelaria Tradicional Portuguesa');
INSERT INTO categoria_simples VALUES ('Pastelaria Russa');
INSERT INTO categoria_simples VALUES ('Jogos de Tabuleiro');
INSERT INTO categoria_simples VALUES ('Jogos de Cartas e Colecionaveis');
INSERT INTO categoria_simples VALUES ('Puzzles');
INSERT INTO categoria_simples VALUES ('Jogos Educativos e Didáticos');
INSERT INTO categoria_simples VALUES ('Comics');
INSERT INTO categoria_simples VALUES ('Graphic Novels');
INSERT INTO categoria_simples VALUES ('Manga');
INSERT INTO categoria_simples VALUES ('BD Franco-Belga');
INSERT INTO categoria_simples VALUES ('Batatas Redondas Portuguesas');
INSERT INTO categoria_simples VALUES ('Batatas Redondas Espanholas');
INSERT INTO categoria_simples VALUES ('Batatas Ovais Portuguesas');
INSERT INTO categoria_simples VALUES ('Batatas Ovais Espanholas');

INSERT INTO super_categoria VALUES ('Bilheteria de Concertos');
INSERT INTO super_categoria VALUES ('Pastelaria');
INSERT INTO super_categoria VALUES ('Jogos');
INSERT INTO super_categoria VALUES ('BD E MANGA');
INSERT INTO super_categoria VALUES ('Vegetais');
INSERT INTO super_categoria VALUES ('Batatas');
INSERT INTO super_categoria VALUES ('Batatas Redondas');
INSERT INTO super_categoria VALUES ('Batatas Ovais');

INSERT INTO tem_outra VALUES ('Bilheteria de Concertos' , 'Concerto Jazz');
INSERT INTO tem_outra VALUES ('Bilheteria de Concertos' , 'Rock in Rio');
INSERT INTO tem_outra VALUES ('Pastelaria' , 'Pastelaria Tradicional Portuguesa');
INSERT INTO tem_outra VALUES ('Pastelaria' , 'Pastelaria Russa');
INSERT INTO tem_outra VALUES ('Jogos' , 'Jogos de Tabuleiro');
INSERT INTO tem_outra VALUES ('Jogos' , 'Jogos de Cartas e Colecionaveis');
INSERT INTO tem_outra VALUES ('Jogos' , 'Puzzles');
INSERT INTO tem_outra VALUES ('Jogos' , 'Jogos Educativos e Didáticos');
INSERT INTO tem_outra VALUES ('BD E MANGA' , 'Comics');
INSERT INTO tem_outra VALUES ('BD E MANGA' , 'Graphic Novels');
INSERT INTO tem_outra VALUES ('BD E MANGA' , 'Manga');
INSERT INTO tem_outra VALUES ('BD E MANGA' , 'BD Franco-Belga');
INSERT INTO tem_outra VALUES ('Vegetais' , 'Batatas');
INSERT INTO tem_outra VALUES ('Batatas' , 'Batatas Redondas');
INSERT INTO tem_outra VALUES ('Batatas' , 'Batatas Ovais');
INSERT INTO tem_outra VALUES ('Batatas Ovais' , 'Batatas Ovais Portuguesas');
INSERT INTO tem_outra VALUES ('Batatas Ovais' , 'Batatas Ovais Espanholas');
INSERT INTO tem_outra VALUES ('Batatas Redondas' , 'Batatas Redondas Portuguesas');
INSERT INTO tem_outra VALUES ('Batatas Redondas' , 'Batatas Redondas Espanholas');

INSERT INTO produto VALUES (6724720415006 , 'Concerto Jazz' , 'Yosemite Jazz Train');
INSERT INTO produto VALUES (3066878977973 , 'Concerto Jazz' , 'Blue Note Napa');
INSERT INTO produto VALUES (7459992703439 , 'Concerto Jazz' , 'Lake Arbor Jazz Festival');
INSERT INTO produto VALUES (8696269363171 , 'Rock in Rio' , 'Rock in Rio 2022 day 1');
INSERT INTO produto VALUES (4557627136203 , 'Pastelaria Tradicional Portuguesa' , 'Bolo das Alhadas');
INSERT INTO produto VALUES (9942465294964 , 'Pastelaria Tradicional Portuguesa' , 'Cascoréis da Guarda');
INSERT INTO produto VALUES (2710900779537 , 'Pastelaria Russa' , 'Tchak-Tchak');
INSERT INTO produto VALUES (3995024369208 , 'Jogos de Tabuleiro' , 'D&D Fantasy Roleplaying Game Essentials Kit');
INSERT INTO produto VALUES (9636288660814 , 'Jogos de Tabuleiro' , 'Mazescape Labyrinthos');
INSERT INTO produto VALUES (9921300602214 , 'Jogos de Cartas e Colecionaveis' , 'Pokémon! Sword & Shield Evolving Skies Sleeved Booster Pack');
INSERT INTO produto VALUES (1318457603402 , 'Jogos de Cartas e Colecionaveis' , 'Pokémon S&S 7 Evolving Skies 3 Pack Blister');
INSERT INTO produto VALUES (2757533699180 , 'Puzzles' , 'Puzzle Mordillo Impossible');
INSERT INTO produto VALUES (1466521538768 , 'Puzzles' , 'Puzzle Stranger Things Impossible!');
INSERT INTO produto VALUES (3654965036310 , 'Jogos Educativos e Didáticos' , 'Logic Farm');
INSERT INTO produto VALUES (4663585483537 , 'Jogos Educativos e Didáticos' , 'Guess The Flag Africa');
INSERT INTO produto VALUES (1544636251593 , 'Comics' , 'Moon Knight - Book 1: Omnibus');
INSERT INTO produto VALUES (2796302894290 , 'Comics' , 'Deadpool - Preto, Branco & Sangue');
INSERT INTO produto VALUES (8609107719766 , 'Graphic Novels' , 'Stranger Things – Acampamento de Ciências');
INSERT INTO produto VALUES (6389373905722 , 'Graphic Novels' , 'Economix');
INSERT INTO produto VALUES (1384349735413 , 'Manga' , 'SPY X FAMILY - VOL 1');
INSERT INTO produto VALUES (1384349735513 , 'Manga' , 'SPY X FAMILY - VOL 2');
INSERT INTO produto VALUES (1384349935513 , 'BD Franco-Belga' , 'Asterix Il Alcaforron');
INSERT INTO produto VALUES (1384349765513 , 'BD Franco-Belga' , 'Asterix I Alcaforron');
INSERT INTO produto VALUES (8819012883703 , 'Batatas Redondas Portuguesas' , 'Redodinhas Chips PT');
INSERT INTO produto VALUES (5783688071158 , 'Batatas Redondas Espanholas' , 'Redoditas Chips ES');
INSERT INTO produto VALUES (5649355897352 , 'Batatas Ovais Portuguesas' , 'Ovaldinhas Chips PT');
INSERT INTO produto VALUES (6351441592787 , 'Batatas Ovais Espanholas' , 'Ovaladitas Chips ES');

INSERT INTO tem_categoria VALUES (6724720415006 , 'Concerto Jazz');
INSERT INTO tem_categoria VALUES (3066878977973 , 'Concerto Jazz');
INSERT INTO tem_categoria VALUES (7459992703439 , 'Concerto Jazz');
INSERT INTO tem_categoria VALUES (8696269363171 , 'Rock in Rio');
INSERT INTO tem_categoria VALUES (4557627136203 , 'Pastelaria Tradicional Portuguesa');
INSERT INTO tem_categoria VALUES (9942465294964 , 'Pastelaria Tradicional Portuguesa');
INSERT INTO tem_categoria VALUES (2710900779537 , 'Pastelaria Russa');
INSERT INTO tem_categoria VALUES (3995024369208 , 'Jogos de Tabuleiro');
INSERT INTO tem_categoria VALUES (9636288660814 , 'Jogos de Tabuleiro');
INSERT INTO tem_categoria VALUES (9921300602214 , 'Jogos de Cartas e Colecionaveis');
INSERT INTO tem_categoria VALUES (1318457603402 , 'Jogos de Cartas e Colecionaveis');
INSERT INTO tem_categoria VALUES (2757533699180 , 'Puzzles');
INSERT INTO tem_categoria VALUES (1466521538768 , 'Puzzles');
INSERT INTO tem_categoria VALUES (3654965036310 , 'Jogos Educativos e Didáticos');
INSERT INTO tem_categoria VALUES (4663585483537 , 'Jogos Educativos e Didáticos');
INSERT INTO tem_categoria VALUES (1544636251593 , 'Comics');
INSERT INTO tem_categoria VALUES (2796302894290 , 'Comics');
INSERT INTO tem_categoria VALUES (8609107719766 , 'Graphic Novels');
INSERT INTO tem_categoria VALUES (6389373905722 , 'Graphic Novels');
INSERT INTO tem_categoria VALUES (1384349735413 , 'Manga');
INSERT INTO tem_categoria VALUES (1384349735513 , 'Manga');
INSERT INTO tem_categoria VALUES (1384349935513 , 'BD Franco-Belga');
INSERT INTO tem_categoria VALUES (1384349765513 , 'BD Franco-Belga');
INSERT INTO tem_categoria VALUES (8819012883703 , 'Batatas Redondas Portuguesas');
INSERT INTO tem_categoria VALUES (5783688071158 , 'Batatas Redondas Espanholas');
INSERT INTO tem_categoria VALUES (5649355897352 , 'Batatas Ovais Portuguesas');
INSERT INTO tem_categoria VALUES (6351441592787 , 'Batatas Ovais Espanholas');

INSERT INTO IVM VALUES (0 , 'Labsa');
INSERT INTO IVM VALUES (1 , 'Demodia');
INSERT INTO IVM VALUES (2 , 'Pitho');
INSERT INTO IVM VALUES (3 , 'Hotan');
INSERT INTO IVM VALUES (4 , 'CucaTest');
INSERT INTO IVM VALUES (5 , 'CookieLabs');
INSERT INTO IVM VALUES (6 , 'Eten');
INSERT INTO IVM VALUES (7 , 'JazzFul');
INSERT INTO IVM VALUES (8 , 'Jubex');
INSERT INTO IVM VALUES (9 , 'Harumaki');
INSERT INTO IVM VALUES (10 , 'YorokobiNoKonpyUta');
INSERT INTO IVM VALUES (11 , 'Jojorata');

INSERT INTO ponto_de_retalho VALUES ('Terena' , 'Evora,' , 'Alandroal');
INSERT INTO ponto_de_retalho VALUES ('Capelins' , 'Evora,' , 'Alandroal');
INSERT INTO ponto_de_retalho VALUES ('Amareleja' , 'Beja' , 'Moura');
INSERT INTO ponto_de_retalho VALUES ('Argela' , 'Viana do Castelo' , 'Caminha');
INSERT INTO ponto_de_retalho VALUES ('Vile' , 'Viana do Castelo' , 'Caminha');
INSERT INTO ponto_de_retalho VALUES ('Vale da Mula' , 'Guarda' , 'Almeida');
INSERT INTO ponto_de_retalho VALUES ('Fazendas de Almeirim' , 'Santarém' , 'Almeirim');
INSERT INTO ponto_de_retalho VALUES ('Benfica do Ribatejo' , 'Santarém' , 'Almeirim');
INSERT INTO ponto_de_retalho VALUES ('Pombalinho' , 'Santárem' , 'Golega');
INSERT INTO ponto_de_retalho VALUES ('Azinhaga' , 'Santárem' , 'Golega');
INSERT INTO ponto_de_retalho VALUES ('Lavos' , 'Coimbra' , 'Figueira da Foz,');
INSERT INTO ponto_de_retalho VALUES ('Marinha das Ondas' , 'Coimbra' , 'Figueira da Foz,');

INSERT INTO instalada_em VALUES (0 , 'Labsa' , 'Terena');
INSERT INTO instalada_em VALUES (1 , 'Demodia' , 'Capelins');
INSERT INTO instalada_em VALUES (2 , 'Pitho' , 'Amareleja');
INSERT INTO instalada_em VALUES (3 , 'Hotan' , 'Argela');
INSERT INTO instalada_em VALUES (4 , 'CucaTest' , 'Vile');
INSERT INTO instalada_em VALUES (5 , 'CookieLabs' , 'Vale da Mula');
INSERT INTO instalada_em VALUES (6 , 'Eten' , 'Fazendas de Almeirim');
INSERT INTO instalada_em VALUES (7 , 'JazzFul' , 'Benfica do Ribatejo');
INSERT INTO instalada_em VALUES (8 , 'Jubex' , 'Pombalinho');
INSERT INTO instalada_em VALUES (9 , 'Harumaki' , 'Azinhaga');
INSERT INTO instalada_em VALUES (10 , 'YorokobiNoKonpyUta' , 'Lavos');
INSERT INTO instalada_em VALUES (11 , 'Jojorata' , 'Marinha das Ondas');

INSERT INTO prateleira VALUES (0 , 0 , 'Labsa' , 10 , 'Concerto Jazz');
INSERT INTO prateleira VALUES (1 , 1 , 'Demodia' , 11 , 'Rock in Rio');
INSERT INTO prateleira VALUES (2 , 2 , 'Pitho' , 4 , 'Pastelaria Tradicional Portuguesa');
INSERT INTO prateleira VALUES (3 , 3 , 'Hotan' , 12 , 'Pastelaria Russa');
INSERT INTO prateleira VALUES (4 , 4 , 'CucaTest' , 9 , 'Jogos de Tabuleiro');
INSERT INTO prateleira VALUES (5 , 5 , 'CookieLabs' , 10 , 'Jogos de Cartas e Colecionaveis');
INSERT INTO prateleira VALUES (6 , 6 , 'Eten' , 10 , 'Puzzles');
INSERT INTO prateleira VALUES (7 , 7 , 'JazzFul' , 10 , 'Jogos Educativos e Didáticos');
INSERT INTO prateleira VALUES (8 , 8 , 'Jubex' , 12 , 'Comics');
INSERT INTO prateleira VALUES (9 , 9 , 'Harumaki' , 10 , 'Graphic Novels');
INSERT INTO prateleira VALUES (10 , 10 , 'YorokobiNoKonpyUta' , 6 , 'Manga');
INSERT INTO prateleira VALUES (11 , 11 , 'Jojorata' , 11 , 'BD Franco-Belga');
INSERT INTO prateleira VALUES (12 , 1 , 'Labsa' , 9 , 'Batatas Redondas Portuguesas');
INSERT INTO prateleira VALUES (13 , 8 , 'CookieLabs' , 12 , 'Batatas Redondas Espanholas');
INSERT INTO prateleira VALUES (14 , 7 , 'Eten' , 3 , 'Batatas Ovais Portuguesas');
INSERT INTO prateleira VALUES (15 , 7 , 'Harumaki' , 3 , 'Batatas Ovais Espanholas');

INSERT INTO planograma VALUES (6724720415006 , 0 , 0, 'Labsa' , 2 , 5 ,'weowewdw0');
INSERT INTO planograma VALUES (8696269363171 , 1 , 1, 'Demodia' , 3 , 6 ,'weowewdw1');
INSERT INTO planograma VALUES (4557627136203 , 2 , 2, 'Pitho' , 4 , 7 ,'weowewdw2');
INSERT INTO planograma VALUES (2710900779537 , 3 , 3, 'Hotan' , 5 , 8 ,'weowewdw3');
INSERT INTO planograma VALUES (3995024369208 , 4 , 4, 'CucaTest' , 6 , 9 ,'weowewdw4');
INSERT INTO planograma VALUES (9921300602214 , 5 , 5, 'CookieLabs' , 7 , 10 ,'weowewdw5');
INSERT INTO planograma VALUES (2757533699180 , 6 , 6, 'Eten' , 8 , 11 ,'weowewdw6');
INSERT INTO planograma VALUES (3654965036310 , 7 , 7, 'JazzFul' , 9 , 12 ,'weowewdw7');
INSERT INTO planograma VALUES (2796302894290 , 8 , 8, 'Jubex' , 10 , 13 ,'weowewdw8');
INSERT INTO planograma VALUES (6389373905722 , 9 , 9, 'Harumaki' , 11 , 14 ,'weowewdw9');
INSERT INTO planograma VALUES (1384349735413 , 10 , 10, 'YorokobiNoKonpyUta' , 12 , 15 ,'weowewdw10');
INSERT INTO planograma VALUES (1384349935513 , 11 , 11, 'Jojorata' , 13 , 16 ,'weowewdw11');
INSERT INTO planograma VALUES (8819012883703 , 12 , 12, 'Demodia' , 3 , 15 ,'weowewdw9');
INSERT INTO planograma VALUES (5783688071158 , 13 , 13, 'CookieLabs' , 7 , 6 ,'weowewdw8');
INSERT INTO planograma VALUES (5649355897352 , 14 , 14, 'Labsa' , 2 , 8 ,'weowewdw3');
INSERT INTO planograma VALUES (6351441592787 , 15 , 15, 'Hotan' , 5 , 10 ,'weowewdw11');

INSERT INTO retalhista VALUES (123562845 ,'Gaspar Abreu');
INSERT INTO retalhista VALUES (123564845 ,'Bruna Cunha');
INSERT INTO retalhista VALUES (123562846 ,'Salomé Fernandes');
INSERT INTO retalhista VALUES (123562849 ,'Cristiano Carvalho');
INSERT INTO retalhista VALUES (123562847 ,'Inês Macedo');
INSERT INTO retalhista VALUES (123562841 ,'Diogo Guerreiro');
INSERT INTO retalhista VALUES (123562843 ,'Leonor Silva');
INSERT INTO retalhista VALUES (153562845 ,'Laura Andrade');
INSERT INTO retalhista VALUES (120562845 ,'Luna Miranda');
INSERT INTO retalhista VALUES (123560845 ,'Tatiana Matos');
INSERT INTO retalhista VALUES (123562840 ,'Miguel Salema');
INSERT INTO retalhista VALUES (123562888 ,'Mateus Lisboa');

INSERT INTO responsavel_por VALUES ('Concerto Jazz' , 123562845 , 0 , 'Labsa');
INSERT INTO responsavel_por VALUES ('Rock in Rio' , 123564845 , 1 , 'Demodia');
INSERT INTO responsavel_por VALUES ('Pastelaria Tradicional Portuguesa' , 123562846 , 2 , 'Pitho');
INSERT INTO responsavel_por VALUES ('Pastelaria Russa' , 123562849 , 3 , 'Hotan');
INSERT INTO responsavel_por VALUES ('Jogos de Tabuleiro' , 123562847 , 4 , 'CucaTest');
INSERT INTO responsavel_por VALUES ('Jogos de Cartas e Colecionaveis' , 123562841 , 5 , 'CookieLabs');
INSERT INTO responsavel_por VALUES ('Puzzles' , 123562843 , 6 , 'Eten');
INSERT INTO responsavel_por VALUES ('Jogos Educativos e Didáticos' , 153562845 , 7 , 'JazzFul');
INSERT INTO responsavel_por VALUES ('Comics' , 120562845 , 8 , 'Jubex');
INSERT INTO responsavel_por VALUES ('Graphic Novels' , 123560845 , 9 , 'Harumaki');
INSERT INTO responsavel_por VALUES ('Manga' , 123562840 , 10 , 'YorokobiNoKonpyUta');
INSERT INTO responsavel_por VALUES ('BD Franco-Belga' , 123562888 , 11 , 'Jojorata');
INSERT INTO responsavel_por VALUES ('Batatas Redondas Portuguesas' , 123562841 , 3 , 'Hotan');
INSERT INTO responsavel_por VALUES ('Batatas Redondas Espanholas' , 153562845 , 6 , 'Eten');
INSERT INTO responsavel_por VALUES ('Batatas Ovais Portuguesas' , 120562845 , 7 , 'JazzFul');
INSERT INTO responsavel_por VALUES ('Batatas Ovais Espanholas' , 153562845 , 3 , 'Hotan');

INSERT INTO evento_reposicao VALUES (6724720415006 , 0 , 0 , 'Labsa' , '2022-01-08 04:05:06' , 5 , 123562845);
INSERT INTO evento_reposicao VALUES (8696269363171 , 1 , 1 , 'Demodia' , '2022-04-08 14:05:36' , 6 , 123564845);
INSERT INTO evento_reposicao VALUES (4557627136203 , 2 , 2 , 'Pitho' , '2022-05-08 16:15:08' , 7 , 123562846);
INSERT INTO evento_reposicao VALUES (2710900779537 , 3 , 3 , 'Hotan' , '2022-06-03 20:05:06' , 8 , 123562849);
INSERT INTO evento_reposicao VALUES (3995024369208 , 4 , 4 , 'CucaTest' , '2022-07-08 20:45:16' , 9 , 123562847);
INSERT INTO evento_reposicao VALUES (9921300602214 , 5 , 5 , 'CookieLabs' , '2022-08-08 12:15:00' , 10 , 123562841);
INSERT INTO evento_reposicao VALUES (2757533699180 , 6 , 6 , 'Eten' , '2022-02-08 16:49:26' , 11 , 123562843);
INSERT INTO evento_reposicao VALUES (3654965036310 , 7 , 7 , 'JazzFul' , '2022-02-02 20:00:16' , 12 , 153562845);
INSERT INTO evento_reposicao VALUES (2796302894290 , 8 , 8 , 'Jubex' , '2022-03-08 10:05:16' , 13 , 120562845);
INSERT INTO evento_reposicao VALUES (6389373905722 , 9 , 9 , 'Harumaki' , '2022-07-08 14:45:16' , 14 , 123560845);
INSERT INTO evento_reposicao VALUES (1384349735413 , 10 , 10 , 'YorokobiNoKonpyUta' , '2022-04-08 20:35:16' , 15 , 123562840);
INSERT INTO evento_reposicao VALUES (1384349935513 , 11 , 11 , 'Jojorata' , '2022-07-08 13:45:16' , 16 , 123562888);
INSERT INTO evento_reposicao VALUES (8819012883703 , 12 , 12 , 'Harumaki' , '2021-07-08 11:45:16' , 11 , 123564845);
INSERT INTO evento_reposicao VALUES (5783688071158 , 13 , 13 , 'CookieLabs' , '2021-08-08 13:45:16' , 14 , 123562849);
INSERT INTO evento_reposicao VALUES (5649355897352 , 14 , 14 , 'Hotan' , '2022-01-08 22:35:17' , 11 , 123564845);
INSERT INTO evento_reposicao VALUES (6351441592787 , 15 , 15 , 'Harumaki' , '2022-12-12 22:45:17' , 11 , 120562845);
