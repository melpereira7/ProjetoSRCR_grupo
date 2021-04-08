% Predicados extra

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Declaracoes iniciais

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Lista de pessoas numa fase de vacinação

faseLista(1,L,date(2021,2,1)) :- solucoes(Id,fase(1,Id,date(2021,2,1)),L).

faseLista(2,L,date(2021,3,16)) :- solucoes(Id,fase(2,Id,date(2021,3,16)),L).

faseLista(3,L,date(2021,4,29)) :- solucoes(Id,fase(3,Id,date(2021,4,29)),L).

faseLista(4,L,date(2021,6,12)) :- solucoes(Id,fase(4,Id,date(2021,6,12)),L).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas nao vacinadas numa certa toma
-vacinada(Id,1) :- utente(Id), nao(vacinacao_covid(_,Id,_,_,1)).
-vacinada(Id,2) :- utente(Id), nao(vacinacao_covid(_,Id,_,_,2)).

% extra
%-vacinada(Id,T) :- nao(vacinada(Id,T)), nao(excecao(vacinada(Id,T))).

% Lista das pessoas não vacinadas
naoVacinadas(S) :- solucoes(Id, -vacinada(Id), S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas vacinadas numa certa toma 
vacinada(Id,2) :- utente(Id), vacinacao_covid(_,Id,_,_,2).
vacinada(Id,1) :- utente(Id), vacinacao_covid(_,Id,_,_,1).

% Lista das pessoas vacinadas
vacinadas(S) :- solucoes(Id,vacinada(Id),S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Lista das pessoas que foram vacinadas indevidamente

vacinadas_indevidamente(S) :- solucoes(Id,vacinada_indevidamente(Id),S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Lista das pessoas que não foram vacinadas e são candidatas a vacinação

candidatas(S) :- solucoes(Id,candidata(Id),S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Lista de pessoas a quem falta a segunda toma da vacina

lista_segunda_toma(S) :- solucoes(Id,segunda_toma(Id),S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Custo total de consultas por utente

custo_consultas(Idutente,Total) :- utente(Idutente), solucoes(Custo,consulta(_,Idutente,_,_,Custo,_),S), sum_list(S,Total).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Lista de centros de saude

centrosSaude(C) :- solucoes(Id-Centro,centro_saude(Id,Centro,_,_,_),S),
                                   sort(S,C).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%lista de utentes

utentes(C) :- solucoes(Utente,utente(_,_,Utente,_,_,_,_,_,_,_,_),S),
                                    sort(S,C).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Lista de staff
staffs(C) :- solucoes(Staff,staff(_,_,Staff,_),S),
                                    sort(S,C).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Lista de medicos

medicos(C) :- solucoes(Medico,medico_familia(_,Medico,_,_),S),
                                   sort(S,C).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Lista de médicos de um determinado centro de saúde

medicosPorCentro(IdC,C) :- centro_saude(IdC), solucoes(Nome,medico_familia(_,Nome,_,IdC),S),
                                    sort(S,C).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Lista de utentes de um determinado centro

utentesPorCentro(IdC,C) :- centro_saude(IdC), solucoes(Nome,utente(_,_,Nome,_,_,_,_,_,_,_,IdC),S),
                                    sort(S,C).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Lista de pessoas do staff de um determinado centro

staffPorCentro(IdC,C) :- centro_saude(IdC), solucoes(Nome,staff(_,IdC,Nome,_),S),
                                    sort(S,C).
