vacinacao_covid(1,7,date(x001),'Astrazeneca',1).
excecao(vacinacao_covid(Staff,Utente,Data,Vacina,Toma)) :- vacinacao_covid(Staff,Utente,date(x001),Vacina,Toma).

medico_familia(14,'Luísa Maria',x002,8).
nulo(x002).
excecao(medico_familia(Medico,Nome,Email,Centro)) :- medico_familia(Medico,Nome,x002,Centro).
+medico_familia(_,_,_,_) :: (solucoes(Email,(medico_familia(14,'Luísa Maria',Email,8),nao(nulo(Email))),S),
                             comprimento(S,N),
                             N==0).


