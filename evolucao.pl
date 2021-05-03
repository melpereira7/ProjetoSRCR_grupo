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
evolucao_incerto(utente(Idutente,NSS,NomeDesconhecido,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)) :-
        evolucaoIncerto(utente(Idutente,NSS,NomeDesconhecido,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)),
        insercao(((excecao(utente(Id,Nss,N,DN,E,T,M,P,D,Idc,Idm))) :- utente(Id,Nss,NomeDesconhecido,DN,E,T,M,P,D,Idc,Idm))),
        insercao(incerto(utente(Idutente),NomeDesconhecido)).

involucao_incerto(utente(Idutente,NSS,NomeDesconhecido,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)) :-
          involucaoIncerto(utente(Idutente,NSS,NomeDesconhecido,DataNasc,Email,Telefone,Morada,Profissao,DC,IDcentro,IDmedico)),
          remocao(((excecao(utente(Idu,Nss,N,DN,E,T,M,P,D,Idc,Idm))) :- utente(Idu,Nss,NomeDesconhecido,DN,E,T,M,P,D,Idc,Idm))),
          remocao(incerto(utente(Idutente),NomeDesconhecido)).

%centro_saude - morada desconhecida
evolucao_incerto(centro_saude(Idcentro,Nome,MoradaDesconhecida,Telefone,Email)) :-
        evolucaoIncerto(centro_saude(Idcentro,Nome,MoradaDesconhecida,Telefone,Email)),
        insercao(((excecao(centro_saude(Id,N,M,T,E))) :- centro_saude(Id,N,MoradaDesconhecida,T,E))),
        insercao(incerto(centro_saude(Idcentro),MoradaDesconhecida)).

involucao_incerto(centro_saude(Idcentro,Nome,MoradaDesconhecida,Telefone,Email)) :-
        involucaoIncerto(centro_saude(Idcentro,Nome,MoradaDesconhecida,Telefone,Email)),
        remocao(((excecao(centro_saude(Id,N,M,T,E))) :- centro_saude(Id,N,MoradaDesconhecida,T,E))),
        remocao(incerto(centro_saude(Idcentro),MoradaDesconhecida)).

%staff - email desconhecido
evolucao_incerto(staff(Idstaff,Idcentro,Nome,EmailDesconhecido)) :-
        evolucaoIncerto(staff(Idstaff,Idcentro,Nome,EmailDesconhecido)),
        insercao(((excecao(staff(Ids,Idc,N,E))) :- staff(Ids,Idc,N,EmailDesconhecido))),
        insercao(incerto(staff(Istaff),EmailDesconhecido)).

involucao_incerto(staff(Idstaff,Idcentro,Nome,EmailDesconhecido)) :-
        involucaoIncerto(staff(Idstaff,Idcentro,Nome,EmailDesconhecido)),
        remocao(((excecao(staff(Ids,Idc,N,E))) :- staff(Ids,Idc,N,EmailDesconhecido))),
        remocao(incerto(staff(Istaff),EmailDesconhecido)).

%vacinacao_covid - vacina descohecida
evolucao_incerto(vacinacao_covid(Idstaff, Idutente, Data, VacinaDesconhecida, Toma)) :-
        evolucaoIncerto(vacinacao_covid(Idstaff, Idutente, Data, VacinaDesconhecida, Toma)),
        insercao(((excecao(vacinacao_covid(Ids, Idu, D, V, T))) :- vacinacao_covid(Ids, Idu, D, VacinaDesconhecida, T))),
        insercao(incerto(vacinacao_covid(Idstaff, Idutente, Data, VacinaDesconhecida, Toma),VacinaDesconhecida)).

involucao_incerto(vacinacao_covid(Idstaff, Idutente, Data, VacinaDesconhecida, Toma)) :-
        involucaoIncerto(vacinacao_covid(Idstaff, Idutente, Data, VacinaDesconhecida, Toma)),
        remocao(((excecao(vacinacao_covid(Ids, Idu, D, V, T))) :- vacinacao_covid(Ids, Idu, D, VacinaDesconhecida, T))),
        remocao(incerto(vacinacao_covid(Idstaff, Idutente, Data, VacinaDesconhecida, Toma),VacinaDesconhecida)).

%medico_familia - id centro de saude desconhecido
evolucao_incerto(medico_familia(Idmedico,Nome,Email,IdcentroDesconhecido)) :-
        evolucaoIncerto(medico_familia(Idmedico,Nome,Email,IdcentroDesconhecido)),
        insercao(((excecao(medico_familia(Idm,N,E,Idc))) :- medico_familia(Idm,N,E,IdcentroDesconhecido))),
        insercao(incerto(medico_familia(Idmedico),IdcentroDesconhecido)).

involucao_incerto(medico_familia(Idmedico,Nome,Email,IdcentroDesconhecido)) :-
        involucaoIncerto(medico_familia(Idmedico,Nome,Email,IdcentroDesconhecido)),
        remocao(((excecao(medico_familia(Idm,N,E,Idc))) :- medico_familia(Idm,N,E,IdcentroDesconhecido))),
        remocao(incerto(medico_familia(Idmedico),IdcentroDesconhecido)).

%consulta - descricao desconhecida
evolucao_incerto(consulta(Idconsulta,Idutente,Idmedico,DescricaoDesconhecida,Custo,Data)) :-
        evolucaoIncerto(consulta(Idconsulta,Idutente,Idmedico,DescricaoDesconhecida,Custo,Data)),
        insercao(((excecao(consulta(Idc,Idu,Idm,Desc,C,D))) :- consulta(Idc,Idu,Idm,DescricaoDesconhecida,C,D))),
        insercao(incerto(consulta(Idconsulta),DescricaoDesconhecida)).

involucao_incerto(consulta(Idconsulta,Idutente,Idmedico,DescricaoDesconhecida,Custo,Data)) :-
        involucaoIncerto(consulta(Idconsulta,Idutente,Idmedico,DescricaoDesconhecida,Custo,Data)),
        remocao(((excecao(consulta(Idc,Idu,Idm,Desc,C,D))) :- consulta(Idc,Idu,Idm,DescricaoDesconhecida,C,D))),
        remocao(incerto(consulta(Idconsulta),DescricaoDesconhecida)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Evolução do conhecimento interdito
%consulta
evolucao_interdito(consulta(Idconsulta,Idutente,Idmedico,DescricaoInterdita,Custo,Data)) :-
     evolucaoIncerto(consulta(Idconsulta,Idutente,Idmedico,DescricaoInterdita,Custo,Data)),
     insercao((excecao(consulta(Idc,Idu,Idm,Desc,C,D)):- consulta(Idc,Idu,Idm,DescricaoInterdita,C,D))),
     insercao(nulo(DescricaoInterdita)),
     insercao(interdito(consulta(Idutente))),
     insercao(+consulta(_,_,_,_,_,_) :: (solucoes(D,
                                         (consulta(Idconsulta,Idutente,Idmedico,D,Custo,Data),nao(nulo(D))),S),
                                         comprimento(S,0))).

involucao_interdito(consulta(Idconsulta,Idutente,Idmedico,DescricaoInterdita,Custo,Data)) :- 
    involucaoIncerto(consulta(Idconsulta,Idutente,Idmedico,DescricaoInterdita,Custo,Data)),
    remocao((excecao(consulta(Idc,Idu,Idm,Desc,C,D)):- consulta(Idc,Idu,Idm,DescricaoInterdita,C,D))),
    remocao(nulo(DescricaoInterdita)),
    remocao(interdito(consulta(Idutente))),
    remocao(+consulta(_,_,_,_,_,_) :: (solucoes(D,(consulta(Idconsulta,Idutente,Idmedico,D,Custo,Data),nao(nulo(D))),S),
                                       comprimento(S,0))).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Evolução do conhecimento impreciso
%consulta
evolucao_impreciso(consulta(Idconsulta,Idutente,Idmedico,DescricaoImprecisa,Custo,Data)) :-
        insercao(impreciso(consulta(Idconsulta))),
        evolucaoImpreciso(consulta(Idconsulta,Idutente,Idmedico,DescricaoImprecisa,Custo,Data)).

involucao_impreciso(consulta(Idconsulta,Idutente,Idmedico,DescricaoImprecisa,Custo,Data)) :-
        remocao(impreciso(consulta(Idconsulta))),
        remocao(excecao(consulta(Idconsulta,Idutente,Idmedico,DescricaoImprecisa,Custo,Data))).


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
+utente(_,_,_,_,_,_,_,_,_,IdCentro,Idmedico) :: 
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
        (nao(incerto(utente(Idutente),Incerteza)),
        nao(impreciso(utente(Idutente))),
        nao(interdito(utente(Idutente)))).

+centro_saude(Idcentro,_,_,_,_) :.:
        (nao(incerto(centro_saude(Idcentro),Incerteza)),
        nao(impreciso(centro_saude(Idcentro))),
        nao(interdito(centro_saude(Idcentro)))).

+staff(Idstaff,_,_,_) :.:
        (nao(incerto(staff(Idstaff),Incerteza)),
        nao(impreciso(staff(Idstaff))),
        nao(interdito(staff(Idstaff)))).

+vacinacao_covid(Idstaff,Idutente,_,_,_) :.:
        (nao(incerto(vacinacao_covid(Idstaff,Idutente),Incerteza)),
        nao(impreciso(vacinacao_covid(Idstaff,Idutente))),
        nao(interdito(vacinacao_covid(Idstaff,Idutente)))).

+medico_familia(Idmedico,_,_,_) :.:
        (nao(incerto(medico_familia(Idmedico),Incerteza)),
        nao(impreciso(medico_familia(Idmedico))),
        nao(interdito(medico_familia(Idmedico)))).

+consulta(Idconsulta,_,_,_,_,_) :.:
        (nao(incerto(consulta(Idconsulta),Incerteza)),
        nao(impreciso(consulta(Idconsulta))),
        nao(interdito(consulta(Idconsulta)))).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes de adição de conhecimento impreciso
% Não é possível adicionar conhecimento impreciso se já existir conhecimento incerto ou interdito
+utente(Idutente,_,_,_,_,_,_,_,_,_,_) :..: 
        (nao(incerto(utente(Idutente),Incerteza)),
         nao(interdito(utente(Idutente)))).

+centro_saude(Idcentro,_,_,_,_) :..:
        (nao(incerto(centro_saude(Idcentro),Incerteza)),
         nao(interdito(centro_saude(Idcentro)))).

+staff(Idstaff,_,_,_) :..:
        (nao(incerto(staff(Idstaff),Incerteza)),
         nao(interdito(staff(Idstaff)))).

+vacinacao_covid(Idstaff,Idutente,_,_,_) :..:
        (nao(incerto(vacinacao_covid(Idstaff,Idutente),Incerteza)),
         nao(interdito(vacinacao_covid(Idstaff,Idutente)))).

+medico_familia(Idmedico,_,_,_) :..:
        (nao(incerto(medico_familia(Idmedico),Incerteza)),
         nao(interdito(medico_familia(Idmedico)))).

+consulta(Idconsulta,_,_,_,_,_) :..:
        (nao(incerto(consulta(Idconsulta),Incerteza)),
         nao(interdito(consulta(Idconsulta)))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%---- Registos
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% utente
registarUtente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico) :-
    evolucao(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)),
    insercao(perfeito(utente(Idutente))).

% centro_saude
registarCentro(Id,Nome,Morada,Telefone,Email) :-
    evolucao(centro_saude(Id,Nome,Morada,Telefone,Email)),
    insercao(perfeito(centro_saude(Id))).

% staff
registarStaff(Idstaff,Idcentro,Nome,Email) :-
    evolucao(staff(Idstaff,Idcentro,Nome,Email)),
    insercao(perfeito(staff(Idstaff))).

% vacinacao_covid
registarVacinacao(Idstaff,Idutente,Data,Vacina,Toma) :-
    evolucao(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)),
    insercao(perfeito(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma))).

% medico_familia
registarMedico(Idmedico,Nome,Email,IdCentro):-
    evolucao(medico_familia(Idmedico,Nome,Email,IdCentro)),
    insercao(perfeito(medico_familia(Idmedico))).

%consulta
registarConsulta(Idconsulta,IdUtente,IdMedico,Descricao,Custo,Data):-
    evolucao(consulta(Idconsulta,IdUtente,IdMedico,Descricao,Custo,Data)),
    insercao(perfeito(consulta(Idconsulta))).

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
    remocao(perfeito(utente(Idutente))),
    utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico),
    involucao(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)).

% centro_saude
removerCentro(Idcentro) :-
    perfeito(centro_saude(IdUtente)),
    remocao(perfeito(centro_saude(IdUtente))),
    centro_saude(Idcentro,Nome,Morada,Telefone,Email),
    involucao(centro_saude(Idcentro,Nome,Morada,Telefone,Email)).

% staff
removerStaff(Idstaff) :-
    perfeito(staff(Idstaff)),
    remocao(perfeito(staff(Idstaff))),
    staff(Idstaff,Idcentro,Nome,Email),
    involucao(staff(Idstaff,Idcentro,Nome,Email)).

% vacinacao_covid
removerVacinacao(Idstaff,Idutente,Data,Vacina,Toma) :-
    perfeito(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)),
    remocao(perfeito(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma))),
    involucao(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).

% medico_familia
removerMedico(Idmedico) :-
    perfeito(medico_familia(IdMedico)),
    remocao(perfeito(medico_familia(IdMedico))),
    medico_familia(Idmedico,Nome,Email,IdCentro),
    involucao(medico_familia(Idmedico,Nome,Email,IdCentro)).

% consulta
removerConsulta(Idconsulta) :-
    perfeito(consulta(IdConsulta)),
    remocao(perfeito(consulta(IdConsulta))),
    consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data),
    involucao(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Remoções incerto
% utente
removerUtente(Idutente) :-
    incerto(utente(Idutente),_),
    utente(Idutente,NISS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico),
    involucao_incerto(utente(Idutente,NISS,Nome,DataNasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)).

% centro_saude
removerCentro(Idcentro) :-
    incerto(centro_saude(IdUtente),_),
    centro_saude(Idcentro,Nome,Morada,Telefone,Email),
    involucao_incerto(centro_saude(Idcentro,Nome,Morada,Telefone,Email)).

% staff
removerStaff(Idstaff) :-
    incerto(staff(Idstaff),_),
    staff(Idstaff,Idcentro,Nome,Email),
    involucao_incerto(staff(Idstaff,Idcentro,Nome,Email)).

% vacinacao_covid
removerVacinacao(Idstaff,Idutente,Data,Vacina,Toma) :-
    incerto(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma),_),
    involucao_incerto(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).

% medico_familia
removerMedico(Idmedico) :-
    incerto(IdMedico,_),
    medico_familia(Idmedico,Nome,Email,IdCentro),
    involucao_incerto(medico_familia(Idmedico,Nome,Email,IdCentro)).

% consulta
removerConsulta(Idconsulta) :-
    incerto(IdConsulta,_),
    consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data),
    involucao_incerto(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Remoções interdito
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
    excecao(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)),
    involucao_impreciso(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)).

% centro_saude
removerCentro(Idcentro) :-
    impreciso(centro_saude(IdUtente)),
    excecao(centro_saude(Idcentro,Nome,Morada,Telefone,Email)),
    involucao_impreciso(centro_saude(Idcentro,Nome,Morada,Telefone,Email)).

% staff
removerStaff(Idstaff) :-
    impreciso(staff(Idstaff)),
    excecao(staff(Idstaff,Idcentro,Nome,Email)),
    involucao_impreciso(staff(Idstaff,Idcentro,Nome,Email)).

% vacinacao_covid
removerVacinacao(Idstaff,Idutente,Data,Vacina,Toma) :-
    impreciso(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)),
    involucao_impreciso(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)).

% medico_familia
removerMedico(Idmedico) :-
    impreciso(IdMedico),
    excecao(medico_familia(Idmedico,Nome,Email,IdCentro)),
    involucao_impreciso(medico_familia(Idmedico,Nome,Email,IdCentro)).

% consulta
removerConsulta(Idconsulta) :-
    impreciso(IdConsulta),
    excecao(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)),
    involucao_impreciso(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)).

