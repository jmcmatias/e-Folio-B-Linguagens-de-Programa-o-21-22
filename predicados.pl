%%%%%%%%%%%%%%%%%%%%%%
%funções auxilixares:
:-dynamic corpo_celeste/5.


%função para imprimir lista
imprime_lista([]).
imprime_lista(X):-
    forall(member(Y,X), (format('~w,',[Y]),nl)).

%função que cria uma lista com as estrelas e planetas
lista_estrelas_planetas(Lista) :-
    findall(
        Corpo,
        corpo_celeste(Corpo,estrela,_,_,_),
        Estrela),
    findall(Corpo,
        corpo_celeste(Corpo,planeta,_,_,_),
        Planeta),
    append(Estrela,Planeta,Lista).


%função que remove duplicados de uma lista
remove_duplicados([], []).
remove_duplicados([H | T], Lista) :-
    member(H, T), !,
    remove_duplicados(T, Lista).
remove_duplicados([H | T], [H | Lista]) :-
    remove_duplicados(T, Lista).

%calcula a media de uma lista
media_lista([],0).
media_lista(Lista,Avg) :-
    sum_list(Lista,Sum),
    length(Lista,Tamanho)-> Avg is Sum/Tamanho.


%função que pede o nome de um corpo celeste ao utilizador
pedir_nome(Corpo) :-
     writeln('Insira o nome do Corpo Celeste'),
     read(Corpo).

%cria uma lista a partir de um dado elemento de uma lista
lista_a_partir_de([H|T],N,Lista):-
    N=H,
    Lista=[H|T];
    %write(H),
    lista_a_partir_de(T,N,Lista).


%%%%%%%%%%%%%%%%%%%%%%%
%funções para impressão

% função para utilizar quando o utilizador insere um corpo celeste que
% não existe
imprime_inserido_n_existe :-
    writeln('O corpo celeste inserido não existe neste contexto').


% Verifica se um corpo celeste X, orbita um outro Y, devolve Yes se sim e no se não
orbita(X,Y) :-
    corpo_celeste(X,_,Y,_,_) ->
    write('Yes');
    write('No').

%lista com todos os planetas de uma estrela
listar_planeta(X,Lista) :-
    corpo_celeste(X,estrela,_,_,_) ->                   %se existir a estrela X
    findall(Y, corpo_celeste(Y,planeta,X,_,_), Lista).  %procura todos os planetas Y que orbitem X e coloca-os em Lista

%imprime a lista de todos os planetas que orbitam a estrela X
mostrar_lista_planeta(X):-
    listar_planeta(X,Lista),                                    %obtem a lista de planetas
    \+(Lista=[])->                                              %se a lista não estiver vazia
    format('Lista de todos os planetas da estrela ~w:',[X]),nl,
    imprime_lista(Lista);                                       %imprime a lista
    imprime_inserido_n_existe.                                  %senao diz que não existe no contexto

%devolve uma lista com todos os satelites de um planeta
listar_satelite(X,Lista) :-
    corpo_celeste(X,planeta,_,_,_) ->                   %se existir o planeta X
    findall(Y, corpo_celeste(Y,satelite,X,_,_), Lista). %procura todos os satelites Y que orbitem X e coloca-os em Lista

%mostra a lista de todos os satelites que orbitam um planeta X
mostrar_lista_satelite(X) :-
    listar_satelite(X,Lista),                                    %obtem a lista de satelites
    \+(Lista=[])->                                               %se a lista nao estiver vazia
    format('Lista de todos os satelites do planeta ~w:',[X]),nl,
    imprime_lista(Lista).                                        %imprime a lista

%lista com todos os planetas que tem satelites
listar_planetas_com_satelites(R) :-
    findall(                                     %procura corpos celestes
        Corpo,                                   %
        (corpo_celeste(Corpo,planeta,_,_,_),     %que sejam planetas
         corpo_celeste(_,satelite,Corpo,_,_)),   %e que tenham algum satelite a orbita-los
        Lista),                                  %coloca-os em Lista (Irão haver duplicados, pois há planetas com mais do que um satelite)
    remove_duplicados(Lista,R).                  %remove os duplicados da Lista


%mostra a lista de todos os planetas com satelites
mostrar_lista_planetas_com_satelites:-
    listar_planetas_com_satelites(Lista),                           %obtem a lista
    writeln('Lista de todos os planetas que têm satelites:'),
    imprime_lista(Lista).                                           %imprime a lista

%devolve Yes se um planeta X tem satelites ou No caso contrario
tem_satelite(X) :-
    findall(                                            %procura
        Corpo,                                          %corpos
        (corpo_celeste(Corpo,planeta,_,_,_),            %da categoria planeta
         corpo_celeste(_,satelite,Corpo,_,_)),          %que tenha satelites a orbita-lo e coloca-os em Lista
        Lista) -> (member(X,Lista) -> write('Yes'),nl;     %se existirem, e X for membro da Lista escreve Yes
                                      write('No'),nl       %senão escreve No
                  );
                  write('No'),nl.                          %se não existir lista, escreve No

%Devolve o maior planeta da tabela de corpos celestes
maior_planeta(X) :-
    findall(                                            %procura
        (Diametro),                                     %no Diametro
        corpo_celeste(_,planeta,_,Diametro,_),          %corpos celestes que sejam planetas
        Lista),                                         %e coloca-os em Lista
    max_list(Lista,Max),                                %devolve o valor máximo dessa Lista
    corpo_celeste(X,planeta,_,Max,_).                  %pergunta qual o planeta que tem Max de diametro

%mostra o maior planeta (diametro) da tabela
mostrar_maior_planeta:-
    maior_planeta(X),
    corpo_celeste(X,planeta,_,Max,_),
    format('O planeta com o maior diametro é ~w, com ~wkm.',[X,Max]),nl. %imprime


% Devolve o total de corpos celestes que orbitam em torno de um corpo
% celeste, indicado pelo utilizador
total_corpos_celeste :-
    pedir_nome(Corpo),                             %Pede ao utilizador o nome de um corpo celeste
    corpo_celeste(Corpo,_,_,_,_) ->                %se existir esse corpo
    findall(                                       %procura
        (Orbita),                                  %os corpos (Orbita) que orbitam o Corpo inserido
        corpo_celeste(Orbita,_,Corpo,_,_),         %e coloca-os em
        Lista),                                    %lista
    length(Lista,Total),                           %devolve o tamanho da lista (sendo o total de corpos pretendido)
    format('O total de corpos celestes que orbitam o corpo celeste ~w, é ~w ',[Corpo,Total]),nl; %imprime
    imprime_inserido_n_existe.                     %se não existir o corpo inserido, imprime messagem a informar

%Devolve a média dos diâmetros que orbitam em torno de um corpo celeste
media_diametro_satelites(Avg) :-
    pedir_nome(Corpo),                            %Pede ao utilizador o nome de um corpo celeste
    corpo_celeste(Corpo,_,_,_,_) ->               %se existir esse corpo
    findall(                                      %procura
        Diametro,                                 %o diametro
        corpo_celeste(_,_,Corpo,Diametro,_),      %de corpos que orbitem o Corpo inserido
        Lista),                                   %guarda em Lista
    imprime_lista(Lista),                         %imprime a lista
    media_lista(Lista,Avg),                       %calcula a media da lista
    format('A média dos diâmetros dos satelites que orbitam ~w, é ~2f km ',[Corpo,Avg]); %imprime os valores da lista com duas casas decimais
    imprime_inserido_n_existe.                    %se não existir o corpo inserido, imprime messagem a informar

%Devolve o ano de descoberta do corpo celeste indicado pelo utilizador
ano_descoberta_corpo :-
    pedir_nome(Corpo),                                 %Pede ao utilizador o nome de um corpo celeste
    corpo_celeste(Corpo,_,_,_,X)->                     %se existir esse corpo, obtem o Ano de descoberta para X
    format('O ano em que ~w foi descoberto foi em ~w',[Corpo,X]);  %imprime
    imprime_inserido_n_existe.                         %se não existir o corpo inserido, imprime messagem a informar



% Recebe uma lista de elementos, e verifica quais os elementos que
% têm satelites, colocando-os seguidamente a esse elemento
insere_lista_satelites([],L,L):-!.                           %caso lista vazia
insere_lista_satelites([H|T],L,Lhie):-
    listar_satelite(H,Lsat)->                                %se existir Lsat
    insere_lista_satelites(T,[L,H|Lsat],Lhie);               %guarda a cabeça(corpo H) e a lista de satelites
    insere_lista_satelites(T,[L,H],Lhie).                    %senão guarda apenas a cabeça

%Cria Lista hierarquica dos corpos celestes a partir de um corpo dado.
lista_hierarquica_corpos(X,L) :-
    lista_estrelas_planetas(Lep),                 %pede lista de estrelas e planetas existentes
    lista_a_partir_de(Lep,X,Lae),                 %pede lista de estrelas e planetas a partir do corpo X
    insere_lista_satelites(Lae,[],R),             %insere na lista resultante as listas de satelites dos corpos
    flatten(R,L).                                 %como recebe uma lista de listas, ao fazer o flatten fica uma lista de elementos

%mostra a lista hierarquica de corpos
mostrar_lista_hierarquica_corpos:-
    pedir_nome(X),
    lista_hierarquica_corpos(X,L),
    imprime_lista(L).

%Altera o ano da descoberta de um corpo.
alterar_ano_descoberta_corpo:-
    pedir_nome(Corpo),
    writeln('Insira o ano de descoberta do Corpo Inserido'),
    read(Ano),
    corpo_celeste(Corpo,X,Y,Z,Ano)->                   %caso exista um corpo celeste com o nome e ano inseridos
    writeln('Insira o novo ano de descoberta'),        %pede o novo Ano
    read(Novoano),                                     %lê o novo ano
    (integer(Novoano) -> asserta(corpo_celeste(Corpo,X,Y,Z,Novoano)),  %Se o ano é um inteiro cria uma clausula nova identica a anterior no topo, mas com o novo ano
                         retract(corpo_celeste(Corpo,X,Y,Z,Ano)),      %Apaga a clausula com o valor do ano anterior
                         nl,writeln('Valor alterado'),nl;              %informa que o valor foi alterado
                         format('O valor introduzido não é um ano'));  %se não for inteiro informa
    nl,
    imprime_inserido_n_existe,                                         %se não houver corpo celeste com o Corpo e Ano
    writeln('ou o ano de descoberta inserido está errado').            %informa que ou um ou outro input está errado.

