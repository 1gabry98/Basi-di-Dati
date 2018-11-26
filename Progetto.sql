#Creazione database progetto Basi di Dati

DROP DATABASE IF EXISTS Progetto;
CREATE DATABASE Progetto;

USE PROGETTO;

CREATE TABLE Utente (
Id INT NOT NULL AUTO_INCREMENT,
Password VARCHAR(24) NOT NULL,
Ruolo VARCHAR(20) NOT NULL,
Indirizzo VARCHAR (100) NOT NULL,
Cognome VARCHAR(20) NOT NULL,
Nome VARCHAR(20) NOT NULL,
MediaVoto DOUBLE,
PRIMARY KEY (Id));



CREATE TABLE Documento(
NumDocumento VARCHAR (9) NOT NULL,
Id INT NOT NULL,
Tipologia VARCHAR (50) NOT NULL,		
CodFiscale VARCHAR (16) NOT NULL,            
Scadenza DATE NOT NULL,
EnteRilascio VARCHAR (50) NOT NULL,
PRIMARY KEY (NumDocumento),
FOREIGN KEY (Id) REFERENCES Utente(Id)
ON DELETE CASCADE);



CREATE TABLE ValutazioneUtente(
CodVoto INT AUTO_INCREMENT,
Id INT NOT NULL,
Ruolo VARCHAR(10) NOT NULL,
Recensione VARCHAR(200) NOT NULL,
PRIMARY KEY(CodVoto),
FOREIGN KEY (Id) REFERENCES Utente (Id)
ON DELETE CASCADE);





CREATE TABLE StelleUtente (
CodVoto INT NOT NULL,
Persona DOUBLE NOT NULL,
PiacereViaggio DOUBLE NOT NULL,
Serietà DOUBLE NOT NULL,
Comportamento DOUBLE NOT NULL,
PRIMARY KEY (CodVoto),
FOREIGN KEY(CodVoto) 
REFERENCES ValutazioneUtente(CodVoto)
ON DELETE CASCADE
);  



CREATE TABLE ChiamataSharingMultiplo (
CodChiamata INT NOT NULL,
Timestamp TIMESTAMP NOT NULL,
Destinazione VARCHAR (100) NOT NULL,
IdFruitore INT NOT NULL,
	PRIMARY KEY (CodChiamata),
FOREIGN KEY(IdFruitore) 
REFERENCES Utente(Id)
ON DELETE CASCADE
);



CREATE TABLE SharingMultiplo
(
	CodSharingMultiplo INT NOT NULL  AUTO_INCREMENT,
	Id INT NOT NULL,
CodSharing1 INT NOT NULL,
CodSharing2 INT NOT NULL,
PRIMARY KEY(CodSharingMultiplo),
FOREIGN KEY(Id) 
REFERENCES Utente(Id)
ON DELETE CASCADE
);


CREATE TABLE TragittoSharing (
CodTragitto INT NOT NULL AUTO_INCREMENT,
KmPercorsi DOUBLE NOT NULL,
	PRIMARY KEY(CodTragitto)
);

CREATE TABLE Strada (
CodStrada INT NOT NULL AUTO_INCREMENT,
Tipologia VARCHAR(30) NOT NULL,
Categorizzazione VARCHAR(30)DEFAULT NULL,
ClassificazioneTecnica VARCHAR(30) NOT NULL,
Nome VARCHAR(50) DEFAULT NULL,
Lunghezza DOUBLE NOT NULL,
NumCorsie INT NOT NULL DEFAULT 2,
NumSensi INT NOT NULL DEFAULT 1,
NumCarreggiate INT NOT NULL DEFAULT 1,
	PRIMARY KEY(CodStrada)
);


CREATE TABLE PosizionePartenzaSharing (
CodStrada INT NOT NULL,
numChilometro DOUBLE NOT NULL,
	PRIMARY KEY(CodStrada)
	-- FOREIGN KEY(CodStrada) REFERENCES Strada(CodStrada)
	-- ON DELETE CASCADE
);




CREATE TABLE PosizioneArrivoSharing (
CodStrada INT NOT NULL,
numChilometro DOUBLE NOT NULL,
	PRIMARY KEY(CodStrada)
	-- FOREIGN KEY(CodStrada) REFERENCES Strada(CodStrada)
	-- ON DELETE CASCADE
);




CREATE TABLE CorsieDiImmissione (
CodImmissione INT AUTO_INCREMENT NOT NULL,
CodStrada1 INT NOT NULL,
CodStrada2 INT NOT NULL,	
kmStrada1 DOUBLE NOT NULL,
kmStrada2 DOUBLE NOT NULL,
	PRIMARY KEY(CodImmissione)
	/*FOREIGN KEY (CodStrada1, CodStrada2) REFERENCES STRADA(CodStrada, CodStrada)
	ON DELETE CASCADE*/
);


CREATE TABLE Pedaggio (
CodPedaggio INT AUTO_INCREMENT,
CodStrada INT NOT NULL,
Importo DOUBLE NOT NULL,
kmStrada1 DOUBLE NOT NULL,
kmStrada2 DOUBLE NOT NULL,
	PRIMARY KEY (CodPedaggio),
	FOREIGN KEY(CodStrada) 
	REFERENCES Strada(CodStrada)
	ON DELETE CASCADE
);



CREATE TABLE LimitiDiVelocita
(
CodLimite INT NOT NULL  AUTO_INCREMENT,
ValoreLimite INT NOT NULL,
kmFine INT NOT NULL,
kmInizio INT NOT NULL,
CodStrada INT NOT NULL,
	PRIMARY KEY(CodLimite),
	FOREIGN KEY (CodStrada)
	REFERENCES Strada(CodStrada)
	ON DELETE CASCADE
);	

CREATE TABLE PrenotazioneDiNoleggio
(
CodNoleggio INT NOT NULL  AUTO_INCREMENT,
DataInizio DATE NOT NULL,
DataFine DATE  NOT NULL,
IdFruitore INT NOT NULL,
Targa VARCHAR(7) NOT NULL,
IdProponente INT NOT NULL,
	PRIMARY KEY(CodNoleggio),
	FOREIGN KEY (IdProponente)
	REFERENCES Utente(Id)
	ON DELETE CASCADE
);	



CREATE TABLE ValutazioneFruitoreNoleggio (
CodVoto INT NOT NULL AUTO_INCREMENT,
IdProponente INT NOT NULL,
IdFruitore INT NOT NULL,
Recensione VARCHAR(200),
	PRIMARY KEY(CodVoto)
	/*FOREIGN KEY (IdProponente, IdFruitore) 
	REFERENCES Utente(Id)*/
);




CREATE TABLE StelleFruitoreNoleggio
(
CodVoto INT NOT NULL,
Persona DOUBLE NOT NULL,
PiacereDiViaggio DOUBLE NOT NULL,
Comportamento DOUBLE NOT NULL,
Serieta DOUBLE NOT NULL,
	PRIMARY KEY (CodVoto),
	FOREIGN KEY (CodVoto)
	REFERENCES ValutazioneFruitoreNoleggio(CodVoto)
);

CREATE TABLE Auto (
Targa VARCHAR (7) NOT NULL,
Id  INT NOT NULL,
ServizioRideSharing BOOL DEFAULT NULL,
ServizioCarSharing BOOL DEFAULT NULL,
ServizioPooling  BOOL DEFAULT NULL,
	PRIMARY KEY (Targa),
	FOREIGN KEY (Id)
REFERENCES Utente(Id )
);



CREATE TABLE ValutazioneProponenteNoleggio (
CodVoto INT NOT NULL AUTO_INCREMENT,
IdProponente INT NOT NULL,
IdFruitore INT NOT NULL,
Recensione VARCHAR(200) NOT NULL,
		PRIMARY KEY(CodVoto)
	/*	FOREIGN KEY (IdProponente, IdFruitore) 
		REFERENCES Utente(Id)*/
);





CREATE TABLE StelleProponenteNoleggio
(
CodVoto INT NOT NULL,
Persona DOUBLE NOT NULL,
PiacereDiViaggio DOUBLE NOT NULL,
Comportamento DOUBLE NOT NULL,
Serieta DOUBLE NOT NULL,
	PRIMARY KEY (CodVoto),
	FOREIGN KEY (CodVoto)
	REFERENCES ValutazioneProponenteNoleggio(CodVoto)
);



CREATE TABLE ArchivioPrenotazioniRifiutate
(
CodNoleggio INT NOT NULL  AUTO_INCREMENT,
Id INT NOT NULL,
Targa VARCHAR(7) NOT NULL,
	PRIMARY KEY (CodNoleggio),
	FOREIGN KEY (Id)
	REFERENCES Utente(Id)
);


CREATE TABLE ArchivioPrenotazioniVecchie
(
CodNoleggio INT NOT NULL  AUTO_INCREMENT,
DataInizio DATE NOT NULL,
DataFine DATE NOT NULL,
IdFruitore INT NOT NULL,
Targa VARCHAR(7) NOT NULL,
IdProponente INT NOT NULL,
	PRIMARY KEY (CodNoleggio)	
);



CREATE TABLE TragittoNoleggio(
CodTragitto INT NOT NULL auto_increment,
KmPercorsi DOUBLE NOT NULL,
	PRIMARY KEY (CodTragitto)
);





CREATE TABLE PosizioneArrivoNoleggio
(
CodStrada INT NOT NULL  AUTO_INCREMENT,
NumChilometro INT NOT NULL,
	PRIMARY KEY (CodStrada),
	FOREIGN KEY (CodStrada)
	REFERENCES Strada(CodStrada )
);


CREATE TABLE PosizionePartenzaNoleggio (
CodStrada INT NOT NULL,
NumChilometro DOUBLE NOT NULL,
	PRIMARY KEY(CodStrada),
	FOREIGN KEY (CodStrada)
	REFERENCES Strada(CodStrada)
	ON DELETE CASCADE
);







CREATE TABLE TrackingNoleggio
(
	Targa VARCHAR(7) NOT NULL,
CodStrada INT NOT NULL  AUTO_INCREMENT,
Password VARCHAR(24) NOT NULL,
kmStrada INT NOT NULL,
Timestamp TIMESTAMP NOT NULL,
	PRIMARY KEY (Targa , CodStrada),
	FOREIGN KEY (CodStrada)
	REFERENCES Strada(CodStrada )
);








/*INSERT*/

-- UTENTE 
INSERT INTO Utente ( Password, Ruolo, Indirizzo, Cognome, Nome, MediaVoto) VALUES('root' , 'fruitore', 'Largo Catallo 11', 'Marino', 'Gabriele', '0');
INSERT INTO Utente ( Password, Ruolo, Indirizzo, Cognome, Nome, MediaVoto) VALUES('root' , 'proponente', 'Via Strada di Salci 46', 'Scebba', 'Andrea Angelo', '0');
-- DOCUMENTO
INSERT INTO Documento VALUES ('AX964319', '1', 'Carta di identità', 'PGGLRD98E28C309F', '2018-02-10', 'Comune');
INSERT INTO Documento VALUES ('AE162249', '2', 'Carta di identità', 'SCBNRN98S06B429H', '2018-03-01', 'Comune');

-- VALUTAZIONE UTENTE
INSERT INTO ValutazioneUtente(Id, Ruolo, Recensione) VALUES ('1', 'fruitore', 'Bravino');
-- STELLE UTENTE
INSERT INTO StelleUtente VALUES ('1', '3', '3', '3', '3');

-- SHARING MULTIPLO
INSERT INTO ChiamataSharingMultiplo VALUES ('1', '2017-02-02 12:33:33' , 'Roma', '1');
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
INSERT INTO PrenotazioneDiNoleggio (DataInizio, DataFine, idFruitore, Targa, idProponente) VALUES ('2018-01-01', '2018-01-01', '1', 'AE987CB', '2');
-- VALUTAZIONE FRUITORE NOLEGGIO
INSERT INTO valutazioneFruitoreNoleggio(IdProponente, IdFruitore, Recensione) VALUES ('1', '2', 'BRAVINO');
-- STELLE FRUITORE NOLEGGIO
INSERT INTO StelleFruitoreNoleggio VALUES('1','3','3','3','3');
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

-- AUTO
INSERT INTO Auto VALUES('AE987CB', '2', '0', '1', '0');

