%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definições iniciais

%Invariantes Regular
:- op(900,xfy,'::').
:- op(900,xfy,':.:').
:- op(900,xfy,':..:').


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a evolucao do conhecimento

evolucao(Termo) :- solucoes(Invariante,+Termo::Invariante,Lista), insercao(Termo), teste(Lista).

evolucao(-Termo) :- solucoes(Invariante,+(-Termo)::Invariante,Lista), insercao(-Termo), teste(Lista).

evolucaoIncerto(Termo) :-
    solucoes(Invariante,+Termo::Invariante,Lista),
    solucoes(Invariante,+Termo:.:Invariante,ListaImperfeito),
    insercao(Termo),
    teste(Lista),
    teste(ListaImperfeito).

evolucaoImpreciso(Termo) :-
  solucoes(Invariante,+Termo::Invariante,Lista),
  solucoes(Invariante,+Termo:..:Invariante,ListaImpreciso),
  insercao(excecao(Termo)),
  teste(Lista),
  teste(ListaImpreciso).

insercao(Termo) :- assert(Termo).
insercao(Termo) :- retract(Termo),!,fail.

teste([]).
teste([R|LR]) :- R, teste(LR).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a involucao do conhecimento

involucao(Termo) :- solucoes(Invariante,-Termo::Invariante,Lista), remocao(Termo), teste(Lista).

involucao(-Termo) :- solucoes(Invariante,-(-Termo::Invariante,Lista)), remocao(-Termo), teste(Lista).

involucaoIncerto(Termo) :-
    solucoes(Invariante,-Termo::Invariante,Lista),
    solucoes(Invariante,-Termo:.:Invariante,ListaIncerto),
    remocao(Termo),
    teste(Lista),
    teste(ListaIncerto).

involucaoImpreciso(Termo) :-
    solucoes(Invariante,-Termo::Invariante,Lista),
    solucoes(Invariante,-Termo:..:Invariante,ListaImpreciso),
    remocao(excecao(Termo)),
    teste(Lista),
    teste(ListaImpreciso).

remocao(Termo) :- retract(Termo).
remocao(Termo) :- assert(Termo),!,fail.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Evolução do conhecimento incerto
%utente - nome desconhecido
evolucao_incerto(utente(Idutente,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)) :-
        evolucaoIncerto(utente(IIdutenteD,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)),
        insercao(((excecao(utente(Id,Nss,N,DN,E,T,M,P,DC,Idc,Idm))) :- utente(Id,Nss,Nome,DN,E,T,M,P,DC,Idc,Idm))),
        insercao(incerto(utente(Idutente))).

involucao_incerto(utente(Idutente,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)) :-
          involucaoIncerto(utente(Idutente,NSS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)),
          remocao(((excecao((Idu,Nss,N,DN,E,T,M,P,DC,Idc,Idm))) :- utente(Idu,Nss,Nome,DN,E,T,M,P,DC,Idc,Idm))),
          remocao(incerto(utente(Idutente))).

%centro_saude
evolucao_incerto(centro_saude(Idcentro,Nome,Morada,Telefone,Email)) :-
        evolucaoIncerto(centro_saude(Idcentro,Nome,Morada,Telefone,Email)),
        insercao(((excecao(centro_saude(Id,N,M,T,E))) :- centro_saude(Id,N,Morada,T,E))),
        insercao(incerto(centro_saude(Idcentro))).

involucao_incerto(centro_saude(Idcentro,Nome,Morada,Telefone,Email)) :-
        involucaoIncerto(centro_saude(Idcentro,Nome,Morada,Telefone,Email)),
        remocao(((excecao(centro_saude(Id,N,M,T,E))) :- centro_saude(Id,N,Morada,T,E))),
        remocao(incerto(centro_saude(Idcentro))).

%staff
evolucao_incerto(staff(Idstaff,Idcentro,Nome,Email)) :-
        evolucaoIncerto(staff(Idstaff,Idcentro,Nome,Email)),
        insercao(((excecao(staff(Ids,Idc,N,E))) :- staff(Ids,Idc,N,Email))),
        insercao(incerto(staff(Istaff))).

involucao_incerto(staff(Idstaff,Idcentro,Nome,Email)) :-
        involucaoIncerto(staff(Idstaff,Idcentro,Nome,Email)),
        remocao(((excecao(staff(Ids,Idc,N,E))) :- staff(Ids,Idc,N,Email))),
        remocao(incerto(staff(Istaff))).

%vacinacao_covid
evolucao_incerto(vacinacao_covid(Idstaff, Idutente, Data, Vacina, Toma)) :-
        evolucaoIncerto(vacinacao_covid(Idstaff, Idutente, Data, Vacina, Toma)),
        insercao(((excecao(vacinacao_covid(Ids, Idu, D, V, T))) :- vacinacao_covid(Ids, Idu, D, Vacina, T))),
        insercao(incerto(vacinacao_covid(Idstaff, Idutente, Data, Vacina, Toma))).

involucao_incerto(vacinacao_covid(Idstaff, Idutente, Data, Vacina, Toma)) :-
        involucaoIncerto(vacinacao_covid(Idstaff, Idutente, Data, Vacina, Toma)),
        remocao(((excecao(vacinacao_covid(Ids, Idu, D, V, T))) :- vacinacao_covid(Ids, Idu, D, Vacina, T))),
        remocao(incerto(vacinacao_covid(Idstaff, Idutente, Data, Vacina, Toma))).

%medico_familia
evolucao_incerto(medico_familia(Idmedico,Nome,Email,Idcentro)) :-
        evolucaoIncerto(medico_familia(Idmedico,Nome,Email,Idcentro)),
        insercao(((excecao(medico_familia(Idm,N,E,Idc))) :- medico_familia(Idm,N,E,Idcentro))),
        insercao(incerto(medico_familia(Idmedico))).

involucao_incerto(medico_familia(Idmedico,Nome,Email,Idcentro)) :-
        involucaoIncerto(medico_familia(Idmedico,Nome,Email,Idcentro)),
        remocao(((excecao(medico_familia(Idm,N,E,Idc))) :- medico_familia(Idm,N,E,Idcentro))),
        remocao(incerto(medico_familia(Idmedico))).

%consulta
evolucao_incerto(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)) :-
        evolucaoIncerto(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)),
        insercao(((excecao(consulta(Idc,Idu,Idm,Desc,C,D))) :- consulta(Idc,Idu,Idm,Descricao,C,D))),
        insercao(incerto(staff(Idconsulta))).

involucao_incerto(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)) :-
        involucaoIncerto(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)),
        remocao(((excecao(consulta(Idc,Idu,Idm,Desc,C,D))) :- consulta(Idc,Idu,Idm,Descricao,C,D))),
        remocao(incerto(staff(Idconsulta))).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Evolução do conhecimento interdito
%consulta
evolucao_interdito(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)) :-
    (nao(excecao(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data))),
     evolucaoIncerto(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)),
     insercao((excecao(consulta(Idc,Idu,Idm,Desc,C,D)):- consulta(Idc,Idu,Idm,Descricao,C,D))),
     insercao(nulo(Descricao)),
     insercao(interdito(consulta(Idutente))),
     insercao(+consulta(_,_,_,_,_,_) :: (solucoes(D,
                                         (consulta(Idconsulta,Idutente,Idmedico,D,Custo,Data),nao(nulo(D))),S),
                                         comprimento(S,0)))).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Evolução do conhecimento impreciso
%consulta
evolucao_impreciso(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)) :-
        insercao(impreciso(consulta(Idconsulta))),
        evolucaoImpreciso(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)).

involucao_impreciso(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)) :-
        remocao(impreciso(consulta(Idconsulta))),
        remocao(excecao(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%---- Invariantes
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

+Termo :: (nao(-Termo)).

+(-Termo) :: (nao(Termo)).


+(excecao(Termo)) :: (solucoes(Termo,excecao(Termo),S),
                      comprimento(S,N),
                      N==1).

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
% Invariantes para adição de conhecimento perfeito negativo
% Não pode ser adicionado conhecimento negativo duplicado para o mesmo identificador
+(-utente(Idutente,_,_,_,_,_,_,_,_,_,_)) :: 
                (solucoes(Idutente,(-utente(Idutente)),S),
                 comprimento(S,N),
                 N==1).

+(-staff(Idstaff,_,_,_)) :: 
                (solucoes(Idstaff,(-staff(Idstaff)),S),
                 comprimento(S,N),
                 N==2).

+(-vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)) :: 
                (solucoes((Idstaff,Idutente),(-vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)),S),
                 comprimento(S,N),
                 N==2).

+(-centro_saude(Idcentro,_,_,_,_)) ::
                (solucoes(Idcentro,(-centro_saude(Idcentro)),S),
                comprimento(S,N),
                N==2).

+(-medico_familia(Idmedico,_,_,_)) ::
                (solucoes(Idmedico,(-medico_familia(Idmedico)),S),
                 comprimento(S,N),
                 N==2).

+(-consulta(Idconsulta,_,_,_,_,_)) ::
                (solucoes(Idconsulta,(-consulta(Idconsulta)),S),
                 comprimento(S,N),
                 N==2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes de adição de conhecimento incerto/interdito
% Não é possível adicionar conhecimento incerto/interdito se já existir conhecimento impreciso
+utente(Idutente,_,_,_,_,_,_,_,_,_,_) :.: 
        (nao(incerto(utente(Idutente))),
        nao(impreciso(utente(Idutente)))).

+centro_saude(Idcentro,_,_,_,_) :.:
        nao(impreciso(centro_saude(Idcentro))).

+staff(Idstaff,_,_,_) :.:
        nao(impreciso(staff(Idstaff))).

+vacinacao_covid(Idstaff,Idutente,_,_,_) :.:
        nao(impreciso(vacinacao_covid(Idstaff,Idutente))).

+medico_familia(Idmedico,_,_,_) :.:
        nao(impreciso(medico_familia(Idmedico))).

+consulta(Idconsulta,_,_,_,_,_) :.:
        nao(impreciso(consulta(Idconsulta))).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes de adição de conhecimento impreciso
% Não é possível adicionar conhecimento impreciso se já existir conhecimento incerto ou interdito
+utente(Idutente,_,_,_,_,_,_,_,_,_,_) :..: 
        (nao(incerto(utente(Idutente))),
         nao(interdito(utente(Idutente)))).

+centro_saude(Idcentro,_,_,_,_) :..:
        (nao(incerto(centro_saude(Idcentro))),
         nao(interdito(centro_saude(Idcentro)))).

+staff(Idstaff,_,_,_) :..:
        (nao(incerto(staff(Idstaff))),
         nao(interdito(staff(Idstaff)))).

+vacinacao_covid(Idstaff,Idutente,_,_,_) :..:
        (nao(incerto(vacinacao_covid(Idstaff,Idutente))),
         nao(interdito(vacinacao_covid(Idstaff,Idutente)))).

+medico_familia(Idmedico,_,_,_) :..:
        (nao(incerto(medico_familia(Idmedico))),
         nao(interdito(medico_familia(Idmedico)))).

+consulta(Idconsulta,_,_,_,_,_) :..:
        (nao(incerto(consulta(Idconsulta))),
         nao(interdito(consulta(Idconsulta)))).


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
% Registos incerto
% utente
registarUtenteIncerto(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico) :-
    evolucao_incerto(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)).

% centro_saude
registarCentroIncerto(Id,Nome,Morada,Telefone,Email) :-
    evolucao_incerto(centro_saude(Id,Nome,Morada,Telefone,Email)).

% staff
registarStaffIncerto(Idstaff,Idcentro,Nome,Email) :-
    evolucao_incerto(staff(Idstaff,Idcentro,Nome,Email)).

% vacinacao_covid
registarVacinacaoIncerto(Idstaff,Idutente,Data,Vacina,Toma) :-
    evolucao_incerto(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).

% medico_familia
registarMedicoIncerto(IdMedico,Nome,Email,IdCentro):-
    evolucao_incerto(medico_familia(Idstaff,Nome,Email,IdCentro)).

%consulta
registarConsultaIncerto(IdConsulta,IdUtente,IdMedico,Descricao,Custo,Data):-
    evolucao_incerto(consulta(IdConsulta,IdUtente,IdMedico,Descricao,Custo,Data)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Registos interdito
% utente
registarUtenteInterdito(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico) :-
    evolucao_interdito(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)).

% centro_saude
registarCentroInterdito(Id,Nome,Morada,Telefone,Email) :-
    evolucao_interdito(centro_saude(Id,Nome,Morada,Telefone,Email)).

% staff
registarStaffInterdito(Idstaff,Idcentro,Nome,Email) :-
    evolucao_interdito(staff(Idstaff,Idcentro,Nome,Email)).

% vacinacao_covid
registarVacinacaoInterdito(Idstaff,Idutente,Data,Vacina,Toma) :-
    evolucao_interdito(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).

% medico_familia
registarMedicoInterdito(IdMedico,Nome,Email,IdCentro):-
    evolucao_interdito(medico_familia(Idstaff,Nome,Email,IdCentro)).

%consulta
registarConsultaInterdito(IdConsulta,IdUtente,IdMedico,Descricao,Custo,Data):-
    evolucao_interdito(consulta(IdConsulta,IdUtente,IdMedico,Descricao,Custo,Data)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Registos impreciso
% utente
registarUtenteImpreciso(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico) :-
    evolucao_impreciso(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)).

% centro_saude
registarCentroImpreciso(Id,Nome,Morada,Telefone,Email) :-
    evolucao_impreciso(centro_saude(Id,Nome,Morada,Telefone,Email)).

% staff
registarStaffImpreciso(Idstaff,Idcentro,Nome,Email) :-
    evolucao_impreciso(staff(Idstaff,Idcentro,Nome,Email)).

% vacinacao_covid
registarVacinacaoImpreciso(Idstaff,Idutente,Data,Vacina,Toma) :-
    evolucao_impreciso(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).

% medico_familia
registarMedicoImpreciso(IdMedico,Nome,Email,IdCentro):-
    evolucao_impreciso(medico_familia(Idstaff,Nome,Email,IdCentro)).

%consulta
registarConsultaImpreciso(IdConsulta,IdUtente,IdMedico,Descricao,Custo,Data):-
    evolucao_impreciso(consulta(IdConsulta,IdUtente,IdMedico,Descricao,Custo,Data)).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%---- Remoções
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% utente
removerUtente(Idutente) :-
    perfeito(utente(Idutente)),
    utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico),
    involucao(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)).

% centro_saude
removerCentro(Idcentro) :-
    perfeito(centro_saude(IdUtente)),
    centro_saude(Idcentro,Nome,Morada,Telefone,Email),
    involucao(centro_saude(Idcentro,Nome,Morada,Telefone,Email)).

% staff
removerStaff(Idstaff) :-
    perfeito(staff(Idstaff)),
    staff(Idstaff,Idcentro,Nome,Email),
    involucao(staff(Idstaff,Idcentro,Nome,Email)).

% vacinacao_covid
removerVacinacao(Idstaff,Idutente,Data,Vacina,Toma) :-
    perfeito(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)),
    involucao(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).

% medico_familia
removerMedico(Idmedico) :-
    perfeito(IdMedico),
    medico_familia(Idmedico,Nome,Email,IdCentro),
    involucao(medico_familia(Idmedico,Nome,Email,IdCentro)).

% consulta
removerConsulta(Idconsulta) :-
    perfeito(IdConsulta),
    consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data),
    involucao(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Remoções incerto
% utente
removerUtente(Idutente) :-
    incerto(utente(Idutente)),
    utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico),
    involucao_incerto(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)).

% centro_saude
removerCentro(Idcentro) :-
    incerto(centro_saude(IdUtente)),
    centro_saude(Idcentro,Nome,Morada,Telefone,Email),
    involucao_incerto(centro_saude(Idcentro,Nome,Morada,Telefone,Email)).

% staff
removerStaff(Idstaff) :-
    incerto(staff(Idstaff)),
    staff(Idstaff,Idcentro,Nome,Email),
    involucao_incerto(staff(Idstaff,Idcentro,Nome,Email)).

% vacinacao_covid
removerVacinacao(Idstaff,Idutente,Data,Vacina,Toma) :-
    incerto(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)),
    involucao_incerto(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).

% medico_familia
removerMedico(Idmedico) :-
    incerto(IdMedico),
    medico_familia(Idmedico,Nome,Email,IdCentro),
    involucao_incerto(medico_familia(Idmedico,Nome,Email,IdCentro)).

% consulta
removerConsulta(Idconsulta) :-
    incerto(IdConsulta),
    consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data),
    involucao_incerto(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Remoções interdito
% utente
% utente
removerUtente(Idutente) :-
    interdito(utente(Idutente)),
    utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico),
    involucao_interdito(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)).

% centro_saude
removerCentro(Idcentro) :-
    interdito(centro_saude(IdUtente)),
    centro_saude(Idcentro,Nome,Morada,Telefone,Email),
    involucao_interdito(centro_saude(Idcentro,Nome,Morada,Telefone,Email)).

% staff
removerStaff(Idstaff) :-
    interdito(staff(Idstaff)),
    staff(Idstaff,Idcentro,Nome,Email),
    involucao_interdito(staff(Idstaff,Idcentro,Nome,Email)).

% vacinacao_covid
removerVacinacao(Idstaff,Idutente,Data,Vacina,Toma) :-
    interdito(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)),
    involucao_interdito(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).

% medico_familia
removerMedico(Idmedico) :-
    interdito(IdMedico),
    medico_familia(Idmedico,Nome,Email,IdCentro),
    involucao_interdito(medico_familia(Idmedico,Nome,Email,IdCentro)).

% consulta
removerConsulta(Idconsulta) :-
    interdito(IdConsulta),
    consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data),
    involucao_interdito(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Remoções impreciso
% utente
% utente
removerUtente(Idutente) :-
    impreciso(utente(Idutente)),
    utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico),
    involucao_interdito(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)).

% centro_saude
removerCentro(Idcentro) :-
    impreciso(centro_saude(IdUtente)),
    centro_saude(Idcentro,Nome,Morada,Telefone,Email),
    involucao_interdito(centro_saude(Idcentro,Nome,Morada,Telefone,Email)).

% staff
removerStaff(Idstaff) :-
    impreciso(staff(Idstaff)),
    staff(Idstaff,Idcentro,Nome,Email),
    involucao_interdito(staff(Idstaff,Idcentro,Nome,Email)).

% vacinacao_covid
removerVacinacao(Idstaff,Idutente,Data,Vacina,Toma) :-
    impreciso(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)),
    involucao_interdito(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).

% medico_familia
removerMedico(Idmedico) :-
    impreciso(IdMedico),
    medico_familia(Idmedico,Nome,Email,IdCentro),
    involucao_interdito(medico_familia(Idmedico,Nome,Email,IdCentro)).

% consulta
removerConsulta(Idconsulta) :-
    impreciso(IdConsulta),
    consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data),
    involucao_interdito(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)).

