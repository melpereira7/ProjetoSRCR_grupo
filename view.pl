% Visualização da interface

:- consult(evolucao).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Declaracoes iniciais

:- style_check(-singleton).
:- style_check(-discontiguous).
:- set_prolog_flag(w:unknown,fail).


% ------------------------------ Menu ------------------------------------------

menu:- write('\n'),
       write('-----------MENU-------------\n'),
       write('\n'),
       write('-----------Inserir Conhecimento Perfeito-----------\n'),
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
       write('-----------Inserir Conhecimento Imperfeito-----------\n'), 
       write('28.Registar utente com nome desconhecido\n'), 
       write('29.Registar Centro de Saúde com morada desconhecida\n'), 
       write('30.Registar Elemento do Staff com e-mail desconhecido\n'), 
       write('31.Registar Vacinação com vacina desconhecida\n'), 
       write('32.Registar médico de família com centro de saúde desconhecido\n'), 
       write('33.Registar Consulta com descrição desconhecido\n'),  
       write('34.Registar Consulta com descrição interdita\n'), 
       write('35.Registar Consulta com descrição imprecisa\n'), 
       write('0.Sair \n'),
       write('>> '),
       read(Option),
       executar(Option).

executar(1) :- addUtente,menu.
executar(2) :- addCentro,menu.
executar(3) :- addStaff,menu.
executar(4) :- addVacinacao,menu.
executar(5) :- addMedico,menu.
executar(6) :- addConsulta,menu.
executar(7) :- deleteUtente,menu.
executar(8) :- deleteCentro,menu.
executar(9) :- deleteStaff,menu.
executar(10) :- deleteVacinacao,menu.
executar(11) :- deleteMedico,menu.
executar(12) :- deleteConsulta,menu.
executar(13) :- consultCustoConsulta,menu.
executar(14) :- consultPessoaVacinada,menu.
executar(15) :- consultPessoaNaoVacinada,menu.
executar(16) :- consultFaseVacinacao,menu.
executar(17) :- consultCandidataVacinacao,menu.
executar(18) :- consultSegundaToma,menu.
executar(19) :- consultVacinadaInfevidamente,menu.
executar(20) :- listagemMedicosPorCentro,menu.
executar(21) :- listagemUtentesPorCentro,menu.
executar(22) :- listagemStaffPorCentro,menu.
executar(23) :- listagemPessoasNaoVacinadas,menu.
executar(24) :- listagemVacinadas,menu.
executar(25) :- listagemVacinadasIndevidamente,menu.
executar(26) :- listagemPessoasCandidatas,menu.
executar(27) :- listagemPessoasSemSegundaToma,menu.
executar(28) :- addUtentedesconhecido,menu.
executar(29) :- addCentrodesconhecido,menu.
executar(30) :- addStaffdesconhecido,menu.
executar(31) :- addVacinacaodesconhecido,menu.
executar(32) :- addMedicodesconhecido,menu.
executar(33) :- addConsultaincerto,menu.
executar(34) :- addConsultaimpreciso,menu.
executar(35) :- addConsultainterdito,menu.
executar(99) :- make,menu.
executar(0) :- write('Goodbye.\n'),halt.
executar(X).


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
             registarUtente(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico)).
             %ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n'])). 

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
               write('\nId de consulta já existente!\nTente novamente.\n');
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

/* ------------------------------- INCERÇÕES IMPERFEITAS ---------------------------------- */
addUtentedesconhecido :- write('Id Utente: '),read(Idutente), (utente(Idutente),
                         write('\nId de utente já existente!\nTente novamente.\n');
                         nao(utente(Idutente)),
                         write('NSS: '),read(NISS),
                         write('Data de Nascimento: (no formato date(Ano,Mes,Dia)'),read(Data_Nasc),
                         write('Email (entre plicas): '),read(Email),
                         write('Telefone: '),read(Telefone),
                         write('Morada (entre plicas): '),read(Morada),
                         write('Profissao (entre plicas): '),read(Profissao),
                         write('Lista de doenças crónicas (no formato [doença1,doença2,...] ou [] se nenhuma): '),read(DoencasCronicas),
                         write('Id Centro de Saúde: '),read(Idcentro),
                         write('Id Médico de Família: '),read(Idmedico),
                         string_concat(nomedesconhecido, Idutente, Nome),
                         registarUtenteIncerto(Idutente,NISS,Nome,Data_Nasc,Email,Telefone,Morada,Profissao,DoencasCronicas,Idcentro,Idmedico),
                         ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n'])). 

addCentrodesconhecido :- write('Id Centro de Saúde: '), read(Idcentro), (centro_saude(Idcentro),
                         write('\nId do Centro de Saúde já existente!\nTente novamente.\n');
                         nao(centro_saude(Idcentro)),
                         write('Nome (entre plicas): '),read(Nome),
                         string_concat(morada, Idcentro, Morada),
                         write('Telefone: '),read(Telefone),
                         write('E-mail (entre plicas): '),read(Email),
                         registarCentroIncerto(Idcentro,Nome,Morada,Telefone,Email),
                         ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n'])).

addStaffdesconhecido :- write('Id Staff: '),read(Idstaff), (staff(Idstaff),
                        write('\nId de Staff já existente!\nTente novamente.\n');
                        nao(staff(Idstaff)),
                        write('Id Centro: '),read(Idcentro),
                        write('Nome (entre plicas): '),read(Nome),
                        string_concat(mail, Idstaff, Email),
                        registarStaffIncerto(Idstaff,Idcentro,Nome,Email),
                        ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n'])).

addVacinacaodesconhecido :- write('Id Staff: '),read(Idstaff), 
                            write('Id Utente: '),read(Idutente),
                            write('Data (no formato date(Ano,Mes,Dia)): '),read(Data),
                            string_concat(vacina, Idstaff, AAAA), stingconcat(AAA, Idutente, Vacina),
                            write('Toma: '),read(Toma),
                            registarVacinacaoIncerta(Idstaff,Idutente,Data,Vacina,Toma),
                            ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n']).

addMedicodesconhecido :- write('Id Médico: '), read(Idmedico), (medico_familia(Idmedico),
                         write('\nId de médico já existente!\nTente novamente.\n');
                         nao(medico_familia(Idmedico)),
                         write('Nome (entre plicas): '),read(Nome),
                         write('Email (entre plicas): '),read(Email),
                         string_concat(centro, Idmedico, Idcentro),
                         registarMedicoIncerto(Idmedico,Nome,Email,Idcentro),
                         ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n'])).

addConsultaincerto :- write('Id Consulta: '), read(Idconsulta), (consulta(Idconsulta),
                       write('\nId de consulta já existente!\nTente novamente.\n');
                       nao(consulta(Idconsulta)),
                       write('Id Utente: '),read(Idutente),
                       write('Id Médico: '),read(Idmedico),
                       string_concat(descricaoInc, Idconsulta, Descricao),
                       write('Custo da consulta: '), read(Custo),
                       write('Data da consulta (no formato date(Ano,Mes,Dia): '), read(Data),
                       registarConsultaIncerto(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data),
                       ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n'])).

addConsultaimpreciso :- write('Id Consulta: '), read(Idconsulta), (consulta(Idconsulta),
                         write('\nId de consulta já existente!\nTente novamente.\n');
                         nao(consulta(Idconsulta)),
                         write('Id Utente: '),read(Idutente),
                         write('Id Médico: '),read(Idmedico),
                         string_concat(descricaoImp, Idconsulta, Descricao),
                         write('Custo da consulta: '), read(Custo),
                         write('Data da consulta (no formato date(Ano,Mes,Dia): '), read(Data),
                         evolucao_impreciso(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)),
                         ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n'])).

addConsultainterdito :- write('Id Consulta: '), read(Idconsulta), (consulta(Idconsulta),
                         write('\nId de consulta já existente!\nTente novamente.\n');
                         nao(consulta(Idconsulta)),
                         write('Id Utente: '),read(Idutente),
                         write('Id Médico: '),read(Idmedico),
                         string_concat(descricaoInt, Idconsulta, Descricao),
                         write('Custo da consulta: '), read(Custo),
                         write('Data da consulta (no formato date(Ano,Mes,Dia): '), read(Data),
                         evolucao_interdito(consulta(Idconsulta,Idutente,Idmedico,Descricao,Custo,Data)),
                         ansi_format([bold,fg(green)], 'Sucesso! ~w', ['\n'])).