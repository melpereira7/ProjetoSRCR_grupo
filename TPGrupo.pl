%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Instrumento de avaliação em grupo


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Declaracoes iniciais

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).

:- use_module(library(date)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definicoes iniciais

:- op(900,xfy,'::').
:- dynamic utente/9.
:- dynamic centro_saude/5.
:- dynamic staff/4.
:- dynamic vacinacao_covid/5.

:- dynamic vacinada/3.
:- dynamic segunda_toma/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%utente: #Idutente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde ↝ { 𝕍, 𝔽}
%centro_saude: #Idcentro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}
%staff: #Idstaff, #Idcentro, Nome, email ↝ { 𝕍, 𝔽 }
%vacinacao_covid: #Staf, #utente, Data, Vacina, Toma↝ { 𝕍, 𝔽 }

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de conhecimento (com exemplos arbitrários)

utente(1,211111111,'Ana Murciellago',(1,1,1930),'ana@gmail.com','Braga','Médica',[],1).
utente(2, 221111111,'Maria do Olival',(5,11,2001), 'maria@gmail.com', 'Viana do Castelo', 'Professora', [asma], 1).
utente(3,01234567890,'Igor Marcos',(20,8,1989),'marcos.mendes@gmail.com',252252252,'R. Amaral 8499-852 São Mamede de Infesta','Agricultor', [hiv,hepatite], 3).
utente(4,11111111111,'Rebeca Tavares marques',(10,8,2009),'maia.lara@gmail.com', 930643063, 'Avenida St. Valentim Fonseca, nº 3, 94º Dir. 9794-701 Quarteira', 'Estudante', [tuberculose] , 2).
utente(5,09876543210,'Yasmin Sara Leite de Borges',(19,4,1989),'dinis91@pereira.info',236082002, 'Avenida Leonardo Rodrigues, nº 2 3819-133 Aveiro','CEO Empresa de Marketing', [brucellosis,'gripe canina'],4).
utente(6,66666666666,'José Aristoteles',(17,10,1987),'exprimeiro@gov.pt',090909090,'Alameda','Engenheiro',[],1).
%yasmin n foi vacinada

centro_saude(1,'USFVida+','Vila Verde',253123456,'usfvida+@gmail.com').
centro_saude(2,'UCSP Quarteira','Quarteira',244322111,'ucspquart@info.gmailcom').
centro_saude(3,'USF infesta','São Mamede Infesta', 254254252,'centrosaude@gmail.com').
centro_saude(4,'USF MOLICEIRO', 'Aveiro', 2512522523, 'aveirocsaude@gmail.com').

staff(1,1,'Marria Silva','maria@gmail.com').
staff(2,1,'Joana Guerra','joana@gmail.com').
staff(3,1,'Miguel Santos', 'santosmiguel@gmail.com').
staff(4,2,'Mario Sergio', 'sergiomario@gmail.com').
staff(5,2,'Ricardo Salgado','salgadoricardo@bancoes.com').
staff(6,3,'Joana Vasconcelos', 'arte@gmail.com').
staff(7,4,'Pedro Granger', 'apresentador@rtp.pt').

vacinacao_covid(1,1,(1,1,2021),'Pfizer',1).
vacinacao_covid(2,1,(1,1,2021),'Pfizer',2).
vacinacao_covid(1,2,(1,1,2021),'Pfizer',1).
vacinacao_covid(6,3,(10,3,2021),'AstraZeneca',1).
vacinacao_covid(4,4,(11,3,2021),'Pfizer',1).
vacinacao_covid(5,4,(26,3,2021),'Pfizer',2).
vacinacao_covid(6,3,(10,6,2021),'AstraZeneca',2).
vacinacao_covid(7,6,(5,2,2021),'AstraZeneca',2).


%-----------------------------------------------------------------------
%permitir a definição de fases de vacinação, definindo critérios de inclusão de utentes nas
%diferentes fases (e.g., doenças crónicas, idade, profissão);



%fase(1,P,L) :- X == 1, idade(P,I), I>80.


idade(P,I) :- utente(_,_,P,(_,_,A),_,_,_,_,_), date(date(Y,_,_)), I is Y-A.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas nao vacinadas

-vacinada(P) :- nao(vacinada(P)), nao(excecao(vacinada(P))).

% Identificar pessoas nao vacinadas numa certa toma
-vacinada(P,T) :- nao(vacinada(P,T)), nao(excecao(vacinada(P,T))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas vacinadas

vacinada(P) :- utente(Id,_,P,_,_,_,_,_,_), vacinacao_covid(_,Id,_,_,_).

% Identificar pessoas vacinadas e qual a toma 
vacinada(P,T) :- utente(Id,_,P,_,_,_,_,_,_), vacinacao_covid(_,Id,_,_,T).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas a quem falta a segunda toma da vacina

segunda_toma(P) :- utente(Id,_,P,_,_,_,_,_,_), vacinada(P,1), nao(vacinada(P,2)).




%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% exemplos que criei só para testes

excecao(vacinada('Maria do Olival')).

+utente(Id,NISS,Nome,D,E,M,P,DC,IdC) :: (solucoes(Id,utente(Id,NISS,Nome,D,E,M,P,DC,IdC),S),
                                      comprimento(S,N),
                                      N==1).

-utente(Id,NISS,Nome,D,E,M,P,DC,IdC) :: (solucoes(Id,(utente(Id,NISS,Nome,D,E,M,P,DC,IdC), vacinada(Nome,1)),S),
                                      comprimento(S,N),
                                      N==1).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a evolucao do conhecimento

evolucao(Termo) :- solucoes(Invariante,+Termo::Invariante,Lista), insercao(Termo), teste(Lista).

insercao(Termo) :- assert(Termo).
insercao(Termo) :- retract(Termo),!,fail.

teste([]).
teste([R|LR]) :- R, teste(LR).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a involucao do conhecimento

involucao(Termo) :- solucoes(Invariante,-Termo::Invariante,Lista), remocao( Termo ), teste( Lista ).

remocao(Termo) :- retract(Termo).
remocao(Termo) :- assert(Termo),!,fail.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}
%                            Resposta = { verdadeiro,falso,desconhecido }

demo(Questao,verdadeiro) :- Questao.
demo(Questao,falso) :- -Questao.
demo(Questao,desconhecido) :- nao(Questao), nao(-Questao).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao(Questao) :- Questao, !, fail.
nao(Questao).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes(X,Y,Z) :- findall(X,Y,Z).

comprimento(S,N) :- length(S,N).