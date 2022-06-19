from enum import Enum

messages =  [
            'INSERT INTO categoria VALUES','INSERT INTO categoria_simples VALUES',
            'INSERT INTO super_categoria VALUES','INSERT INTO tem_outra VALUES',
            'INSERT INTO produto VALUES','INSERT INTO tem_categoria VALUES',
            'INSERT INTO IVM VALUES','INSERT INTO ponto_de_retalho VALUES',
            'INSERT INTO instalada_em VALUES','INSERT INTO prateleira VALUES',
            'INSERT INTO planograma VALUES','INSERT INTO retalhista VALUES',
            'INSERT INTO responsavel_por VALUES','INSERT INTO evento_reposicao VALUES'
            ]


data_categoria = [ 
                    'Bilheteria de Concertos','Concerto Jazz', 'Rock in Rio',
                    'Pastelaria', 'Pastelaria Tradicional Portuguesa', 'Pastelaria Russa',
                    'Jogos','Jogos de Tabuleiro','Jogos de Cartas e Colecionaveis','Puzzles','Jogos Educativos e Didáticos',
                    'BD E MANGA','Comics','Graphic Novels','Manga','BD Franco-Belga'
                 ]


data_super_categoria = ['Bilheteria de Concertos','Pastelaria','Jogos','BD E MANGA']


data_categoria_simples = [
                            'Concerto Jazz','Rock in Rio','Pastelaria Tradicional Portuguesa', 'Pastelaria Russa',
                            'Jogos de Tabuleiro','Jogos de Cartas e Colecionaveis','Puzzles','Jogos Educativos e Didáticos',
                            'Comics','Graphic Novels','Manga','BD Franco-Belga'
                         ]


data_tem_outra = {
                    'Bilheteria de Concertos': ['Concerto Jazz','Rock in Rio'],
                    'Pastelaria':['Pastelaria Tradicional Portuguesa', 'Pastelaria Russa'],
                    'Jogos': ['Jogos de Tabuleiro','Jogos de Cartas e Colecionaveis','Puzzles','Jogos Educativos e Didáticos'],
                    'BD E MANGA':['Comics','Graphic Novels','Manga','BD Franco-Belga']
                 }


data_produto = [
                [6724720415006,'Concerto Jazz','Yosemite Jazz Train'],
                [3066878977973,'Concerto Jazz','Blue Note Napa'],
                [7459992703439,'Concerto Jazz','Lake Arbor Jazz Festival'],
                [8696269363171,'Rock in Rio','Rock in Rio 2022 day 1'],
                [4557627136203,'Pastelaria Tradicional Portuguesa','Bolo das Alhadas'],
                [9942465294964,'Pastelaria Tradicional Portuguesa','Cascoréis da Guarda'],
                [2710900779537,'Pastelaria Russa','Tchak-Tchak'],
                [3995024369208,'Jogos de Tabuleiro','D&D Fantasy Roleplaying Game Essentials Kit'],
                [9636288660814,'Jogos de Tabuleiro','Mazescape Labyrinthos'],
                [9921300602214,'Jogos de Cartas e Colecionaveis','Pokémon! Sword & Shield Evolving Skies Sleeved Booster Pack'],
                [1318457603402,'Jogos de Cartas e Colecionaveis','Pokémon S&S 7 Evolving Skies 3 Pack Blister'],
                [2757533699180,'Puzzles','Puzzle Mordillo Impossible'],
                [1466521538768,'Puzzles','Puzzle Stranger Things Impossible!'],
                [3654965036310,'Jogos Educativos e Didáticos','Logic Farm'] ,
                [4663585483537,'Jogos Educativos e Didáticos','Guess The Flag Africa'] ,
                [1544636251593,'Comics','Moon Knight - Book 1: Omnibus'],
                [2796302894290,'Comics','Deadpool - Preto, Branco & Sangue'],
                [8609107719766,'Graphic Novels','Stranger Things – Acampamento de Ciências'],
                [6389373905722,'Graphic Novels','Economix'],
                [1384349735413,'Manga','SPY X FAMILY - VOL 1'],
                [1384349735513,'Manga','SPY X FAMILY - VOL 2'],
                [1384349935513,'BD Franco-Belga','Asterix Il Alcaforron'],
                [1384349765513,'BD Franco-Belga','Asterix I Alcaforron']
               ]

data_produto_simplified = [
                            [6724720415006,'Concerto Jazz','Yosemite Jazz Train'],
                            [8696269363171,'Rock in Rio','Rock in Rio 2022 day 1'],
                            [4557627136203,'Pastelaria Tradicional Portuguesa','Bolo das Alhadas'],
                            [2710900779537,'Pastelaria Russa','Tchak-Tchak'],
                            [3995024369208,'Jogos de Tabuleiro','D&D Fantasy Roleplaying Game Essentials Kit'],
                            [9921300602214,'Jogos de Cartas e Colecionaveis','Pokémon! Sword & Shield Evolving Skies Sleeved Booster Pack'],
                            [2757533699180,'Puzzles','Puzzle Mordillo Impossible'],
                            [3654965036310,'Jogos Educativos e Didáticos','Logic Farm'] ,
                            [2796302894290,'Comics','Deadpool - Preto, Branco & Sangue'],
                            [6389373905722,'Graphic Novels','Economix'],
                            [1384349735413,'Manga','SPY X FAMILY - VOL 1'],
                            [1384349935513,'BD Franco-Belga','Asterix Il Alcaforron'],
                          ]


data_ivm = [
            [0,'Labsa'],[1,'Demodia'],[2,'Pitho'],[3,'Hotan'],[4,'CucaTest'],
            [5,'CookieLabs'],[6,'Eten'],[7,'JazzFul'],[8,'Jubex'],[9,'Harumaki'],
            [10,'YorokobiNoKonpyUta'], [11,'Jojorata']
           ]

data_ponto_de_retalho = [
                         ['Terena','Evora,','Alandroal'],
                         ['Capelins','Evora,','Alandroal'],
                         ['Amareleja','Beja','Moura'],
                         ['Argela','Viana do Castelo','Caminha'],
                         ['Vile','Viana do Castelo','Caminha'],
                         ['Vale da Mula','Guarda','Almeida'],
                         ['Fazendas de Almeirim','Santarém','Almeirim'],
                         ['Benfica do Ribatejo','Santarém','Almeirim'],
                         ['Pombalinho','Santárem','Golega'],
                         ['Azinhaga','Santárem','Golega'],
                         ['Lavos','Coimbra','Figueira da Foz,'],
                         ['Marinha das Ondas','Coimbra','Figueira da Foz,']
                        ]
data_prateleira_number = [el for el in range(12)]
data_prateleira_altura = [el for el in range(10,34,2)]
data_planograma = [[el + 2 ,el + 5,'weowewdw'+str(el)] for el in range(12)]
data_retalhista = [ 
                    [123562845,'Gaspar Abreu'],[123564845,'Bruna Cunha'], [123562846,'Salomé Fernandes'],  [123562849,'Cristiano Carvalho'],
                    [123562847,'Inês Macedo'],[123562841,'Diogo Guerreiro'],[123562843,'Leonor Silva'],[153562845,'Laura Andrade'],  
                    [120562845,'Luna Miranda'],[123560845,'Tatiana Matos'],[123562840,'Miguel Salema'],[123562888,'Mateus Lisboa']
                  ] 

data_timestamps = [
                    '2022-01-08 04:05:06','2022-04-08 14:05:36','2022-05-08 16:15:08','2022-06-03 20:05:06','2022-07-08 20:45:16',
                    '2022-08-08 12:15:00','2022-02-08 16:49:26','2022-02-02 20:00:16','2022-03-08 10:05:16','2022-07-08 14:45:16',
                    '2022-04-08 20:35:16','2022-07-08 13:45:16'
                   ]

class relation_name(Enum):
    categoria = 0
    categoria_simples = 1
    super_categoria = 2
    tem_outra = 3
    produto = 4
    tem_categoria = 5
    IVM = 6
    ponto_de_retalho = 7
    instalada_em = 8
    prateleira = 9
    planograma = 10
    retalhista = 11
    responsavel_por = 12
    evento_reposicao = 13


def categoria(f):
    add_empty_line(f,1)
    message = messages[relation_name.categoria.value]
    for categoria in data_categoria:
        f.write(message + " ('" + str(categoria) + "')\n")


def categoria_simples(f):
    add_empty_line(f,1)
    message = messages[relation_name.categoria_simples.value]
    for categoria_simples in data_categoria_simples:
        f.write(message + " ('" + str(categoria_simples) + "')\n")
    

def super_categoria(f):
    add_empty_line(f,1)
    message = messages[relation_name.super_categoria.value]
    for super_categoria in data_super_categoria:
        f.write(message + " ('" + str(super_categoria) + "')\n")


def tem_outra(f):
    add_empty_line(f,1)
    message = messages[relation_name.tem_outra.value]
    for super_categoria in data_tem_outra:
        for categoria in data_tem_outra[super_categoria]:
            f.write(message + " ('" + str(super_categoria) + '\' , \'' \ 
            +  str(categoria)  + "')\n")


def produto(f):
    add_empty_line(f,1)
    message = messages[relation_name.produto.value]
    for produto in data_produto:
           f.write(message + " (" + str(produto[0]) + ' , \'' +  str(produto[1])  +   '\' , \'' \ 
           + str(produto[2]) + "')\n")


def tem_categoria(f):
    add_empty_line(f,1)
    message = messages[relation_name.tem_categoria.value]
    for produto in data_produto:
        f.write(message + " (" + str(produto[0]) + ' , \'' +  str(produto[1])  + "')\n")
        

def ivm(f):
    add_empty_line(f,1)
    message = messages[relation_name.IVM.value]
    for ivm in data_ivm:
        f.write(message + " (" + str(ivm[0]) + ' , \'' +  str(ivm[1])  + "')\n")
        

def ponto_de_retalho(f):
    add_empty_line(f,1)    
    message = messages[relation_name.ponto_de_retalho.value]
    for local in data_ponto_de_retalho:
         f.write(message + " ('" + str(local[0]) + '\' , \'' +  str(local[1])  +   '\' , \''\
          + str(local[2]) + "')\n")

        
def instalada_em(f):
    add_empty_line(f,1)
    message = messages[relation_name.instalada_em.value]
    for info in range(12):
        f.write(message + " (" + str(data_ivm[info][0]) + ' , \'' +  str(data_ivm[info][1]) +   '\' , \''\
         + str(data_ponto_de_retalho[info][0]) + "')\n")


def prateleira(f):
    add_empty_line(f,1)
    message = messages[relation_name.prateleira.value]
    for num in data_prateleira_number:
        f.write(message + " (" + str(num) + ' , ' +  str(data_ivm[num][0]) +   ' , \'' + str(data_ivm[num][1]) + '\' , ' \
        + str(data_prateleira_altura[num]) +  ' , \'' + str(data_categoria_simples[num]) + "')\n")


def planograma(f):
    add_empty_line(f,1)
    message = messages[relation_name.planograma.value]
    for num in range(12):
        f.write(message + " (" + str(data_produto_simplified[num][0]) + ' , ' +  str(num) +   ' , \'' \
        + str(data_produto_simplified[num][1]) + '\' , \'' \
        + str(data_ivm[num][1]) +  '\' , ' + str(data_planograma[num][0]) + ' , ' + str(data_planograma[num][1]) \
        + ' ,\'' + str(data_planograma[num][2]) + "')\n")
   

def retalhista(f):
    add_empty_line(f,1)
    message = messages[relation_name.retalhista.value]
    for retalhista in data_retalhista:
        f.write(message + " (" + str(retalhista[0]) + ' ,\'' + str(retalhista[1]) + "')\n")


def responsavel_por(f):
    add_empty_line(f,1)
    message = messages[relation_name.responsavel_por.value]
    for info in range(12):
        f.write(message + " ('" + str(data_categoria_simples[info]) + '\' , ' +  str(data_retalhista[info][0]) \
         +   ' , ' +  str(data_ivm[info][0]) + ' , \''  \
        +  str(data_ivm[info][1]) + "')\n")


def evento_reposicao(f):
    add_empty_line(f,1)
    message = messages[relation_name.evento_reposicao.value]
    for info in range(12):
         f.write(message + " (" + str(data_produto_simplified[info][0]) + ' , ' +  str(info) +   ' , \'' \
         + str(data_produto_simplified[info][1]) + '\' , \'' \ 
         + str(data_ivm[info][1]) +  '\' , \'' + str(data_timestamps[info]) + '\' , ' \
         + str(data_planograma[info][1]) + ' , ' + str(data_retalhista[info][0])  + ")\n")

def add_empty_line(f,mode):
    if mode == 1:
        f.write("\n")
    else:
        for el in range(mode + 1):
            f.write("\n")


def main():
    f = open("populate.sql", "w+")
    categoria(f)
    categoria_simples(f)
    super_categoria(f)
    tem_outra(f)
    produto(f)
    tem_categoria(f)
    ivm(f)
    ponto_de_retalho(f)
    instalada_em(f)
    prateleira(f)
    planograma(f)
    retalhista(f)
    responsavel_por(f)
    evento_reposicao(f)
    f.close()

if __name__ == "__main__":
    main()