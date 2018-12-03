/*INSERT*/

-- UTENTE 
INSERT INTO Utente ( Password, Indirizzo, Cognome, Nome,CodFiscale) VALUES('root' , 'Largo Catallo 11', 'Marino', 'Gabriele','PGGLRD98E28C309F');
INSERT INTO Utente ( Password, Indirizzo, Cognome, Nome,CodFiscale) VALUES('root' , 'Via Strada di Salci 46', 'Scebba', 'Andrea Angelo','SCBNRN98S06B429H');
-- DOCUMENTO
INSERT INTO Documento VALUES ('AX964319', '1', 'Carta di identità', '2020-02-10', 'Comune');
INSERT INTO Documento VALUES ('AE162249', '2', 'Carta di identità', '2023-03-01', 'Comune'); 

-- VALUTAZIONE UTENTE
/*INSERT INTO ValutazioneUtente(Id, Ruolo, Recensione) VALUES ('1', 'fruitore', 'Bravino');
INSERT INTO `progetto`.`valutazioneutente` (`Id`, `Ruolo`, `Recensione`) VALUES ('1', 'fruitore', 'Insomma');
INSERT INTO `progetto`.`valutazioneutente` (`Id`, `Ruolo`, `Recensione`) VALUES ('1', 'fruitore', 'Bravissimo');
INSERT INTO `progetto`.`valutazioneutente` (`CodVoto`, `Id`, `Ruolo`, `Recensione`) VALUES ('4', '1', 'fruitore', 'scemo di merda');*/

-- STELLE UTENTE
  /*INSERT INTO StelleUtente VALUES ('1','1', '3', '3', '3', '3');
  INSERT INTO `progetto`.`stelleutente` (`CodVoto`, `Id`, `Persona`, `PiacereViaggio`, `Serieta`, `Comportamento`) VALUES ('2', '1', '1', '1', '2', '1');
  INSERT INTO `progetto`.`stelleutente` (`CodVoto`, `Id`, `Persona`, `PiacereViaggio`, `Serieta`, `Comportamento`) VALUES ('3', '1', '2', '1', '1', '2');
  INSERT INTO `progetto`.`stelleutente` (`CodVoto`, `Id`, `Persona`, `PiacereViaggio`, `Serieta`, `Comportamento`) VALUES ('4', '1', '2', '4', '5', '1');*/

-- AUTO
INSERT INTO Auto VALUES('AE987CB', '2', '0', '1', '0');


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
INSERT INTO LimitiDiVelocita (ValoreLimite, kmFine, kmInizio, CodStrada) VALUES ('40','1','20', '1');
INSERT INTO LimitiDiVelocita (ValoreLimite, kmFine, kmInizio, CodStrada) VALUES ('80','1','40', '2');

-- CAR SHARING
INSERT INTO PrenotazioneDiNoleggio (DataInizio, DataFine, idFruitore, Targa, idProponente) VALUES ('2019-01-01', '2019-01-01', '1', 'AE987CB', '2');
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
-- ARCHIVIO
INSERT INTO ArchivioPrenotazioniRifiutate VALUES('2','1','AE987CB');
INSERT INTO ArchivioPrenotazioniVecchie VALUES('1','2018-01-01', '2018-01-01', '1', 'AE987CB', '2');
-- TRAGITTO NOLEGGIO
INSERT INTO TragittoNoleggio(kmPercorsi) VALUES ('20');
-- POSIZIONE NOLEGGIO
INSERT INTO PosizioneArrivoNoleggio VALUES ('1','10');
INSERT INTO PosizionePartenzaNoleggio VALUES ('1', '1');
-- TRACKING NOLEGGIO
INSERT INTO TrackingNoleggio VALUES( 'AE987CB', '1','root','4','2017-02-02 12:33:33');
