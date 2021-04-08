% Predicados auxiliares


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicados para simplificação
utente(ID) :- utente(ID,_,_,_,_,_,_,_,_,_,_).
utente(ID, Nome) :- utente(ID,_,Nome,_,_,_,_,_,_,_,_).
centro_saude(ID) :- centro_saude(ID,_,_,_,_).
staff(ID) :- staff(ID,_,_,_).
vacinacao_covid(Idstaff,Idutente) :- vacinacao_covid(Idstaff,Idutente,_,_,_).
medico_familia(Idmedico) :- medico_familia(Idmedico,_,_,_).
consulta(Idconsulta) :- consulta(Idconsulta,_,_,_,_,_).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Idade de um utente
idade(Id,I) :- utente(Id,_,_,Data_Nasc,_,_,_,_,_,_,_), date(DataAtual), date_interval(DataAtual,Data_Nasc, I years).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Diz se uma lista é vazia

vazia([]).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Diz se um elemento pertence a uma lista

pertence(X,[X|L]).
pertence(X,[Y|L]) :- X\=Y, pertence(X,L).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Verifica qual a fase em que um utente está incluído

verificaFase(F, Id, Data) :- fase(F, Id, Data), !.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado solucoes: X,Y,Z ->{V,F}
solucoes(X,Y,Z) :- findall(X,Y,Z).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado comprimento: S,N ->{V,F}
comprimento(S,N) :- length(S,N).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que imprime no ecrã os elementos de uma lista de uma forma especifica
print([E]) :- write('\t'), write(E), write('\n'). 
print([H|T]) :- write('\t'), write(H), write('\n'), print(T).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que dada uma lista de identificadores de utentes, dá o nome de cada um.
getNames([E], [Nome]):- utente(E, Nome). 
getNames([H|T], [Nome|R]):- utente(H, Nome), getNames(T,R).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}
nao(Questao) :- Questao, !, fail.
nao(Questao).