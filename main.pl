%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Instrumento de avaliação em grupo

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Declaracoes iniciais

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% import de modulos auxiliares
:- use_module(library(date_time)).
:- use_module(library(lists)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Consulta de predicados que se encontram noutros ficheiros.
:- consult(view).
:- consult(base_de_conhecimento).
:- consult(invariantes).
:- consult(predicados_auxiliares).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Permitir a definição de fases de vacinação, definindo critérios de inclusão de utentes nas diferentes fases (e.g., doenças crónicas, idade, profissão);

fase(1,Id,date(2021,2,1)) :- idade(Id,I), I>=80.
faseLista(1,L,date(2021,2,1)) :- solucoes(Id,fase(1,Id,date(2021,2,1)),L).

fase(2,Id,date(2021,3,16)) :- utente(Id,_,_,_,_,_,_,_,DoencasCronicas,_,_), nao(vazia(DoencasCronicas)).
faseLista(2,L,date(2021,3,16)) :- solucoes(Id,fase(2,Id,date(2021,3,16)),L).

fase(3,Id,date(2021,4,29)) :- 
    utente(Id,_,_,_,_,_,_,Profissao,_,_,_),
    pertence(Profissao,['Médica','Médico','Enfermeira','Enfermeiro','Auxiliar de Saúde','Professora','Professor']).
faseLista(3,L,date(2021,4,29)) :- solucoes(Id,fase(3,Id,date(2021,4,29)),L).

fase(4,Id,date(2021,6,12)) :- utente(Id), nao(fase(1,Id,_)), nao(fase(2,Id,_)), nao(fase(3,Id,_)).
faseLista(4,L,date(2021,6,12)) :- solucoes(Id,fase(4,Id,date(2021,6,12)),L).

idade(Id,I) :- utente(Id,_,_,Data_Nasc,_,_,_,_,_,_,_), date(DataAtual), date_interval(DataAtual,Data_Nasc, I years).

vazia([]).

pertence(X,[X|L]).
pertence(X,[Y|L]) :- X\=Y, pertence(X,L).

verificaFase(F, Id, Data) :- fase(F, Id, Data), !.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas nao vacinadas
-vacinada(Id) :- utente(Id), nao(vacinacao_covid(_,Id)).

% extra
%-vacinada(Id) :- nao(vacinada(Id)), nao(excecao(vacinada(Id))).

% Identificar pessoas nao vacinadas numa certa toma
-vacinada(Id,1) :- utente(Id), nao(vacinacao_covid(_,Id,_,_,1)).
-vacinada(Id,2) :- utente(Id), nao(vacinacao_covid(_,Id,_,_,2)).

% extra

%-vacinada(Id,T) :- nao(vacinada(Id,T)), nao(excecao(vacinada(Id,T))).
naoVacinadas(S) :- solucoes(Id, -vacinada(Id), S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que identifica pessoas vacinadas

vacinada(Id) :- utente(Id), vacinacao_covid(_,Id).

% Extensão do predicado que identifica pessoas vacinadas numa certa toma 
vacinada(Id,2) :- utente(Id), vacinacao_covid(_,Id,_,_,2).
vacinada(Id,1) :- utente(Id), vacinacao_covid(_,Id,_,_,1).

vacinadas(S) :- solucoes(Id,vacinada(Id),S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que identifica pessoas vacinadas indevidamente

-vacinada_indevidamente(Id) :- nao(vacinada_indevidamente(Id)).
vacinada_indevidamente(Id) :- vacinacao_covid(_,Id,DataVac,_,1), verificaFase(_,Id,DataFase), date_compare(DataFase,>,DataVac).

vacinadas_indevidamente(S) :- solucoes(Id,vacinada_indevidamente(Id),S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que identifica pessoas não vacinadas e que são candidatas a vacinação

-candidata(Id) :- nao(candidata(Id)).
candidata(Id) :- utente(Id), nao(vacinada(Id)), date(DataAtual), verificaFase(_,Id,DataFase), date_compare(DataAtual,>=,DataFase).

candidatas(S) :- solucoes(Id,candidata(Id),S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão do predicado que identifica pessoas a quem falta a segunda toma da vacina

-segunda_toma(Id) :- nao(segunda_toma(Id)).
segunda_toma(Id) :- utente(Id), vacinada(Id,1), nao(vacinada(Id,2)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Desenvolver um sistema de inferência capaz de implementar os mecanismos de raciocínio inerentes a estes sistemas.

si(Questao,verdadeiro) :- Questao.
si(Questao,falso) :- -Questao.
si(Questao,desconhecido) :- nao(Questao), nao(-Questao).


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


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%---- Registos
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% utente
registarUtente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico) :-
    evolucao(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)).

% centro_saude
registarCentro(Id,Nome,Morada,Telefone,Email) :-
    evolucao(centro_saude(Id,Nome,Morada,Telefone,Email)).

% staff
registarStaff(Idstaff,Idcentro,Nome,Email) :-
    evolucao(staff(Idstaff,Idcentro,Nome,Email)).

% vacinacao_covid
registarVacinacao(Idstaff,Idutente,Data,Vacina,Toma) :-
    evolucao(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).

% medico_familia
registarMedico(IdMedico,Nome,Email,IdCentro):-
    evolucao(medico_familia(Idstaff,Nome,Email,IdCentro)).

%consulta
registarConsulta(IdConsulta,IdUtente,IdMedico,Descricao,Custo,Data):-
    evolucao(consulta(IdConsulta,IdUtente,IdMedico,Descricao,Custo,Data)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%---- Remoções
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% utente
removerUtente(Idutente) :-
    utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico),
    involucao(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)).

% centro_saude
removerCentro(Idcentro) :-
    centro_saude(Idcentro,Nome,Morada,Telefone,Email),
    involucao(centro_saude(Idcentro,Nome,Morada,Telefone,Email)).

% staff
removerStaff(Idstaff) :-
    staff(Idstaff,Idcentro,Nome,Email),
    involucao(staff(Idstaff,Idcentro,Nome,Email)).

% vacinacao_covid
removerVacinacao(Idstaff,Idutente,Data,Vacina,Toma) :-
    involucao(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).

% medico_familia
removerMedico(Idmedico) :-
    medico_familia(Idmedico,Nome,Email,IdCentro),
    involucao(medico_familia(Idmedico,Nome,Email,IdCentro)).

% consulta
removerConsulta(Idconsulta) :-
    consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data),
    involucao(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a evolucao do conhecimento

evolucao(Termo) :- solucoes(Invariante,+Termo::Invariante,Lista), insercao(Termo), teste(Lista).

insercao(Termo) :- assert(Termo).
insercao(Termo) :- retract(Termo),!,fail.

teste([]).
teste([R|LR]) :- R, teste(LR).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a involucao do conhecimento

involucao(Termo) :- solucoes(Invariante,-Termo::Invariante,Lista), remocao(Termo), teste(Lista).

remocao(Termo) :- retract(Termo).
remocao(Termo) :- assert(Termo),!,fail.


