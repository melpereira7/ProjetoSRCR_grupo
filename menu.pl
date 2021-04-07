%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Declaracoes iniciais

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).

% ------------------------------ Menu ------------------------------------------

menu:- write('\n'),
       write('-----------MENU-------------\n'),
       write('\n'),
       write('-----------Insert-----------\n'),
       write('1.Registar Utente \n'),
       write('2.Registar Centro de Saúde \n'),
       write('3.Registar Elemento do Staff \n'),
       write('4.Registar Vacinação \n'),
       write('5.Registar Medico de Familia \n'),
       write('6.Registar Consulta \n'),
       write('\n'),
       write('-----------Delete-----------\n'),
       write('7.Apagar Utente \n'),
       write('8.Apagar Centro de Saúde \n'),
       write('9.Apagar Elemento do Staff \n'),
       write('10.Apagar Vacinação \n'),
       write('11.Apagar Medico \n'),
       write('12.Apagar Consulta\n'),
       write('\n'),
       write('-----------Extras-----------\n'),
       write('13.Custo total consultas por utente\n'), %nao esta implementado, ainda
       write('0.Sair \n'),
       read(Option),
       executar(Option).

executar(Option):-Option =:=1,addUtente,menu;
                  Option =:=2,addCentro,menu;
                  Option =:=3,addStaff,menu;
                  Option =:=4,addVacinacao,menu;
                  Option =:=5,addMedico,menu;
                  Option =:=6,addConsulta,menu;
                  Option =:=7,deleteUtente,menu;
                  Option =:=8,deleteCentro,menu;
                  Option =:=9,deleteStaff,menu;
                  Option =:=10,deleteVacinacao,menu;
                  Option =:=11,deleteMedico,menu;
                  Option =:=12,deleteConsulta,menu;
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
                 write('Email: '),read(Email),
                 registarStaff(IdConsult,IdUt,IdPrestador,IdServ,Descricao,Custo,Data).

addVacinacao:-write('Id Staff: '),read(IdStaff),
                   write('Id Utente: '),read(Idutente),
                   write('Data: '),read(Data),
                   write('Vacina: '),read(Vacina),
                   write('Toma: '),read(Toma),
                   registarVacinacao(Idstaff,Idutente,Data,Vacina,Toma).

addMedico:-write('Id médico:  '), read(IdMedico),
                 write('Nome: '),read(Nome),
                 write('Email: '),read(Email),
                 write('Id Centro: '),read(IdCentro),
                 registarMedico(IdMedico,Nome,Email,IdCentro).


addConsulta:-write('Id Consulta:  '),read(IdConsulta),
                  write('Id utente:  '),read(Idutente),
                  write('Id Médico:  '),read(IdMedico),
                  write('Id Centro.  '),read(IdCentro),
                  write('Descrição do motivo da consulta: '), read(Descricao),
                  write('Custo da consulta:  '), read(Custo),
                  write('Data da consulta:  '), read(Data),
                  registarConsulta(IdConsulta,IdUtente,IdMedico,IdCentro,Descricao,Custo,Data).



/*------------------------------- REMOÇÕES ---------------------------------- */

deleteUtente:-   write('Id Utente: '),read(Idutente),
                 removerUtente(Idutente).


deleteCentro :-  write('Id Centro de Saúde: '),read(IdServ),
                 removerCentro(IdServ).


deleteStaff:- write('Id Staff: '),read(IdStaff),
              removerStaff(IdStaff).

deleteVacinacao:-  write('Id Staff: '),read(IdStaff),
                   write('Id Utente: '),read(Idutente),
                   write('Data: '),read(Data),
                   write('Vacina: '),read(Vacina),
                   write('Toma: '),read(Toma),
                   removerVacinacao(Idstaff,Idutente,Data,Vacina,Toma).


deleteMedico:-write('Id médico:  '), read(IdMedico),
              removerMedico(IdMedico).


deleteConsulta:-write('Id Consulta:  '),read(IdConsulta),
                  write('Id utente:  '),read(Idutente),
                  write('Id Médico:  '),read(IdMedico),
                  write('Id Centro.  '),read(IdCentro),
                  write('Descrição do motivo da consulta: '), read(Descricao),
                  write('Custo da consulta:  '), read(Custo),
                  write('Data da consulta:  '), read(Data),
                  removerConsulta(IdConsulta,IdUtente,IdMedico,IdCentro,Descricao,Custo,Data).
