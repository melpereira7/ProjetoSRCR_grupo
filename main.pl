%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Instrumento de avaliação em grupo

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Declaracoes iniciais

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).
:- set_prolog_flag(encoding,utf8).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% import de modulos auxiliares
:- use_module(library(date_time)).
:- use_module(library(lists)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definicoes iniciais

:- dynamic (-)/1.
:- dynamic utente/11.
:- dynamic centro_saude/5.
:- dynamic staff/4.
:- dynamic vacinacao_covid/5.
:- dynamic medico_familia/4.
:- dynamic consulta/6.
:- dynamic incerto/2.
:- dynamic interdito/1.
:- dynamic impreciso/1.
:- dynamic excecao/1.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Consulta de predicados que se encontram noutros ficheiros.
:- consult(view).
:- consult(base_de_conhecimento).
:- consult(evolucao).
:- consult(predicados_auxiliares).
:- consult(predicados_extra).
:- consult(conhecimento_imperfeito).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Permitir a definição de fases de vacinação, definindo critérios de inclusão de utentes nas diferentes fases (e.g., doenças crónicas, idade, profissão);

fase(1,Id,date(2021,2,1)) :- idade(Id,I), I>=80.

fase(2,Id,date(2021,3,16)) :- utente(Id,_,_,_,_,_,_,_,DoencasCronicas,_,_),
                              nao(vazia(DoencasCronicas)).

fase(3,Id,date(2021,4,29)) :- 
    utente(Id,_,_,_,_,_,_,Profissao,_,_,_),
    pertence(Profissao,['Médica','Médico','Enfermeira','Enfermeiro','Auxiliar de Saúde','Professora','Professor']).

fase(4,Id,date(2021,6,12)) :- utente(Id), nao(fase(1,Id,_)),
                              nao(fase(2,Id,_)), nao(fase(3,Id,_)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas nao vacinadas
-vacinada(Id) :- utente(Id), nao(vacinacao_covid(_,Id)).

% extra
%-vacinada(Id) :- nao(vacinada(Id)), nao(excecao(vacinada(Id))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que identifica pessoas vacinadas

vacinada(Id) :- utente(Id), vacinacao_covid(_,Id).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que identifica pessoas vacinadas indevidamente

-vacinada_indevidamente(Id) :- nao(vacinada_indevidamente(Id)), nao(excecao(vacinada_indevidamente(Id))).
vacinada_indevidamente(Id) :- vacinacao_covid(_,Id,DataVac,_,1), verificaFase(_,Id,DataFase), date_compare(DataFase,>,DataVac).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que identifica pessoas não vacinadas e que são candidatas a vacinação

-candidata(Id) :- nao(candidata(Id)), nao(excecao(candidata(Id))).
candidata(Id) :- utente(Id), nao(vacinada(Id)), date(DataAtual), verificaFase(_,Id,DataFase), date_compare(DataAtual,>=,DataFase).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão do predicado que identifica pessoas a quem falta a segunda toma da vacina

-segunda_toma(Id) :- nao(segunda_toma(Id)), nao(excecao(segunda_toma(Id))).
segunda_toma(Id) :- utente(Id), vacinada(Id,1), nao(vacinada(Id,2)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Desenvolver um sistema de inferência capaz de implementar os mecanismos de raciocínio inerentes a estes sistemas.

si(Questao,verdadeiro) :- Questao.
si(Questao,falso) :- -Questao.
si(Questao,desconhecido) :- nao(Questao), nao(-Questao).
