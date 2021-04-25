% 'não forte' para os predicados das fontes de conhecimento
-utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissão,[Doencas_Cronicas],Idcentro,Idmedico) :- 
    nao(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissão,[Doencas_Cronicas],Idcentro,Idmedico)), 
    nao(excecao(utente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissão,[Doencas_Cronicas],Idcentro,Idmedico))).

-centro_saude(Idcentro,Nome,Morada,Telefone,Email) :- 
    nao(centro_saude(Idcentro,Nome,Morada,Telefone,Email)), 
    nao(excecao(centro_saude(Idcentro,Nome,Morada,Telefone,Email))).

-staff(Idstaff,Idcentro,Nome,Email) :- 
    nao(staff(Idstaff,Idcentro,Nome,Email)), 
    nao(excecao(centro_saude(Idstaff,Idcentro,Nome,Email))).

-vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma) :- 
    nao(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma)), 
    nao(excecao(vacinacao_covid(Idstaff,Idutente,Data,Vacina,Toma))).

-medico_familia(Idmedico,Nome,Email,Idcentro) :- 
    nao(medico_familia(Idmedico,Nome,Email,Idcentro)), 
    nao(excecao(medico_familia(Idmedico,Nome,Email,Idcentro))).

-consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data) :- 
    nao(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)), 
    nao(excecao(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data))).

% Representação de conhecimento negativo
-vacinacao_covid(8,9,date(2021,2,5),'AstraZeneca',1).


% Conhecimento incerto
vacinacao_covid(1,7,date(x001),'Astrazeneca',1).
excecao(vacinacao_covid(Staff,Utente,Data,Vacina,Toma)) :- vacinacao_covid(Staff,Utente,date(x001),Vacina,Toma).

% Conhecimento interdito
medico_familia(14,'Luísa Maria',x002,8).
nulo(x002).
excecao(medico_familia(Medico,Nome,Email,Centro)) :- medico_familia(Medico,Nome,x002,Centro).
+medico_familia(_,_,_,_) :: (solucoes(Email,(medico_familia(14,'Luísa Maria',Email,8),nao(nulo(Email))),S),
                             comprimento(S,N),
                             N==0).

% Conhecimento impreciso
excecao(consulta(12,7,13,'Consulta de rotina',15.00,date(2021,04,25))).
excecao(consulta(12,7,13,'Consulta de rotina',5.00,date(2021,04,25))).
excecao(consulta(12,7,13,'Marcação de exames rotineiros',15.00,date(2021,04,25))).
excecao(consulta(12,7,13,'Marcação de exames rotineiros',5.00,date(2021,04,25))).

