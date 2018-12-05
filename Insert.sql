/*INSERT*/

-- UTENTE 
CALL RegistraUtente('root' , 'Largo Catallo 11', 'Marino', 'Gabriele','PGGLRD98E28C309F','AX964319','Carta di identità','2023-03-01','Comune');
CALL RegistraUtente('root' , 'Via Strada di Salci 46', 'Poggiani', 'Leonardo','ANDR674OE9203','AE162249','Carta di identità','2023-03-01','Comune');
CALL RegistraUtente('root' , 'Via Roma 11', 'Francesca', 'Tonioni','ANRR6EWRERE9203','AC54321','Carta di identità','2023-03-01','Comune');
CALL RegistraUtente('root' , 'Via Napoli 45', 'Andrea Angelo', 'Scebba','ANRRFWEWWW9203','AW92812','Carta di identità','2023-03-01','Comune');

-- AUTO
INSERT INTO `progetto`.`auto` (`Targa`, `Id`) VALUES ('AS214HM', '1');
INSERT INTO `progetto`.`auto` (`Targa`, `Id`) VALUES ('AX123AB', '3');


-- SHARING MULTIPLO
-- INSERT INTO ChiamataSharingMultiplo VALUES ('1', '2017-02-02 12:33:33' , 'Roma', '1');
-- ancora non fatto sharing  INSERT INTO SharingMultiplo(Id, codSharing1, codSharing2) 

-- RIDE SHARING
INSERT INTO TragittoSharing (kmPercorsi) VALUES ('8');
-- POSIZIONE SHARING
INSERT INTO PosizionePartenzaSharing VALUES ('1', '12');
INSERT INTO PosizioneArrivoSharing VALUES ('1', '20');

-- STRADA
INSERT INTO Strada(Tipologia, ClassificazioneTecnica, Lunghezza) VALUES ('statale', 'urbana', '20');
INSERT INTO Strada(Tipologia, ClassificazioneTecnica, Lunghezza) VALUES ('statale', 'urbana', '40');
-- CORSIE DI IMMISSIONE
INSERT INTO CorsieDiImmissione(CodStrada1, CodStrada2, kmStrada1, kmStrada2) VALUES ('1', '2', '10', '20');
-- LIMITI DI VELOCITA'
INSERT INTO `progetto`.`limitidivelocita` (`ValoreLimite`, `kmFine`, `kmInizio`, `CodStrada`) VALUES ('50', '20', '1', '1');
INSERT INTO `progetto`.`limitidivelocita` (`ValoreLimite`, `kmFine`,`kmInizio`, `CodStrada`) VALUES ('30', '40','1', '2');


-- CAR SHARING
INSERT INTO PrenotazioneDiNoleggio (DataInizio, DataFine, idFruitore, Targa, idProponente,Prezzo) VALUES ('2019-01-01', '2019-01-01', '1', 'AE987CB', '3','100');
-- VALUTAZIONE FRUITORE NOLEGGIO
INSERT INTO valutazioneFruitoreNoleggio(IdProponente, IdFruitore, Recensione) VALUES ('1', '2', 'BRAVINO');
INSERT INTO `progetto`.`valutazionefruitorenoleggio` (`IdProponente`, `IdFruitore`, `Recensione`) VALUES ('1', '1', 'INSOMMA');
UPDATE `progetto`.`valutazionefruitorenoleggio` SET `IdProponente` = '2', `IdFruitore` = '1' WHERE (`CodVoto` = '1');
INSERT INTO `progetto`.`valutazionefruitorenoleggio` (`IdProponente`, `IdFruitore`, `Recensione`) VALUES ('1', '2', 'SI');
INSERT INTO `progetto`.`valutazionefruitorenoleggio` (`IdProponente`, `IdFruitore`, `Recensione`) VALUES ('1', '2', 'OTTIMO');
INSERT INTO `progetto`.`valutazionefruitorenoleggio` (`IdProponente`, `IdFruitore`, `Recensione`) VALUES ('2', '1', 'SUPER');

-- STELLE FRUITORE NOLEGGIO
INSERT INTO StelleFruitoreNoleggio VALUES('1','1','3','3','3','3');
INSERT INTO `progetto`.`stellefruitorenoleggio` (`CodVoto`, `Id`, `Persona`, `PiacereViaggio`, `Comportamento`, `Serieta`) VALUES ('2', '1', '3', '2', '1', '5');
INSERT INTO `progetto`.`stellefruitorenoleggio` (`CodVoto`, `Id`, `Persona`, `PiacereViaggio`, `Comportamento`, `Serieta`) VALUES ('3', '1', '5', '2', '3', '2');
INSERT INTO `progetto`.`stellefruitorenoleggio` (`CodVoto`, `Id`, `Persona`, `PiacereViaggio`, `Comportamento`, `Serieta`) VALUES ('4', '2', '1', '1', '1', '1');
INSERT INTO `progetto`.`stellefruitorenoleggio` (`CodVoto`, `Id`, `Persona`, `PiacereViaggio`, `Comportamento`, `Serieta`) VALUES ('5', '1', '3', '3', '3', '3');

-- VALUTAZIONE PROPONENTE NOLEGGIO
INSERT INTO ValutazioneProponenteNoleggio (IdProponente, IdFruitore,Recensione) VALUES ('1', '2', 'Ottimo');
-- STELLE PROPONENTE NOLEGGIO
INSERT INTO StelleProponenteNoleggio VALUES( '1', '3','3','3','3');
-- TRAGITTO NOLEGGIO
INSERT INTO TragittoNoleggio(kmPercorsi) VALUES ('20');
-- POSIZIONE NOLEGGIO
INSERT INTO PosizioneArrivoNoleggio VALUES ('1','10');
INSERT INTO PosizionePartenzaNoleggio VALUES ('1', '1');
-- TRACKING NOLEGGIO
INSERT INTO TrackingNoleggio VALUES( 'AE987CB', '1','root','4','2017-02-02 12:33:33');
-- SINISTR0 NOLEGGIO
INSERT INTO `progetto`.`sinistronoleggio` (`Modello`, `CasaAutomobilistica`, `TargaVeicoloProponente`, `Orario`, `CodStrada`, `KmStrada`, `Dinamica`, `PercentualeDiResponsabilita`) VALUES ('Panamera', 'Porsche', 'AE987CB', '2017-01-10 10:31:33', '1', '5', 'Na botta assurda', '10');
INSERT INTO GeneralitaSinistroNoleggio VALUES ('AX964319', 'PGGLRD98E28C309F', 'Poggiani', 'Leonardo','Via Strada di Salci 46', '345344660');



