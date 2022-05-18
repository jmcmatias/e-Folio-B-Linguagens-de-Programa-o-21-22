:-[corpos_celestes].
:-[predicados].

:-dynamic corpo_celeste/5.

%Menu
main :-
    writeln('---------------------------------------------------------------------------------'),
    writeln(' |##############################      Menu       ##############################|'),
    writeln(' |#                                                                           #|'),
    writeln(' |#  0- Mostra a Lista com a base de conhecimento corpos_celestes             #|'),
    writeln(' |#  1- Devolve resultado Yes/No que X orbita em torno de Y.(+X,+Y)           #|'),
    writeln(' |#  2- Devolve a lista com todos os planetas de uma estrela X.(+X,-L)        #|'),
    writeln(' |#  3- Devolve a lista com todos os satelites de um planeta X.(+X,-L)        #|'),
    writeln(' |#  4- Devolve a lista com todos os planetas que têm satelites               #|'),
    writeln(' |#  5- Devolve resultado Yes/No que um planeta tem algum satelite            #|'),
    writeln(' |#  6- Devolve o maior planeta (diâmetro) da tabela de corpos celestes       #|'),
    writeln(' |#  7- Devolve o total de corpos celestes que orbitam em torno de um         #|'),
    writeln(' |#     corpo celeste (ex. sol,terra,jupiter) indicado pelo utilizador        #|'),
    writeln(' |#  8- Devolve a média dos diâmetros dos satelites que orbitam um            #|'),
    writeln(' |#     planeta indicado pelo utilizador                                      #|'),
    writeln(' |#  9- Devolve o ano de descoberta do corpo celeste indicado pelo utilizador #|'),
    writeln(' |# 10- Devolve a lista com todos os corpos celestes existentes               #|'),
    writeln(' |#     hierarquicamente a partir de um corpo indicado (+X,-L)                #|'),
    writeln(' |# 11- Altera a data de descoberta de um corpo indicado pelo utilizador      #|'),
    writeln(' |#                                                                           #|'),
    writeln(' |#                                                                           #|'),
    writeln(' |#  x. Sair                                                                  #|'),
    writeln(' |#                                                                           #|'),
    writeln(' |##############################      Menu       ##############################|'),
    writeln(' |     INSIRA UMA OPÇÃO SEGUIDO DE UM PONTO FINAL (exemplo: 0.) E ENTER:       |'),
    writeln(' |      TODOS AS ENTRADAS INSERIDAS PELO UTILIZADOR NESTE PROGRAMA TÊM         |'),
    writeln(' |            QUE TER UM PONTO FINAL TAL COMO NO EXEMPLO ACIMA                 |'),
    writeln('---------------------------------------------------------------------------------'),

    read(X),
    opcao(X).

voltar_menu_principal:-
    nl,nl,writeln('Digite "x." para sair ou qualquer tecla para voltar ao menu.'),
    read(T),
    T=x -> opcao(x);
    main.


opcao(x):-
    writeln('A sair...'),
    halt.

opcao(0):-
    writeln('Escolheu a opcao 0- Mostra a Lista com a base de conhecimento corpos_celestes '),nl,
    findall((Corpo,Cat,Orb,Dia,Ano),corpo_celeste(Corpo,Cat,Orb,Dia,Ano),Lista),
    writeln('Corpo,Categoria,Orbita_sobre,Diametro_km,Ano_descoberta'),
    imprime_lista(Lista),nl,
    voltar_menu_principal.

opcao(1):-
    writeln('Escolheu a opcao 1- Devolve resultado Yes/No que X orbita em torno de Y.(+X,+Y)'),nl,
    write('Insira X '), read(X), write('Insira Y '), read(Y),nl,
    orbita(X,Y),nl,
    voltar_menu_principal.

opcao(2):-
    writeln('Escolheu a opção 2- Devolve a lista com todos os planetas de uma estrela X.(+X,-L)'),nl,
    write('Insira X '), read(X),
    mostrar_lista_planeta(X),nl,
    voltar_menu_principal.

opcao(3):-
    writeln('Escolheu a opção 3- Devolve a lista com todos os satelites de um planeta X.(+X,-L)'),nl,
    write('Insira X '), read(X),
    mostrar_lista_satelite(X),nl,
    voltar_menu_principal.

opcao(4):-
    writeln('Escolheu a opção  4- Devolve a lista com todos os planetas que têm satelites'),nl,
    mostrar_lista_planetas_com_satelites,nl,
    voltar_menu_principal.

opcao(5):-
    writeln('Escolheu a opção  5- Devolve resultado Yes/No que um planeta X tem algum satelite'),nl,
    pedir_nome(X),
    tem_satelite(X),nl,
    voltar_menu_principal.

opcao(6):-
    writeln('Escolheu a opção  6- Devolve o maior planeta (diâmetro) da tabela de corpos celestes'),nl,
    mostrar_maior_planeta,nl,
    voltar_menu_principal.

opcao(7):-
    writeln('Escolheu a opção  7- Devolve o total de corpos celestes que orbitam em torno de um '),nl,
    writeln('                     corpo celeste (ex. sol,terra,jupiter) indicado pelo utilizador'),
    total_corpos_celeste,nl,
    voltar_menu_principal.

opcao(8):-
    writeln('Escolheu a opção  8- Devolve a média dos diâmetros dos satelites que orbitam um      '),
    writeln('                     planeta indicado pelo utilizador                                '),nl,
    media_diametro_satelites(_),nl,
    voltar_menu_principal.

opcao(9):-
    writeln('Escolheu a opção  9- Devolve o ano de descoberta do corpo celeste indicado pelo utilizador'),nl,
    ano_descoberta_corpo,nl,
    voltar_menu_principal.

opcao(10):-
    writeln('Escolheu a opção 10- Devolve a lista com todos os corpos celestes existentes  '),
    writeln('                     hierarquicamente a partir de um corpo indicado (+X,-L)   '),
    mostrar_lista_hierarquica_corpos,nl,
    voltar_menu_principal.

opcao(11):-
    writeln('Escolheu a opção 11- Altera a data de descoberta de um corpo indicado pelo utilizador '),
    alterar_ano_descoberta_corpo,nl,
    voltar_menu_principal.

