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
       write('5.Registar Médico de Família \n'),
       write('6.Registar Consulta \n'),
       write('\n'),
       write('-----------Delete-----------\n'),
       write('7.Apagar Utente \n'),
       write('8.Apagar Centro de Saúde \n'),
       write('9.Apagar Elemento do Staff \n'),
       write('10.Apagar Vacinação \n'),
       write('11.Apagar Médico de Família\n'),
       write('12.Apagar Consulta\n'),
       write('\n'),
       write('-----------Extras-----------\n'),
       write('13.Custo total de consultas por utente\n'), %nao esta implementado, ainda
       write('0.Sair \n'),
       read(Option),
       executar(Option).

executar(Option):-Option=:=1,addUtente,menu;
                  Option=:=2,addCentro,menu;
                  Option=:=3,addStaff,menu;
                  Option=:=4,addVacinacao,menu;
                  Option=:=5,addMedico,menu;
                  Option=:=6,addConsulta,menu;
                  Option=:=7,deleteUtente,menu;
                  Option=:=8,deleteCentro,menu;
                  Option=:=9,deleteStaff,menu;
                  Option=:=10,deleteVacinacao,menu;
                  Option=:=11,deleteMedico,menu;
                  Option=:=12,deleteConsulta,menu;
                  Option=:=0,true,write('Goodbye.').

/* -------------------------------- INSERÇÕES -------------------------------- */

addUtente :- write('Id Utente: '),read(Idutente), (utente(Idutente),
             write('\nId de utente já existente!\nTente novamente.\n');
             nao(utente(Idutente)),
             write('NSS: '),read(NISS),
             write('Nome (entre plicas): '),read(Nome),
             write('Data de Nascimento: (no formato date(Ano,Mes,Dia)'),read(Data_Nasc),
             write('Email (entre plicas): '),read(Email),
             write('Telefone: '),read(Telefone),
             write('Morada (entre plicas): '),read(Morada),
             write('Profissao (entre plicas): '),read(Profissao),
             write('Lista de doenças crónicas (no formato [doença1,doença2,...] ou [] se nenhuma): '),read(DoencasCronicas),
             write('Id Centro de Saúde: '),read(Idcentro),
             write('Id Médico de Família: '),read(Idmedico),
             registarUtente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico),
             write('Sucesso!')). 

addCentro :- write('Id Centro de Saúde: '), read(Idcentro), (centro_saude(Idcentro),
             write('\nId do Centro de Saúde já existente!\nTente novamente.\n');
             nao(centro_saude(Idcentro)),
             write('Nome (entre plicas): '),read(Nome),
             write('Morada (entre plicas): '),read(Morada),
             write('Telefone: '),read(Telefone),
             write('E-mail (entre plicas): '),read(Email),
             registarCentro(Idcentro,Nome,Morada,Telefone,Email),
             write('Sucesso!')).

addStaff :- write('Id Staff: '),read(Idstaff), (staff(Idstaff),
            write('\nId de Staff já existente!\nTente novamente.\n');
            nao(staff(Idstaff)),
            write('Id Centro: '),read(Idcentro),
            write('Nome (entre plicas): '),read(Nome),
            write('Email (entre plicas): '),read(Email),
            registarStaff(Idstaff,Idcentro,Nome,Email),
            write('Sucesso!')).

addVacinacao :- write('Id Staff: '),read(Idstaff), 
                write('Id Utente: '),read(Idutente),
                write('Data (no formato date(Ano,Mes,Dia)): '),read(Data),
                write('Vacina (entre plicas): '),read(Vacina),
                write('Toma: '),read(Toma),
                registarVacinacao(Idstaff,Idutente,Data,Vacina,Toma),
                write('Sucesso!').

addMedico :- write('Id Médico: '), read(Idmedico), (medico_familia(Idmedico),
             write('\nId de médico já existente!\nTente novamente.\n');
             nao(medico_familia(Idmedico)),
             write('Nome (entre plicas): '),read(Nome),
             write('Email (entre plicas): '),read(Email),
             write('Id Centro: '),read(Idcentro),
             registarMedico(Idmedico,Nome,Email,Idcentro),
             write('Sucesso!')).

addConsulta :- write('Id Consulta: '), read(Idconsulta), (consulta(Idconsulta),
               write('\nId de médico já existente!\nTente novamente.\n');
               nao(consulta(Idconsulta)),
               write('Id Utente: '),read(Idutente),
               write('Id Médico: '),read(Idmedico),
               write('Id Centro: '),read(Idcentro),
               write('Descrição do motivo da consulta  (entre plicas): '), read(Descricao),
               write('Custo da consulta: '), read(Custo),
               write('Data da consulta (no formato date(Ano,Mes,Dia): '), read(Data),
               registarConsulta(Idconsulta,Idutente,Idmedico,Idcentro,Descricao,Custo,Data),
               write('Sucesso!')).


/* ------------------------------- REMOÇÕES ---------------------------------- */

deleteUtente :- write('Id Utente: '),read(Idutente),
                removerUtente(Idutente),
                write('Sucesso!').

deleteCentro :- write('Id Centro de Saúde: '),read(Idcentro),
                removerCentro(Idcentro),
                write('Sucesso!').

deleteStaff :- write('Id Staff: '),read(Idstaff),
               removerStaff(Idstaff),
               write('Sucesso!').

deleteVacinacao :- write('Id Staff: '),read(Idstaff),
                   write('Id Utente: '),read(Idutente),
                   write('Data (no formato date(Ano,Mes,Dia)): '),read(Data),
                   write('Vacina (entre plicas): '),read(Vacina),
                   write('Toma: '),read(Toma),
                   removerVacinacao(Idstaff,Idutente,Data,Vacina,Toma),
                   write('Sucesso!').

deleteMedico:-write('Id médico: '), read(Idmedico),
              removerMedico(Idmedico),
                   write('Sucesso!').

deleteConsulta:-write('Id Consulta: '),read(Idconsulta),
                  removerConsulta(Idconsulta),
                   write('Sucesso!').
