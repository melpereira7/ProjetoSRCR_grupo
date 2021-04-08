%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definições iniciais

%Invariantes Regular
:- op(900,xfy,'::').


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