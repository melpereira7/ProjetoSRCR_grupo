%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de conhecimento (com exemplos arbitrários)

%utente: #Utente, Nº Segurança_Social, Nome, Data_Nasc, Email, Telefone, Morada, Profissão, [Doenças_Crónicas], #CentroSaúde, #MédicoDeFamília ↝ { 𝕍, 𝔽}
utente(1,21111111112,'Ana Murciellago',date(1930,1,1),'ana@gmail.com',911234567,'Braga','Médica',[],1,1).
perfeito(utente(1)).
utente(2,22111111112,'Maria do Olival',date(2001,11,5), 'maria@gmail.com',936484263 ,'Viana do Castelo', 'Professora', ['asma'],1,1).
perfeito(utente(2)).
utente(3,01234567890,'Igor Marcos',date(1989,8,20),'marcos.mendes@gmail.com',252252252,'R. Amaral 8499-852 São Mamede de Infesta','Agricultor',['hiv','hepatite'],3,2).
perfeito(utente(3)).
utente(4,11111111111,'Rebeca Tavares Marques',date(2009,8,10),'maia.lara@gmail.com',930643063,'Avenida St. Valentim Fonseca, nº 3, 94º Dir. 9794-701 Quarteira','Estudante',['tuberculose'],2,3).
perfeito(utente(4)).
utente(5,09876543210,'Yasmin Sara Leite de Borges',date(1989,4,19),'dinis91@pereira.info',236082002,'Avenida Leonardo Rodrigues, nº 2 3819-133 Aveiro','CEO Empresa de Marketing',['brucellosis','gripe canina'],4,4).
perfeito(utente(5)).
utente(6,66666666666,'José Aristoteles',date(1967,1,29),'exprimeiro@gov.pt',090909090,'Alameda','Engenheiro',[],9,9).
perfeito(utente(6)).
utente(7,12345652858,'Custódio Borges',date(1987,4,15),'custodio@sapo.pt',251252254,'Rua Esteves Vasto 23 Santo Tirso','Calceiteiro',['Hipertensão','Colesterol'],7,7).
perfeito(utente(7)).
utente(8,15615956260,'Francisco Carriço',date(1977,4,17),'carriçochico@yahoo.com',255256258,'Rua Professor Batata Aracena','Advogado',['Diabetes','Artrite'],8,8).
perfeito(utente(8)).
utente(9,30861910266,'Jacinta Barboza',date(1982,2,13),'jacibar@gmail.com',256257269,'Rua do Rei de Fafe, Fafe','Empresário',['Alzheimer','Doença crónica dos rins'],10,10).
perfeito(utente(9)).


%centro_saude: #Centro, Nome, Morada, Telefone, Email ↝ { 𝕍, 𝔽}
centro_saude(1,'USFVida+','Vila Verde',253123456,'usfvida+@hotmail.com').
perfeito(centro_saude(1)).
centro_saude(2,'UCSP Quarteira','Quarteira',244322111,'ucspquart@info.gmailcom').
perfeito(centro_saude(2)).
centro_saude(3,'USF infesta','São Mamede Infesta', 254254252,'centrosaude@gmail.com').
perfeito(centro_saude(3)).
centro_saude(4,'USF MOLICEIRO', 'Aveiro', 2512522523, 'aveirocsaude@saude.com').
perfeito(centro_saude(4)).
centro_saude(5,'CS Penha de Franhça', 'Rua Luís Pinto Moitinho,5 Lisboa', 224322123, 'cspenhafranca@gmail.com').
perfeito(centro_saude(5)).
centro_saude(6,'Centro de Saude Caldas da Rainha', 'Rua do Centro de Saude, Caldas da Rainha', 2412422423,'caldasofthequeen@gmail.com').
perfeito(centro_saude(6)).
centro_saude(7,'Centro Saúde Lousã', 'Alameda Juiz Conselheiro Nunes Ribeiro, Vilarinho',232123123,'vilarinholsa@minsaude.com').
perfeito(centro_saude(7)).
centro_saude(8,'Centro de Saúde S.Pedro do Sul','Avenida da Ponte, São Pedro do Sul',224123412, 'saintpetersouth@minsaude.com').
perfeito(centro_saude(8)).
centro_saude(9,'Centro Saúde Ovar', 'Rua Dr. Francisco Zagalo s/n, OVAR', 245245245,'ovarhashealth@minsaude.com').
perfeito(centro_saude(9)).
centro_saude(10,'Centro de Saude Almodovar','Rua Professor Dr Fernando Padua, ALMODOVAR', 263264265,'almodovaralmodovar@minsaude.com').
perfeito(centro_saude(10)).


%staff: #Staff, #Centro, Nome, email ↝ { 𝕍, 𝔽 }
staff(1,1,'Maria Silva','maria@gmail.com').
perfeito(staff(1)).
staff(2,1,'Joana Guerra','joana@gmail.com').
perfeito(staff(2)).
staff(3,1,'Miguel Santos', 'santosmiguel@gmail.com').
perfeito(staff(3)).
staff(4,2,'Mario Sergio', 'sergiomario@gmail.com').
perfeito(staff(4)).
staff(5,2,'Ricardo Salgado','salgadoricardo@bancoes.com').
perfeito(staff(5)).
staff(6,3,'Joana Vasconcelos', 'arte@gmail.com').
perfeito(staff(6)).
staff(7,4,'Pedro Granger', 'apresentador@rtp.pt').
perfeito(staff(7)).
staff(8,5,'Luis Magalhaes', 'luismagalean@saudept.pt').
perfeito(staff(8)).
staff(9,6,' Mario Carvalhal', 'carvalhal@braga.pt').
perfeito(staff(9)).
staff(10,7,'Sergio Pedro', 'pedrosergio@cso.pt').
perfeito(staff(10)).
staff(11,8,'Ana Silva', 'anasilva123@sapo.pt').
perfeito(staff(11)).
staff(12,8,'Ricardo Tomé', 'riccardoootome@yahoo.com').
perfeito(staff(12)).
staff(13,9,'Tiago Xavier', 'xavy99gem@riot.com').
perfeito(staff(13)).
staff(14,7,'Miguel Tavares', 'miguelsousatavares@tvi.pt').
perfeito(staff(14)).
staff(15,10,'Sophia Anderson', 'sophiamellobryner@denmark.de').
perfeito(staff(15)).


%vacinacao_covid: #Staff, #Utente, Data, Vacina, Toma↝ { 𝕍, 𝔽 }
vacinacao_covid(1,1,date(2021,2,1),'Pfizer',1).
perfeito(vacinacao_covid(1,1,date(2021,2,1),'Pfizer',1)).
vacinacao_covid(2,1,date(2021,2,16),'Pfizer',2).
perfeito(vacinacao_covid(2,1,date(2021,2,16),'Pfizer',2)).
vacinacao_covid(1,2,date(2021,2,28),'Pfizer',1).                %vacinada indevidamente e falta segunda toma
perfeito(vacinacao_covid(1,2,date(2021,2,28),'Pfizer',1)).                %vacinada indevidamente e falta segunda toma
vacinacao_covid(6,3,date(2021,3,20),'AstraZeneca',1).
perfeito(vacinacao_covid(6,3,date(2021,3,20),'AstraZeneca',1)).
vacinacao_covid(4,4,date(2021,3,17),'Pfizer',1).
perfeito(vacinacao_covid(4,4,date(2021,3,17),'Pfizer',1)).
vacinacao_covid(5,4,date(2021,4,1),'Pfizer',2).
perfeito(vacinacao_covid(5,4,date(2021,4,1),'Pfizer',2)).
vacinacao_covid(6,3,date(2021,4,10),'AstraZeneca',2).
perfeito(vacinacao_covid(6,3,date(2021,4,10),'AstraZeneca',2)).
vacinacao_covid(7,6,date(2021,2,5),'AstraZeneca',1).            %vacinada indevidamente
perfeito(vacinacao_covid(7,6,date(2021,2,5),'AstraZeneca',1)).            %vacinada indevidamente


%medico_familia: #Medico,Nome,Email,#Centro ↝ { 𝕍, 𝔽 }
medico_familia(1,'Carlos Estevão','carlitos@gmail.com',1).
perfeito(medico_familia(1)).
medico_familia(2,'Maria Silvana','silvana@gmail.com',3).
perfeito(medico_familia(2)).
medico_familia(3,'Rogério Magalhães','magalhaes@gmail.com',2).
perfeito(medico_familia(3)).
medico_familia(4,'Luis Ricciardi','ricciardi76@gmail.com',4).
perfeito(medico_familia(4)).
medico_familia(5,'Joana Cunha','joanaCunha@gmail.com',5).
perfeito(medico_familia(5)).
medico_familia(6,'Maria Suzete','suzetemaria@gmail.com',6).
perfeito(medico_familia(6)).
medico_familia(7,'José Carlos Saraiva','zecarlos@gmail.com',7).
perfeito(medico_familia(7)).
medico_familia(8,'Manuel Saramago','sarmanu@gmail.com',8).
perfeito(medico_familia(8)).
medico_familia(9,'Ana Costa Silva','anacostafilomena@hotmail.com',9).
perfeito(medico_familia(9)).
medico_familia(10,'Luisa Sobral','sobraleurovision@almodovarcs.pt',10).
perfeito(medico_familia(10)).
medico_familia(11,'Salvador Sentido','semsentid@gmail.com',9).
perfeito(medico_familia(11)).
medico_familia(12,'Manuel Rodrigues','sarmanu@sapo.pt',8).
perfeito(medico_familia(12)).


%consulta:#Consulta,#Utente,#Medico,Descrição,Custo,Data ↝ { 𝕍, 𝔽 }
consulta(1,1,2,'Consulta de rotina',15.00,date(2021,4,21)).
perfeito(consulta(1)).
consulta(2,2,1,'Dores pós vacinação',7.50,date(2021,4,11)).
perfeito(consulta(2)).
consulta(3,2,3,'Relatorio medicação HIV',15.00,date(2021,3,7)).
perfeito(consulta(3)).
consulta(4,4,5,'Formulação de baixa laboral',70.00,date(2021,7,1)).
perfeito(consulta(4)).
consulta(5,4,4,'Avaliacao de teste psicotécnico',20.70,date(2021,5,11)).
perfeito(consulta(5)).
consulta(6,5,7,'Consulta de rotina',15.00,date(2021,11,3)).
perfeito(consulta(6)).
consulta(7,7,8,'Consulta de rotina',15.00,date(2021,7,6)).
perfeito(consulta(7)).
consulta(8,8,6,'Verificação exames diabéticos',15.00,date(2021,2,13)).
perfeito(consulta(8)).
consulta(9,9,11,'Consulta de rotina',15.00,date(2021,1,11)).
perfeito(consulta(9)).
consulta(10,9,11,'Marcação de exames rotineiros',5.00,date(2021,5,10)).
perfeito(consulta(10)).
consulta(11,10,11,'Consulta de rotina',5.00,date(2021,5,10)).
perfeito(consulta(11)).
