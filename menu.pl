% ------------------------------ Menu ------------------------------------------

menu:- write('\n'),
       write('-----------MENU-------------\n'),
       write('\n'),
       write('-----------Insert-----------\n'),
       write('1.Registar Utente \n'),
       write('2.Registar Centro de Saúde \n'),
       write('3.Registar Elemento do Staff \n'),
       write('4.Registar Vacinação \n'),
       write('\n'),
       write('-----------Delete-----------\n'),
       write('5.Apagar Utente \n'),
       write('6.Apagar Centro de Saúde \n'),
       write('7.Apagar Elemento do Staff \n'),
       write('8.Apagar Vacinação \n'),
       write('\n'),
       write('0.Sair \n'),
       read(Option),
       executar(Option).

executar(Option):-Option =:=1,addUtente,menu;
                  Option =:=2,addCentro,menu;
                  Option =:=3,addStaff,menu;
                  Option =:=4,addVacinacao,menu;
                  Option =:=5,deleteUtente,menu;
                  Option =:=6,deleteCentro,menu;
                  Option =:=7,deleteStaff,menu;
                  Option =:=8,deleteVacinacao,menu;
                  Option =:=0,true,write('Goodbye.').

/*-------------------------------- INSERÇÕES -------------------------------- */

addUtente:-write('Id Utente: '),read(Idutente),
                 write('NSS: '),read(NISS),
                 write('Nome: '),read(Nome),
                 write('Data de Nascimento: '),read(Data_Nasc),
                 write('Email: '),read(Email),
                 write('Telefone: '),read(Telefone),
                 write('Morada: '),read(Morada),
                 write('Profissao: '),read(Profissao),
                 write('Lista de doenças crónicas: '),read(DoencasCronicas),
                 write('Id Centro de Saude: '),read(IdCentro),
                 registarUtente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro). 

addCentro:-write('Id Centro de Saúde: '),read(Id),
                 write('Nome: '),read(Nome),
                 write('Morada'),read(Morada),
                 write('Telefone: '),read(Telefone),
                 write('E-mail: '),read(Email),
                registarCentro(IdServ,Especialidade,Instituicao,Cidade).

addStaff:-write('Id Staff: '),read(IdStaff),
                 write('Id Centro: '),read(IdCentro),
                 write('Nome: '),read(Nome),
                 write('Email'),read(Email),
                 registarStaff(IdConsult,IdUt,IdPrestador,IdServ,Descricao,Custo,Data).

addVacinacao:-write('Id Staff: '),read(IdStaff),
                   write('Id Utente: '),read(Idutente),
                   write('Data: '),read(Data),
                   write('Vacina: '),read(Vacina),
                   write('Toma: '),read(Toma),
                   registarVacinacao(Idstaff,Idutente,Data,Vacina,Toma).


/*------------------------------- REMOÇÕES ---------------------------------- */

deleteUtente:-   write('Id Utente: '),read(Idutente),
                 write('NSS: '),read(NISS),
                 write('Nome: '),read(Nome),
                 write('Data de Nascimento: '),read(Data_Nasc),
                 write('Email: '),read(Email),
                 write('Telefone: '),read(Telefone),
                 write('Morada: '),read(Morada),
                 write('Profissao: '),read(Profissao),
                 write('Lista de doenças crónicas: '),read(DoencasCronicas),
                 write('Id Centro de Saude: '),read(IdCentro),
                 removerUtente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro).


deleteCentro :-  write('Id Centro de Saúde: '),read(Id),
                 write('Nome: '),read(Nome),
                 write('Morada'),read(Morada),
                 write('Telefone: '),read(Telefone),
                 write('E-mail: '),read(Email),
                 removerCentro(IdServ,Especialidade,Instituicao,Cidade).


deleteStaff:- write('Id Staff: '),read(IdStaff),
              write('Id Centro: '),read(IdCentro),
              write('Nome: '), read(Nome),
              write('Email: '),read(Email),
              removerStaff(Idstaff,Idcentro,Nome,Email).


deleteVacinacao:-  write('Id Staff: '),read(IdStaff),
                   write('Id Utente: '),read(Idutente),
                   write('Data: '),read(Data),
                   write('Vacina: '),read(Vacina),
                   write('Toma: '),read(Toma),
                   removerVacinacao(Idstaff,Idutente,Data,Vacina,Toma).

