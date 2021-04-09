% Visualização da interface

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Declaracoes iniciais

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).


% ------------------------------ Menu ------------------------------------------

menu:- write('\n'),
       write('-----------MENU-------------\n'),
       write('\n'),
       write('-----------Inserir-----------\n'),
       write('1.Registar Utente \n'),
       write('2.Registar Centro de Saúde \n'),
       write('3.Registar Elemento do Staff \n'),
       write('4.Registar Vacinação \n'),
       write('5.Registar Médico de Família \n'),
       write('6.Registar Consulta \n'),
       write('-----------Remover-----------\n'),
       write('7.Remover Utente \n'),
       write('8.Remover Centro de Saúde \n'),
       write('9.Remover Elemento do Staff \n'),
       write('10.Remover Vacinação \n'),
       write('11.Remover Médico de Família\n'),
       write('12.Remover Consulta\n'),
       write('-----------Consultar-----------\n'),
       write('13.Custo total de consultas por utente\n'),
       write('14.Consultar se um utente já foi vacinado\n'),
       write('15.Consultar se um utente ainda não foi vacinado\n'),
       write('16.Consultar em que fase vai ser vacinado\n'),
       write('17.Consultar candidata em vacinação na fase a decorrer\n'),
       write('18.Consultar se a pessoa ainda não tem a 2ª dose\n'),
       write('19.Consultar se a pessoa foi vacinada indevidamente\n'),
       write('-----------Listar-----------\n'),
       write('20.Listar os médicos por centro de saúde\n'), 
       write('21.Listar os utentes por centro de saúde\n'), 
       write('22.Listar o staff por centro de saúde\n'), 
       write('23.Listar as pessoas não vacinadas\n'), 
       write('24.Listar as pessoas vacinadas\n'), 
       write('25.Listar as pessoas vacinadas indevidamente\n'), 
       write('26.Listar as pessoas candidatas a vacinação\n'), 
       write('27.Listar as pessoas a quem falta a segunda toma\n'), 
       write('0.Sair \n'),
       write('>> '),
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
                  Option=:=13,consultCustoConsulta,menu;
                  Option=:=14,consultPessoaVacinada,menu;
                  Option=:=15,consultPessoaNaoVacinada,menu;
                  Option=:=16,consultFaseVacinacao,menu;
                  Option=:=17,consultCandidataVacinacao,menu;
                  Option=:=18,consultSegundaToma,menu;
                  Option=:=19,consultVacinadaInfevidamente,menu;
                  Option=:=20,listagemMedicosPorCentro,menu;
                  Option=:=21,listagemUtentesPorCentro,menu;
                  Option=:=22,listagemStaffPorCentro,menu;
                  Option=:=23,listagemPessoasNaoVacinadas,menu;
                  Option=:=24,listagemVacinadas,menu;
                  Option=:=25,listagemVacinadasIndevidamente,menu;
                  Option=:=26,listagemPessoasCandidatas,menu;
                  Option=:=27,listagemPessoasSemSegundaToma,menu;
                  Option=:=99,true,make,menu;
                  Option=:=0,true,write('Goodbye.\n'),halt.


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
             ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n'])). 

addCentro :- write('Id Centro de Saúde: '), read(Idcentro), (centro_saude(Idcentro),
             write('\nId do Centro de Saúde já existente!\nTente novamente.\n');
             nao(centro_saude(Idcentro)),
             write('Nome (entre plicas): '),read(Nome),
             write('Morada (entre plicas): '),read(Morada),
             write('Telefone: '),read(Telefone),
             write('E-mail (entre plicas): '),read(Email),
             registarCentro(Idcentro,Nome,Morada,Telefone,Email),
             ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n'])).

addStaff :- write('Id Staff: '),read(Idstaff), (staff(Idstaff),
            write('\nId de Staff já existente!\nTente novamente.\n');
            nao(staff(Idstaff)),
            write('Id Centro: '),read(Idcentro),
            write('Nome (entre plicas): '),read(Nome),
            write('Email (entre plicas): '),read(Email),
            registarStaff(Idstaff,Idcentro,Nome,Email),
            ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n'])).

addVacinacao :- write('Id Staff: '),read(Idstaff), 
                write('Id Utente: '),read(Idutente),
                write('Data (no formato date(Ano,Mes,Dia)): '),read(Data),
                write('Vacina (entre plicas): '),read(Vacina),
                write('Toma: '),read(Toma),
                registarVacinacao(Idstaff,Idutente,Data,Vacina,Toma),
                ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n']).

addMedico :- write('Id Médico: '), read(Idmedico), (medico_familia(Idmedico),
             write('\nId de médico já existente!\nTente novamente.\n');
             nao(medico_familia(Idmedico)),
             write('Nome (entre plicas): '),read(Nome),
             write('Email (entre plicas): '),read(Email),
             write('Id Centro: '),read(Idcentro),
             registarMedico(Idmedico,Nome,Email,Idcentro),
             ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n'])).

addConsulta :- write('Id Consulta: '), read(Idconsulta), (consulta(Idconsulta),
               write('\nId de médico já existente!\nTente novamente.\n');
               nao(consulta(Idconsulta)),
               write('Id Utente: '),read(Idutente),
               write('Id Médico: '),read(Idmedico),
               write('Descrição do motivo da consulta  (entre plicas): '), read(Descricao),
               write('Custo da consulta: '), read(Custo),
               write('Data da consulta (no formato date(Ano,Mes,Dia): '), read(Data),
               registarConsulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data),
               ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n'])).


/* ------------------------------- REMOÇÕES ---------------------------------- */

deleteUtente :- write('Id Utente: '),read(Idutente),
                removerUtente(Idutente),
                ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n']).

deleteCentro :- write('Id Centro de Saúde: '),read(Idcentro),
                removerCentro(Idcentro),
                ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n']).

deleteStaff :- write('Id Staff: '),read(Idstaff),
               removerStaff(Idstaff),
               ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n']).

deleteVacinacao :- write('Id Staff: '),read(Idstaff),
                   write('Id Utente: '),read(Idutente),
                   write('Data (no formato date(Ano,Mes,Dia)): '),read(Data),
                   write('Vacina (entre plicas): '),read(Vacina),
                   write('Toma: '),read(Toma),
                   removerVacinacao(Idstaff,Idutente,Data,Vacina,Toma),
                   ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n']).

deleteMedico:-write('Id médico: '), read(Idmedico),
              removerMedico(Idmedico),
              ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n']).

deleteConsulta:-write('Id Consulta: '),read(Idconsulta),
                  removerConsulta(Idconsulta),
                  ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n']).


/* ------------------------------- CONSULTAS ---------------------------------- */

consultCustoConsulta:-write('Id Utente: '),read(Idutente),
                      custo_consultas(Idutente, Total),
                      ansi_format([bold,fg(cyan)], 'Total: ~w€\n', [Total]).

consultPessoaVacinada:-write('Id Utente: '),read(Idutente),
                       ((si(vacinada(Idutente), verdadeiro),
                        ansi_format([bold,fg(green)], 'Verdadeiro ~w', ['\n']));
                       (si(vacinada(Idutente), falso),
                        ansi_format([bold,fg(red)], 'Falso ~w', ['\n']))).

consultPessoaNaoVacinada:-write('Id Utente: '),read(Idutente),
                       ((si(vacinada(Idutente), falso),
                        ansi_format([bold,fg(green)], 'Verdadeiro ~w', ['\n']));
                       (si(vacinada(Idutente), verdadeiro),
                        ansi_format([bold,fg(red)], 'Falso ~w', ['\n']))).

consultFaseVacinacao:-write('Id Utente: '),read(Idutente),
                      verificaFase(F, Idutente, _),
                      ansi_format([bold,fg(cyan)], 'Será vacinado na fase ~w\n', [F]).

consultCandidataVacinacao:-write('Id Utente: '),read(Idutente),
                       ((si(candidata(Idutente), verdadeiro),
                        ansi_format([bold,fg(green)], 'Verdadeiro ~w', ['\n']));
                       (si(candidata(Idutente), falso),
                        ansi_format([bold,fg(red)], 'Falso ~w', ['\n']))).

consultSegundaToma:-write('Id Utente: '),read(Idutente),
                       ((si(segunda_toma(Idutente), verdadeiro),
                        ansi_format([bold,fg(green)], 'Verdadeiro ~w', ['\n']));
                       (si(segunda_toma(Idutente), falso),
                        ansi_format([bold,fg(red)], 'Falso ~w', ['\n']))).

consultVacinadaInfevidamente:-write('Id Utente: '),read(Idutente),
                       ((si(vacinada_indevidamente(Idutente), verdadeiro),
                        ansi_format([bold,fg(green)], 'Verdadeiro ~w', ['\n']));
                       (si(vacinada_indevidamente(Idutente), falso),
                        ansi_format([bold,fg(red)], 'Falso ~w', ['\n']))).


/* ------------------------------- LISTAGEM ---------------------------------- */

listagemMedicosPorCentro:-centrosSaude(Centros), print(Centros),
                          write('Id Centro: '),read(CentroID),
                          medicosPorCentro(CentroID, Medicos),
                          ansi_format([bold,fg(cyan)], '~w\n', [Medicos]).

listagemUtentesPorCentro:-centrosSaude(Centros), print(Centros),
                          write('Id Centro: '),read(CentroID),
                          utentesPorCentro(CentroID, Utentes),
                          ansi_format([bold,fg(cyan)], '~w\n', [Utentes]).

listagemStaffPorCentro:-centrosSaude(Centros), print(Centros),
                          write('Id Centro: '),read(CentroID),
                          staffPorCentro(CentroID, Staff),
                          ansi_format([bold,fg(cyan)], '~w\n', [Staff]).

listagemPessoasNaoVacinadas:-naoVacinadas(Pessoas),
                             getNames(Pessoas,R),
                             ansi_format([bold,fg(cyan)], '~w\n', [R]).

listagemVacinadas :- vacinadas(S),
                     ansi_format([bold,fg(cyan)],'~w\n',[S]).

listagemVacinadasIndevidamente :- vacinadas_indevidamente(S),
                                  getNames(S,R),
                                  ansi_format([bold,fg(cyan)],'~w\n',[R]).

listagemPessoasCandidatas :- candidatas(S),
                             getNames(S,R),
                             ansi_format([bold,fg(cyan)],'~w\n',[R]).

listagemPessoasSemSegundaToma :- lista_segunda_toma(S),
                                 getNames(S,R),
                                 ansi_format([bold,fg(cyan)],'~w\n',[R]).