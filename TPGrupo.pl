%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Instrumento de avaliação em grupo


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Declaracoes iniciais

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).

:- use_module(library(date_time)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definicoes iniciais

:- op(900,xfy,'::').
:- dynamic utente/10.
:- dynamic centro_saude/5.
:- dynamic staff/4.
:- dynamic vacinacao_covid/5.

:- dynamic vacinada/3.
:- dynamic segunda_toma/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%utente: #Idutente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde ↝ { 𝕍, 𝔽}
%utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,[DoencasCronicas],Idcentro).
%centro_saude: #Idcentro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}
%centro_saude(Id,Nome,Morada,Telefone,Email).
%staff: #Idstaff, #Idcentro, Nome, email ↝ { 𝕍, 𝔽 }
%staff(Idstaff,Idcentro,Nome,Email).
%vacinacao_covid: #staff, #utente, Data, Vacina, Toma↝ { 𝕍, 𝔽 }
%vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de conhecimento (com exemplos arbitrários)

utente(1,211111111,'Ana Murciellago',date(1930,1,1),'ana@gmail.com',911234567,'Braga','Médica',[],1).
utente(2,221111111,'Maria do Olival',date(2001,11,5), 'maria@gmail.com',936484263 ,'Viana do Castelo', 'Professora', [asma], 1).
utente(3,01234567890,'Igor Marcos',date(1989,8,20),'marcos.mendes@gmail.com',252252252,'R. Amaral 8499-852 São Mamede de Infesta','Agricultor', [hiv,hepatite], 3).
utente(4,11111111111,'Rebeca Tavares Marques',date(2009,8,10),'maia.lara@gmail.com', 930643063, 'Avenida St. Valentim Fonseca, nº 3, 94º Dir. 9794-701 Quarteira', 'Estudante', [tuberculose] , 2).
utente(5,09876543210,'Yasmin Sara Leite de Borges',date(1989,4,19),'dinis91@pereira.info',236082002, 'Avenida Leonardo Rodrigues, nº 2 3819-133 Aveiro','CEO Empresa de Marketing', [brucellosis,'gripe canina'],4).
utente(6,66666666666,'José Aristoteles',date(1987,10,17),'exprimeiro@gov.pt',090909090,'Alameda','Engenheiro',[],1).

centro_saude(1,'USFVida+','Vila Verde',253123456,'usfvida+@gmail.com').
centro_saude(2,'UCSP Quarteira','Quarteira',244322111,'ucspquart@info.gmailcom').
centro_saude(3,'USF infesta','São Mamede Infesta', 254254252,'centrosaude@gmail.com').
centro_saude(4,'USF MOLICEIRO', 'Aveiro', 2512522523, 'aveirocsaude@gmail.com').

staff(1,1,'Maria Silva','maria@gmail.com').
staff(2,1,'Joana Guerra','joana@gmail.com').
staff(3,1,'Miguel Santos', 'santosmiguel@gmail.com').
staff(4,2,'Mario Sergio', 'sergiomario@gmail.com').
staff(5,2,'Ricardo Salgado','salgadoricardo@bancoes.com').
staff(6,3,'Joana Vasconcelos', 'arte@gmail.com').
staff(7,4,'Pedro Granger', 'apresentador@rtp.pt').

vacinacao_covid(1,1,date(2021,2,1),'Pfizer',1).
vacinacao_covid(2,1,date(2021,2,16),'Pfizer',2).
vacinacao_covid(1,2,date(2021,2,28),'Pfizer',1).                %vacinada indevidamente e falta segunda toma
vacinacao_covid(6,3,date(2021,3,20),'AstraZeneca',1).
vacinacao_covid(4,4,date(2021,3,17),'Pfizer',1).
vacinacao_covid(5,4,date(2021,4,1),'Pfizer',2).
vacinacao_covid(6,3,date(2021,4,10),'AstraZeneca',2).
vacinacao_covid(7,6,date(2021,2,5),'AstraZeneca',1).            %vacinada indevidamente


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicados para simplificar a verificação da existência de um certo utente, centro, staff ou vacinação

utente(ID) :- utente(ID,_,_,_,_,_,_,_,_,_).
centro_saude(ID) :- centro_saude(ID,_,_,_,_).
staff(ID) :- staff(ID,_,_,_).
vacinacao_covid(Idstaff,Idutente) :- vacinacao_covid(Idstaff,Idutente,_,_,_).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Permitir a definição de fases de vacinação, definindo critérios de inclusão de utentes nas diferentes fases (e.g., doenças crónicas, idade, profissão);

fase(1,Id,date(2021,2,1)) :- idade(Id,I), I>=80.
faseLista(1,L,date(2021,2,1)) :- solucoes(Id,fase(1,Id,date(2021,2,1)),L).

fase(2,Id,date(2021,3,16)) :- utente(Id,_,_,_,_,_,_,_,DoencasCronicas,_), nao(vazia(DoencasCronicas)).
faseLista(2,L,date(2021,3,16)) :- solucoes(Id,fase(2,Id,date(2021,3,16)),L).

fase(3,Id,date(2021,4,29)) :- 
    utente(Id,_,_,_,_,_,_,Profissao,_,_),
    pertence(Profissao,['Médica','Médico','Enfermeira','Enfermeiro','Auxiliar de Saúde','Professora','Professor']).
faseLista(3,L,date(2021,4,29)) :- solucoes(Id,fase(3,Id,date(2021,4,29)),L).

fase(4,Id,date(2021,6,12)) :- utente(Id), nao(fase(1,Id,_)), nao(fase(2,Id,_)), nao(fase(3,Id,_)).
faseLista(4,L,date(2021,6,12)) :- solucoes(Id,fase(4,Id,date(2021,6,12)),L).

idade(Id,I) :- utente(Id,_,_,Data_Nasc,_,_,_,_,_,_), date(DataAtual), date_interval(DataAtual,Data_Nasc, I years).
vazia([]).
pertence(X,[X|L]).
pertence(X,[Y|L]) :- X\=Y, pertence(X,L).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas nao vacinadas

-vacinada(Id) :- nao(vacinacao_covid(_,Id)).
% extra
%-vacinada(Id) :- nao(vacinada(Id)), nao(excecao(vacinada(Id))).

% Identificar pessoas nao vacinadas numa certa toma
-vacinada(Id,T) :- nao(vacinacao_covid(_,Id,_,_,T)).
% extra
%-vacinada(Id,T) :- nao(vacinada(Id,T)), nao(excecao(vacinada(Id,T))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas vacinadas

vacinada(Id) :- utente(Id), vacinacao_covid(_,Id,_,_,_).

% Identificar pessoas vacinadas numa certa toma 
vacinada(Id,2) :- utente(Id), vacinacao_covid(_,Id,_,_,2).
vacinada(Id,1) :- utente(Id), vacinacao_covid(_,Id,_,_,1).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas vacinadas indevidamente

vacinada_indevidamente(Id) :- utente(Id), vacinada(Id), vacinacao_covid(_,Id,Data_vac,_,_), fase(_,Id,Data_fase),! ,date_compare(Data_fase,>,Data_vac).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas não vacinadas e que são candidatas a vacinação

candidata(Id) :- utente(Id), nao(vacinada(Id)), date(DataAtual), fase(_,Id,DataFase), date_compare(DataAtual,>=,DataFase).
candidatas(S) :- solucoes(Id,candidata(Id),S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas a quem falta a segunda toma da vacina

segunda_toma(Id) :- utente(Id), vacinada(Id,1), nao(vacinada(Id,2)).





%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%---- Registos
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% utente
registarUtente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro) :-
    evolucao(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro)).


% centro_saude
registarCentro(Id,Nome,Morada,Telefone,Email) :-
    evolucao(centro_saude(Id,Nome,Morada,Telefone,Email)).


% staff
registarStaff(Idstaff,Idcentro,Nome,Email) :-
    evolucao(staff(Idstaff,Idcentro,Nome,Email)).


% vacinacao_covid
registarVacinacao(Idstaff,Idutente,Data,Vacina,Toma) :-
    evolucao(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%---- Remoções
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% utente
removerUtente(Nome) :-
    involucao(utente(_,_,Nome,_,_,_,_,_,_,_)).


% centro_saude
removerCentro(Nome) :-
    involucao(centro_saude(_,Nome,_,_,_)).


% staff
removerStaff(Nome) :-
    involucao(staff(_,_,Nome,_)).


% vacinacao_covid
removerVacinacao(Idstaff,Idutente,Data,Vacina,Toma) :-
    involucao(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).








%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver mais que um utente com os mesmos dados
+utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro) :: 
                (solucoes(Idutente,utente(Idutente),S),
                 comprimento(S,N),
                 N==1).


+utente(_,_,_,_,_,_,_,_,_,Idcentro) :: 
                (solucoes(Idcentro,centro_saude(Idcentro),S),
                 comprimento(S,N),
                 N>0).                 

+vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma) :: 
                (solucoes((Idstaff,Idutente),(staff(Idstaff),utente(Idutente)),S),
                 comprimento(S,N),
                 N==1). 


% Isto não funciona
%-utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro) :: 
%                (solucoes(Nome,(vacinada(Nome)),S),
%                 comprimento(S,N),
%                 N==1).


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
