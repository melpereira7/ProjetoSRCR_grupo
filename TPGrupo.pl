encoding(iso_latin_1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Instrumento de avaliação em grupo


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Declaracoes iniciais

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).

:- use_module(library(date_time)).
:- use_module(library(lists)).

%para dar up do menu
:- consult(menu).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definicoes iniciais

:- op(900,xfy,'::').
:- dynamic utente/11.
:- dynamic centro_saude/5.
:- dynamic staff/4.
:- dynamic vacinacao_covid/5.
:- dynamic medico_familia/4.
:- dynamic consulta/7.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%utente: #Utente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde, #MédicoDeFamília ↝ { 𝕍, 𝔽}
%utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,[DoencasCronicas],Idcentro,Idmedico).
%centro_saude: #Centro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}
%centro_saude(Idcentro,Nome,Morada,Telefone,Email).
%staff: #Staff, #Centro, Nome, email ↝ { 𝕍, 𝔽 }
%staff(Idstaff,Idcentro,Nome,Email).
%vacinacao_covid: #Staff, #Utente, Data, Vacina, Toma↝ { 𝕍, 𝔽 }
%vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma).
%medico_familia: #Medico,Nome,Email,#Centro ↝ { 𝕍, 𝔽 }
%consulta:#Consulta,#Utente,#Medico,#Centro,Descrição,Custo,Data ↝ { 𝕍, 𝔽 }

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de conhecimento (com exemplos arbitrários)

utente(1,21111111112,'Ana Murciellago',date(1930,1,1),'ana@gmail.com',911234567,'Braga','Médica',[],1,1).
utente(2,22111111112,'Maria do Olival',date(2001,11,5), 'maria@gmail.com',936484263 ,'Viana do Castelo', 'Professora', ['asma'],1,1).
utente(3,01234567890,'Igor Marcos',date(1989,8,20),'marcos.mendes@gmail.com',252252252,'R. Amaral 8499-852 São Mamede de Infesta','Agricultor',['hiv','hepatite'],3,2).
utente(4,11111111111,'Rebeca Tavares Marques',date(2009,8,10),'maia.lara@gmail.com',930643063,'Avenida St. Valentim Fonseca, nº 3, 94º Dir. 9794-701 Quarteira','Estudante',['tuberculose'],2,3).
utente(5,09876543210,'Yasmin Sara Leite de Borges',date(1989,4,19),'dinis91@pereira.info',236082002,'Avenida Leonardo Rodrigues, nº 2 3819-133 Aveiro','CEO Empresa de Marketing',['brucellosis','gripe canina'],4,4).
utente(6,66666666666,'José Aristoteles',date(1967,1,29),'exprimeiro@gov.pt',090909090,'Alameda','Engenheiro',[],9,9).
utente(7,12345652858,'Custódio Borges',date(1987,4,15),'custodio@sapo.pt',251252254,'Rua Esteves Vasto 23 Santo Tirso','Calceiteiro',['Hipertensão','Colesterol'],7,7).
utente(8,15615956260,'Francisco Carriço',date(1977,4,17),'carriçochico@yahoo.com',255256258,'Rua Professor Batata Aracena','Advogado',['Diabetes','Artrite'],8,8).
utente(9,30861910266,'Jacinta Barboza',date(1982,2,13),'jacibar@gmail.com',256257269,'Rua do Rei de Fafe, Fafe','Empresário',['Alzheimer','Doença crónica dos rins'],10,10).

centro_saude(1,'USFVida+','Vila Verde',253123456,'usfvida+@hotmail.com').
centro_saude(2,'UCSP Quarteira','Quarteira',244322111,'ucspquart@info.gmailcom').
centro_saude(3,'USF infesta','São Mamede Infesta', 254254252,'centrosaude@gmail.com').
centro_saude(4,'USF MOLICEIRO', 'Aveiro', 2512522523, 'aveirocsaude@saude.com').
centro_saude(5,'CS Penha de Franhça', 'Rua Luís Pinto Moitinho,5 Lisboa', 224322123, 'cspenhafranca@gmail.com').
centro_saude(6,'Centro de Saude Caldas da Rainha', 'Rua do Centro de Saude, Caldas da Rainha', 2412422423,'caldasofthequeen@gmail.com').
centro_saude(7,'Centro Saúde Lousã', 'Alameda Juiz Conselheiro Nunes Ribeiro, Vilarinho',232123123,'vilarinholsa@minsaude.com').
centro_saude(8,'Centro de Saúde S.Pedro do Sul','Avenida da Ponte, São Pedro do Sul',224123412, 'saintpetersouth@minsaude.com').
centro_saude(9,'Centro Saúde Ovar', 'Rua Dr. Francisco Zagalo s/n, OVAR', 245245245,'ovarhashealth@minsaude.com').
centro_saude(10,'Centro de Saude Almodovar','Rua Professor Dr Fernando Padua, ALMODOVAR', 263264265,'almodovaralmodovar@minsaude.com').

staff(1,1,'Maria Silva','maria@gmail.com').
staff(2,1,'Joana Guerra','joana@gmail.com').
staff(3,1,'Miguel Santos', 'santosmiguel@gmail.com').
staff(4,2,'Mario Sergio', 'sergiomario@gmail.com').
staff(5,2,'Ricardo Salgado','salgadoricardo@bancoes.com').
staff(6,3,'Joana Vasconcelos', 'arte@gmail.com').
staff(7,4,'Pedro Granger', 'apresentador@rtp.pt').
staff(8,5,'Luis Magalhaes', 'luismagalean@saudept.pt').
staff(9,6,' Mario Carvalhal', 'carvalhal@braga.pt').
staff(10,7,'Sergio Pedro', 'pedrosergio@cso.pt').
staff(11,8,'Ana Silva', 'anasilva123@sapo.pt').
staff(12,8,'Ricardo Tomé', 'riccardoootome@yahoo.com').
staff(13,9,'Tiago Xavier', 'xavy99gem@riot.com').
staff(14,7,'Miguel Tavares', 'miguelsousatavares@tvi.pt').
staff(15,10,'Sophia Anderson', 'sophiamellobryner@denmark.de').

vacinacao_covid(1,1,date(2021,2,1),'Pfizer',1).
vacinacao_covid(2,1,date(2021,2,16),'Pfizer',2).
vacinacao_covid(1,2,date(2021,2,28),'Pfizer',1).                %vacinada indevidamente e falta segunda toma
vacinacao_covid(6,3,date(2021,3,20),'AstraZeneca',1).
vacinacao_covid(4,4,date(2021,3,17),'Pfizer',1).
vacinacao_covid(5,4,date(2021,4,1),'Pfizer',2).
vacinacao_covid(6,3,date(2021,4,10),'AstraZeneca',2).
vacinacao_covid(7,6,date(2021,2,5),'AstraZeneca',1).            %vacinada indevidamente

medico_familia(1,'Carlos Estevão','carlitos@gmail.com',1).
medico_familia(2,'Maria Silvana','silvana@gmail.com',3).
medico_familia(3,'Rogério Magalhães','magalhaes@gmail.com',2).
medico_familia(4,'Luis Ricciardi','ricciardi76@gmail.com',4).
medico_familia(5,'Joana Cunha','joanaCunha@gmail.com',5).
medico_familia(6,'Maria Suzete','suzetemaria@gmail.com',6).
medico_familia(7,'José Carlos Saraiva','zecarlos@gmail.com',7).
medico_familia(8,'Manuel Saramago','sarmanu@gmail.com',8).
medico_familia(9,'Ana Costa Silva','anacostafilomena@hotmail.com',9).
medico_familia(10,'Luisa Sobral','sobraleurovision@almodovarcs.pt',10).
medico_familia(11,'Salvador Sentido','semsentid@gmail.com',9).
medico_familia(12,'Manuel Rodrigues','sarmanu@sapo.pt',8).

consulta(1,1,2,'Consulta de rotina',15.00,date(2021,4,21)).
consulta(2,2,1,'Dores pós vacinação',7.50,date(2021,4,11)).
consulta(3,2,3,'Relatorio medicação HIV',15.00,date(2021,3,7)).
consulta(4,4,5,'Formulação de baixa laboral',70.00,date(2021,7,1)).
consulta(5,4,4,'Avaliacao de teste psicotécnico',20.70,date(2021,5,11)).
consulta(6,5,7,'Consulta de rotina',15.00,date(2021,11,3)).
consulta(7,7,8,'Consulta de rotina',15.00,date(2021,7,6)).
consulta(8,8,6,'Verificação exames diabéticos',15.00,date(2021,2,13)).
consulta(9,9,11,'Consulta de rotina',15.00,date(2021,1,11)).
consulta(10,9,11,'Marcação de exames rotineiros',5.00,date(2021,5,10)).


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


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas vacinadas

vacinada(Id) :- utente(Id), vacinacao_covid(_,Id).

% Identificar pessoas vacinadas numa certa toma 
vacinada(Id,2) :- utente(Id), vacinacao_covid(_,Id,_,_,2).
vacinada(Id,1) :- utente(Id), vacinacao_covid(_,Id,_,_,1).

vacinadas(S) :- solucoes(Id,vacinada(Id),S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas vacinadas indevidamente

-vacinada_indevidamente(Id) :- nao(vacinada_indevidamente(Id)).
vacinada_indevidamente(Id) :- vacinacao_covid(_,Id,DataVac,_,1), verificaFase(_,Id,DataFase), date_compare(DataFase,>,DataVac).

vacinadas_indevidamente(S) :- solucoes(Id,vacinada_indevidamente(Id),S).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas não vacinadas e que são candidatas a vacinação

-candidata(Id) :- nao(candidata(Id)).
candidata(Id) :- utente(Id), nao(vacinada(Id)), date(DataAtual), verificaFase(_,Id,DataFase), date_compare(DataAtual,>=,DataFase).

candidatas(S) :- solucoes(Id,candidata(Id),S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Identificar pessoas a quem falta a segunda toma da vacina

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
% 

medicosPorCentro(IdC,C) :- centro_saude(IdC), solucoes(Nome,medico_familia(_,Nome,_,IdC),S),
                                    sort(S,C).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

utentesPorCentro(IdC,C) :- centro_saude(IdC), solucoes(Nome,utente(_,_,Nome,_,_,_,_,_,_,_,IdC),S),
                                    sort(S,C).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

staffPorCentro(IdC,C) :- centro_saude(IdC), solucoes(Nome,staff(_,IdC,Nome,_),S),
                                    sort(S,C).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Lista de pessoas nao vacinadas

naoVacinadas(S) :- solucoes(Id, -vacinada(Id), S).


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
% Extras




% Não pode haver mais que um utente com o mesmo identificador
+utente(Idutente,_,_,_,_,_,_,_,_,_,_) :: 
                (solucoes(Idutente,utente(Idutente),S),
                 comprimento(S,N),
                 N==1).

% Não pode haver um utente registado num centro de saúde que não seja conhecido pelo sistema
+utente(_,_,_,_,_,_,_,_,_,Idcentro,_) :: 
                (solucoes(Idcentro,centro_saude(Idcentro),S),
                 comprimento(S,N),
                 N>0).                 

% Não pode haver um utente com um médico de família que não seja do seu centro de saúde
+utente(_,_,_,_,_,_,_,_,_,Idcentro,Idmedico) :: 
                medico_familia(Idmedico,_,_,IdCentro).

% Não pode haver uma vacinação feita por uma pessoa do staff a um utente que não sejam conhecidos pelo sistema
+vacinacao_covid(Idstaff,Idutente,_,_,_) :: 
                (solucoes((Idstaff,Idutente),(staff(Idstaff),utente(Idutente)),S),
                 comprimento(S,N),
                 N==1). 

% Não pode haver mais que uma vacinação com os mesmos dados
+vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma) :: 
                (solucoes((Idstaff,Idutente),vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma),S),
                 comprimento(S,N),
                 N==1).

% Não pode haver uma segunda toma da vacina sem haver a primeira
+vacinacao_covid(Idstaff,Idutente,Data,Vacina,2) :: 
                (solucoes((Idstaff,Idutente),vacinacao_covid(Idstaff,Idutente,Data,Vacina,1),S),
                 comprimento(S,N),
                 N==1).

% Não pode haver mais que um centro de saude com o mesmo identificador
+centro_saude(Idcentro,_,_,_,_) ::
                (solucoes(Idcentro,centro_saude(Idcentro),S),
                comprimento(S,N),
                N==1).

% Não pode haver mais que um centro de saude com os mesmos dados
+centro_saude(Idcentro,Nome,Morada,Telefone,Email) ::
                (solucoes(Idcentro,centro_saude(Idcentro,Nome,Morada,Telefone,Email),S),
                comprimento(S,N),
                N==1).

% Não pode haver mais que um staff com o mesmo identificador
+staff(Idstaff,_,_,_) ::
                (solucoes(Idstaff,staff(Idstaff),S),
                 comprimento(S,N),
                 N==1).

% Não pode haver staff de um centro de saúde que não é conhecido pelo sistema
+staff(_,Idcentro,_,_) ::
                (solucoes(Idcentro,centro_saude(Idcentro),S),
                comprimento(S,N),
                N>0).

% Não pode haver mais que um medico com o mesmo identificador
+medico_familia(Idmedico,_,_,_) ::
                (solucoes(Idmedico,medico_familia(Idmedico),S),
                 comprimento(S,N),
                 N==1).

% Não pode haver mais que uma consulta com o mesmo identificador
+consulta(Idconsulta,_,_,_,_,_) ::
                (solucoes(Idconsulta,consulta(Idconsulta),S),
                 comprimento(S,N),
                 N==1).

% Não pode haver uma consulta feita por um médico a um utente que não sejam conhecidos pelo sistema
+consulta(_,Idutente,Idmedico,_,_,_) :: 
                (solucoes((Idmedico,Idutente),(medico_familia(Idmedico),utente(Idutente)),S),
                 comprimento(S,N),
                N==1).

% Não pode ser retirado um utente que ainda não tenha a vacinação completa
-utente(Idutente,_,_,_,_,_,_,_,_,_,_) ::
                (vacinacao_covid(_,Idutente,_,_,2)).

% Não pode ser retirado um centro de saúde que tenha utentes registados
-centro_saude(Idcentro,_,_,_,_) ::
                (solucoes(Idutente,(utente(Idutente,_,_,_,_,_,_,_,_,Idcentro,_)),S),
                comprimento(S,N),
                N==0).

% Não pode ser retirado um médico de família que seja médico de um utente registado
-medico_familia(Idmedico,_,_,_) ::
                (solucoes(Idutente,utente(Idutente,_,_,_,_,_,_,_,_,_,Idmedico),S),
                comprimento(S,N),
                N==0).


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
% Extensao do meta-predicado nao: Questao -> {V,F}

nao(Questao) :- Questao, !, fail.
nao(Questao).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes(X,Y,Z) :- findall(X,Y,Z).

comprimento(S,N) :- length(S,N).

print([E]) :- write('\t'), write(E), write('\n'). 
print([H|T]) :- write('\t'), write(H), write('\n'), print(T).

getNames([E], [Nome]):- utente(E, Nome). 
getNames([H|T], [Nome|R]):- utente(H, Nome), getNames(T,R).