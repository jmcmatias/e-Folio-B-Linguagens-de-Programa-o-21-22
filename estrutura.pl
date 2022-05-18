:-[corpos_celestes].
:-[predicados].

:-dynamic corpo_celeste/5.

%Menu
main :-
    writeln("Menu"), nl,
    writeln('>> Escolha um comando, seguido de um ponto final:'),
    writeln('  1. Devolve resultado Yes/No que X orbita em torno de Y.(+X,+Y)'),
    writeln('  2. Devolve a lista com todos os planetas de uma estrela.(+X,-L)'),
    writeln('  3. Totalizar clientes por cidade'),
    writeln('  4. Lista de vendas'),
    writeln('  5. Stock do artigo'),
    writeln('  6. Verifica Quantidades de Stock minimo'),
    writeln('  7. Validar venda'),
    writeln('  8. Retifica inventario'),
    writeln('  9. Venda de artigo'),
    writeln(' 10. Inventario dos artigos'),
    writeln('  x. Sair'),
    read(Comando),
    opcao(Comando).

voltar_menu_principal:-
    writeln('Pressione qualquer tecla para voltar ao menu, ou x para sair'),
    read(T),
    T=x -> opcao(x);
    main.



opcao(x):-
    writeln('A sair...'),
    halt.

opcao(1):-
    write('Insira X '), read(X), write('Insira Y '), read(Y),nl,
    orbita(X,Y),
    voltar_menu_principal.

opcao(2):-
     writeln('Escolheu a opcao 1. Devolve resultado Yes/No que X orbita em torno de Y.(+X,+Y)'),
     write('Insira X '), read(X),
     listar_planeta(X,L),
     imprime_lista(L),
     voltar_menu_principal.
