%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definições iniciais

%Invariantes Regular
:- op(900,xfy,'::').


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


% EVOLUÇÃO DO CONHECIMENTO INCERTO
%utente: #Utente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde, #MédicoDeFamília ↝ { 𝕍, 𝔽}
% (1) Utente ------------------------------------------------------------------

evolucaoNameIncerto(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)) :-
        evolucao(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)),
        assert(((excecao(utente(Id,Nss,N,DN,E,T,M,P,DC,Idc,Idm))) :- utente(Id,Nss,Nome,DN,E,T,M,P,DC,Idc,Idm))),
        assert(uncertainName(Nome)).


involucaoNameIncerto(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)) :-
          involucao(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)),
          retract(((excecao((Id,Nss,N,DN,E,T,M,P,DC,Idc,Idm))) :- utente(Id,Nss,Nome,DN,E,T,M,P,DC,Idc,Idm))),
          retract(uncertainName(Nome)).


evolucaoIdadeIncerto(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)) :-
        evolucao(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)),
        assert(((excecao(utente(Id,Nss,N,DN,E,T,M,P,DC,Idc,Idm))) :- utente(Id,Nss,N,DataNasc,E,T,M,P,DC,Idc,Idm))),
        assert(uncertaintyAge(idade(DataNasc,X))).

involucaoIdadeIncerto(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)) :-
          involucao(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)),
          retract(((excecao(utente(Id,Nss,N,DN,E,T,M,P,DC,Idc,Idm))) :- utente(Id,Nss,N,DataNasc,E,T,M,P,DC,Idc,Idm))),
          retract(uncertaintyAge(idade(DataNasc,X))).


%auxiliar idade //  nao sabia se ao usar o id como temos no outro predicado idade faria diferença depois ao inferir o involucaoIdadeIncerto
%idade(DataNasc,I) :- date(DataAtual), date_interval(DataAtual,DataNasc, I years).



evolucaoMoradaIncerto(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)) :-
        evolucao(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)),
        assert(((excecao(utente(Id,Nss,N,DN,E,T,M,P,DC,Idc,Idm))) :- utente(Id,Nss,N,DN,E,T,Morada,P,DC,Idc,Idm))),
        assert(uncertainMorada(Morada)).


involucaoMoradaIncerto(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)) :-
          involucao(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)),
          retract(((excecao(utente(Id,Nss,N,DN,E,T,M,P,DC,Idc,Idm))) :- utente(Id,Nss,N,DN,E,T,Morada,P,DC,Idc,Idm))),
          retract(uncertaintyMorada(Morada)).


% EVOLUÇÃO DO CONHECIMENTO INTERDITO
% (1) Utente ------------------------------------------------------------------
   
   evolucaoAdressInterdito(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)) :-(
    nao(excecao(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico))),
    evolucao(utente(ID,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)),
    assert((excecao(utente(Id,Nss,N,DN,E,T,M,P,DC,Idc,Idm)):- utente(Id,Nss,N,DN,E,T,Morada,P,DC,Idc,Idm))),
    assert(nulo(Morada)),
    assert(+utente(Identifier,NrSS,Name,Birthdate,E_Mail,Cellphone,Address,Job,Diseases,IdentifierCenter,IdentifierDoc)::(findall((Identifier,NrSS,Name,Birthdate,E_Mail,Cellphone,Morada,Job,Diseases,IdentifierCenter,IdentifierDoc),
        (utente(IdUt,Nome,Idade,Sexo,C),nao(nulo(C))),L),
    length(L,0)))).


%evolucao conhecimento impreciso

% consulta ????????
%nao sei este 





%atualizar base de conhecimento com casos de conhecimento imperfeito





%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%---- Invariantes
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver mais que um utente com o mesmo identificador
+utente(Idutente,_,_,_,_,_,_,_,_,_,_) :: 
                (solucoes(Idutente,utente(Idutente),S),
                 comprimento(S,N),
                 N==1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver um utente registado num centro de saúde que não seja conhecido pelo sistema
+utente(_,_,_,_,_,_,_,_,_,Idcentro,_) :: 
                (solucoes(Idcentro,centro_saude(Idcentro),S),
                 comprimento(S,N),
                 N>0).                 

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver um utente com um médico de família que não seja do seu centro de saúde
+utente(_,_,_,_,_,_,_,_,_,Idcentro,Idmedico) :: 
                medico_familia(Idmedico,_,_,IdCentro).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver uma vacinação feita por uma pessoa do staff a um utente que não sejam conhecidos pelo sistema
+vacinacao_covid(Idstaff,Idutente,_,_,_) :: 
                (solucoes((Idstaff,Idutente),(staff(Idstaff),utente(Idutente)),S),
                 comprimento(S,N),
                 N==1). 

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver mais que uma vacinação com os mesmos dados
+vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma) :: 
                (solucoes((Idstaff,Idutente),vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma),S),
                 comprimento(S,N),
                 N==1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver uma segunda toma da vacina sem haver a primeira
+vacinacao_covid(Idstaff,Idutente,Data,Vacina,2) :: 
                (solucoes((Idstaff,Idutente),vacinacao_covid(Idstaff,Idutente,Data,Vacina,1),S),
                 comprimento(S,N),
                 N==1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver mais que um centro de saude com o mesmo identificador
+centro_saude(Idcentro,_,_,_,_) ::
                (solucoes(Idcentro,centro_saude(Idcentro),S),
                comprimento(S,N),
                N==1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver mais que um centro de saude com os mesmos dados
+centro_saude(Idcentro,Nome,Morada,Telefone,Email) ::
                (solucoes(Idcentro,centro_saude(Idcentro,Nome,Morada,Telefone,Email),S),
                comprimento(S,N),
                N==1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver mais que um staff com o mesmo identificador
+staff(Idstaff,_,_,_) ::
                (solucoes(Idstaff,staff(Idstaff),S),
                 comprimento(S,N),
                 N==1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver staff de um centro de saúde que não é conhecido pelo sistema
+staff(_,Idcentro,_,_) ::
                (solucoes(Idcentro,centro_saude(Idcentro),S),
                comprimento(S,N),
                N>0).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver mais que um medico com o mesmo identificador
+medico_familia(Idmedico,_,_,_) ::
                (solucoes(Idmedico,medico_familia(Idmedico),S),
                 comprimento(S,N),
                 N==1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver mais que uma consulta com o mesmo identificador
+consulta(Idconsulta,_,_,_,_,_) ::
                (solucoes(Idconsulta,consulta(Idconsulta),S),
                 comprimento(S,N),
                 N==1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode haver uma consulta feita por um médico a um utente que não sejam conhecidos pelo sistema
+consulta(_,Idutente,Idmedico,_,_,_) :: 
                (solucoes((Idmedico,Idutente),(medico_familia(Idmedico),utente(Idutente)),S),
                 comprimento(S,N),
                N==1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode ser retirado um utente que ainda não tenha a vacinação completa
-utente(Idutente,_,_,_,_,_,_,_,_,_,_) ::
                (vacinacao_covid(_,Idutente,_,_,2)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode ser retirado um centro de saúde que tenha utentes registados
-centro_saude(Idcentro,_,_,_,_) ::
                (solucoes(Idutente,(utente(Idutente,_,_,_,_,_,_,_,_,Idcentro,_)),S),
                comprimento(S,N),
                N==0).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Não pode ser retirado um médico de família que seja médico de um utente registado
-medico_familia(Idmedico,_,_,_) ::
                (solucoes(Idutente,utente(Idutente,_,_,_,_,_,_,_,_,_,Idmedico),S),
                comprimento(S,N),
                N==0).

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
