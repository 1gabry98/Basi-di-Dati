DROP DATABASE IF EXISTS Progetto;
CREATE DATABASE Progetto;

USE PROGETTO;

CREATE TABLE Utente 
(
    Id INT NOT NULL AUTO_INCREMENT,
    Password_ VARCHAR(24) NOT NULL,
    Ruolo ENUM ('Fruitore','Proponente') DEFAULT 'Fruitore',
    Indirizzo VARCHAR (100) NOT NULL,
    Cognome VARCHAR(20) NOT NULL,
    Nome VARCHAR(20) NOT NULL,
    CodFiscale VARCHAR (16) NOT NULL,
    MediaVoto VARCHAR(3) DEFAULT 0,
    Stato ENUM ('ATTIVO', 'INATTIVO') DEFAULT 'INATTIVO',
    DataIscrizione TIMESTAMP NOT NULL,
    Affidabilita ENUM ('non calcolata','BASSA','MEDIA','ALTA') DEFAULT 'non calcolata',
        PRIMARY KEY (Id)
);



CREATE TABLE Documento
(
    NumDocumento VARCHAR (9) NOT NULL,
    Id INT NOT NULL,
    Tipologia VARCHAR (50) NOT NULL,             
    Scadenza DATE NOT NULL,
    EnteRilascio VARCHAR (50) NOT NULL,
    PRIMARY KEY (NumDocumento),
    FOREIGN KEY (Id) 
    REFERENCES Utente(Id)
    ON DELETE CASCADE
);


CREATE TABLE ValutazioneUtente
(
    CodVoto INT AUTO_INCREMENT,
    Id INT NOT NULL,
    Ruolo VARCHAR(10) NOT NULL,
    Recensione VARCHAR(200) NOT NULL,
    PRIMARY KEY(CodVoto,Id),
    FOREIGN KEY (Id) 
    REFERENCES Utente (Id)
    ON DELETE CASCADE
);





CREATE TABLE StelleUtente 
(
    CodVoto INT NOT NULL,
    Id INT NOT NULL,
    Persona DOUBLE NOT NULL,
    PiacereViaggio DOUBLE NOT NULL,
    Serieta DOUBLE NOT NULL,
    Comportamento DOUBLE NOT NULL,
        PRIMARY KEY (CodVoto, Id),
        FOREIGN KEY(CodVoto) 
        REFERENCES ValutazioneUtente(CodVoto)
        ON DELETE CASCADE,
        
        FOREIGN KEY(Id) 
        REFERENCES Utente(Id)
        ON DELETE CASCADE 
);  



CREATE TABLE ChiamataSharingMultiplo 
(
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


CREATE TABLE TragittoSharing 
(
    CodTragitto INT NOT NULL AUTO_INCREMENT,
    KmPercorsi DOUBLE NOT NULL,
        PRIMARY KEY(CodTragitto)
);

CREATE TABLE Strada 
(
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


CREATE TABLE PosizionePartenzaSharing 
(
    CodStrada INT NOT NULL,
    numChilometro DOUBLE NOT NULL,
        PRIMARY KEY(CodStrada),
        FOREIGN KEY(CodStrada) 
        REFERENCES Strada(CodStrada)
        ON DELETE CASCADE
);




CREATE TABLE PosizioneArrivoSharing (
CodStrada INT NOT NULL,
numChilometro DOUBLE NOT NULL,
    PRIMARY KEY(CodStrada),
    FOREIGN KEY(CodStrada) 
    REFERENCES Strada(CodStrada)
	ON DELETE CASCADE
);




CREATE TABLE CorsieDiImmissione 
(
    CodImmissione INT AUTO_INCREMENT NOT NULL,
    CodStrada1 INT NOT NULL,
    CodStrada2 INT NOT NULL,    
    kmStrada1 DOUBLE NOT NULL,
    kmStrada2 DOUBLE NOT NULL,
        PRIMARY KEY(CodImmissione),
         FOREIGN KEY (CodStrada1) 
         REFERENCES Strada(CodStrada)
         ON DELETE CASCADE,
         
         FOREIGN KEY (CodStrada2)
		 REFERENCES Strada(CodStrada)
         ON DELETE CASCADE
);

CREATE TABLE Pedaggio 
(
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
    Prezzo INT NOT NULL,
    QuantitaCarburanteFinale DOUBLE NOT NULL DEFAULT 0.0,
    Stato ENUM ('ATTIVO', 'CHIUSO','RIFIUTATO') DEFAULT 'ATTIVO',
        PRIMARY KEY(CodNoleggio),
        FOREIGN KEY (IdProponente)
        REFERENCES Utente(Id)
        ON DELETE NO ACTION
);    



CREATE TABLE ValutazioneFruitoreNoleggio 
(
    CodVoto INT NOT NULL AUTO_INCREMENT,
    IdProponente INT NOT NULL,
    IdFruitore INT NOT NULL,
    Recensione VARCHAR(200),
        PRIMARY KEY(CodVoto),
        FOREIGN KEY (IdProponente)
        REFERENCES Utente(Id)
        ON DELETE CASCADE,
        
        FOREIGN KEY (IdFruitore)
        REFERENCES Utente(Id)
        ON DELETE CASCADE
);




CREATE TABLE StelleFruitoreNoleggio
(
    CodVoto INT NOT NULL,
    Id INT NOT NULL,
    Persona DOUBLE NOT NULL,
    PiacereViaggio DOUBLE NOT NULL,
    Comportamento DOUBLE NOT NULL,
    Serieta DOUBLE NOT NULL,
        PRIMARY KEY (CodVoto),
        FOREIGN KEY (CodVoto)
        REFERENCES ValutazioneFruitoreNoleggio(CodVoto)
        ON DELETE CASCADE
);

CREATE TABLE ValutazioneProponenteNoleggio 
(
    CodVoto INT NOT NULL AUTO_INCREMENT,
    IdProponente INT NOT NULL,
    IdFruitore INT NOT NULL,
    Recensione VARCHAR(200) NOT NULL,
        PRIMARY KEY(CodVoto),
        FOREIGN KEY (IdProponente) 
        REFERENCES Utente(Id)
        ON DELETE CASCADE,

        FOREIGN KEY (IdFruitore) 
        REFERENCES Utente(Id)
        ON DELETE CASCADE

);


CREATE TABLE Auto 
(
    Targa VARCHAR (7) NOT NULL,
    Id  INT NOT NULL,
    ServizioRideSharing BOOL DEFAULT FALSE,
    ServizioCarSharing BOOL DEFAULT FALSE,
    ServizioPooling  BOOL DEFAULT FALSE,
        PRIMARY KEY (Targa),
        FOREIGN KEY (Id)
        REFERENCES Utente(Id)
        ON DELETE CASCADE
);




CREATE TABLE StelleProponenteNoleggio (
    CodVoto INT NOT NULL,
    Id INT NOT NULL,
    Persona DOUBLE NOT NULL,
    PiacereViaggio DOUBLE NOT NULL,
    Comportamento DOUBLE NOT NULL,
    Serieta DOUBLE NOT NULL,
		PRIMARY KEY (CodVoto),
		FOREIGN KEY (CodVoto)
		REFERENCES ValutazioneProponenteNoleggio (CodVoto)
        ON DELETE CASCADE
    
);



CREATE TABLE ArchivioPrenotazioniRifiutate (
    CodNoleggio INT NOT NULL,
    IdFruitore INT NOT NULL,
    IdProponente INT NOT NULL,
    Targa VARCHAR(7) NOT NULL,
		PRIMARY KEY (CodNoleggio),
		FOREIGN KEY (IdFruitore)
        REFERENCES Utente (Id)
        ON DELETE CASCADE,
        
		FOREIGN KEY (IdProponente)
		REFERENCES Utente(Id)
        ON DELETE CASCADE
);


CREATE TABLE ArchivioPrenotazioniVecchie (
    CodNoleggio INT NOT NULL,
    DataInizio DATE NOT NULL,
    DataFine DATE NOT NULL,
    IdFruitore INT NOT NULL,
    Targa VARCHAR(7) NOT NULL,
    IdProponente INT NOT NULL,
		PRIMARY KEY (CodNoleggio),
        FOREIGN KEY (IdFruitore)
        REFERENCES Utente(Id)
        ON DELETE CASCADE,
        
        FOREIGN KEY (Targa)
        REFERENCES Auto(Targa)
        ON DELETE CASCADE
    
);




CREATE TABLE TragittoNoleggio (
    CodTragitto INT NOT NULL AUTO_INCREMENT,
    KmPercorsi DOUBLE NOT NULL,
    PRIMARY KEY (CodTragitto)
);



CREATE TABLE PosizioneArrivoNoleggio (
    CodStrada INT NOT NULL AUTO_INCREMENT,
    NumChilometro INT NOT NULL,
		PRIMARY KEY (CodStrada),
		FOREIGN KEY (CodStrada)
        REFERENCES Strada (CodStrada)
        ON DELETE CASCADE
);


CREATE TABLE PosizionePartenzaNoleggio (
    CodStrada INT NOT NULL,
    NumChilometro DOUBLE NOT NULL,
		PRIMARY KEY (CodStrada),
		FOREIGN KEY (CodStrada)
        REFERENCES Strada (CodStrada)
        ON DELETE CASCADE
);





CREATE TABLE TrackingNoleggio
(
    Targa VARCHAR(7) NOT NULL,
    CodStrada INT NOT NULL  AUTO_INCREMENT,
    CodNoleggio INT NOT NULL,
    Password_ VARCHAR(24) NOT NULL,
    kmStrada INT NOT NULL,
    Timestamp_ TIMESTAMP NOT NULL,
        PRIMARY KEY (Targa , CodStrada ,Timestamp_),
        FOREIGN KEY (CodStrada)
        REFERENCES Strada(CodStrada)
        ON DELETE NO ACTION
); 




CREATE TABLE SinistroNoleggio
(
    CodSinistro  INT NOT NULL  AUTO_INCREMENT,
    Modello  VARCHAR(24) NOT NULL,
    CasaAutomobilistica VARCHAR(24) NOT NULL,
    TargaVeicoloProponente VARCHAR(7) NOT NULL,
    IdGuidatore INT NOT NULL,
    Orario TIMESTAMP NOT NULL, 
    CodStrada INT NOT NULL,
    KmStrada INT NOT NULL,
    Dinamica VARCHAR(200) NOT NULL,
    PercentualeDiResponsabilita INT NOT NULL,
        PRIMARY KEY (CodSinistro),
        FOREIGN KEY (TargaVeicoloProponente)
        REFERENCES Auto(Targa)
        ON DELETE NO ACTION,
        
        FOREIGN KEY (CodStrada)
        REFERENCES Strada(CodStrada)
        ON DELETE NO ACTION,
        
        FOREIGN KEY (IdGuidatore)
		REFERENCES Utente(Id)
        ON DELETE NO ACTION
);


CREATE TABLE GeneralitaSinistroNoleggio
(
    NumDocumento VARCHAR (9) NOT NULL,
    CodFiscale VARCHAR(16) NOT NULL,
    Cognome VARCHAR(40) NOT NULL,
    Nome VARCHAR(40) NOT NULL,
    Indirizzo VARCHAR(40) NOT NULL,
    NumTelefono INT NOT NULL,
        PRIMARY KEY (NumDocumento,CodFiscale),
        
        FOREIGN KEY (NumDocumento)
        REFERENCES Documento(NumDocumento)
		ON DELETE NO ACTION
);


CREATE TABLE DocumentoDiIdentitaSinistroNoleggio
(
    NumDocumento VARCHAR (9) NOT NULL,
    Tipologia VARCHAR(100) NOT NULL,
    Scadenza DATE NOT NULL,
    EnteRilascio VARCHAR(100) NOT NULL,
        PRIMARY KEY (NumDocumento),
        FOREIGN KEY (NumDocumento)
        REFERENCES Documento(NumDocumento)
        ON DELETE NO ACTION
);


CREATE TABLE Pool 
(
    CodPool INT NOT NULL AUTO_INCREMENT,
    GiornoPartenza TIMESTAMP NOT NULL,
    Stato ENUM ('ATTIVO', 'CHIUSO') DEFAULT 'ATTIVO', 
    GiornoArrivo TIMESTAMP NOT NULL,
    IdProponente INT NOT NULL, 
    Targa VARCHAR(7) NOT NULL, 
    GradoFlessibilitA ENUM ('BASSO', 'MEDIO', 'ALTO'),
    NumPosti INT NOT NULL,
        PRIMARY KEY (CodPool),
        FOREIGN KEY (IdProponente)
        REFERENCES Utente(Id)
        ON DELETE CASCADE,
        
        FOREIGN KEY (Targa)
        REFERENCES Auto(Targa)
        ON DELETE CASCADE
);
CREATE TABLE ValutazioneFruitorePool
(
	CodVoto INT NOT NULL AUTO_INCREMENT,
    IdProponente INT NOT NULL,
    IdFruitore INT NULL,
    Recensione VARCHAR(200),
		PRIMARY KEY (CodVoto),
		FOREIGN KEY (IdProponente)
        REFERENCES Utente(Id)
        ON DELETE CASCADE,
        
        FOREIGN KEY (IdFruitore)
        REFERENCES Utente(Id)
        ON DELETE CASCADE
);

CREATE TABLE StelleFruitorePool
(
	CodVoto INT NOT NULL,
    Id INT NOT NULL,
    Persona INT NOT NULL,
    PiacereViaggio INT NOT NULL,
    Serieta INT NOT NULL,
    Comportamento INT NOT NULL,
    PRIMARY KEY (CodVoto),
		FOREIGN KEY (Id)
        REFERENCES Utente(Id)
        ON DELETE CASCADE
);

CREATE TABLE ValutazioneProponentePool
(
	CodVoto INT NOT NULL AUTO_INCREMENT,
    IdProponente INT NOT NULL,
    IdFruitore INT NOT NULL,
    Recensione VARCHAR(200),
    PRIMARY KEY (CodVoto),
		FOREIGN KEY (IdFruitore)
        REFERENCES Utente(Id)
        ON DELETE CASCADE,
        
        FOREIGN KEY (IdProponente)
        REFERENCES Utente(Id)
        ON DELETE CASCADE
);

CREATE TABLE StelleProponentePool
(
	CodVoto INT NOT NULL,
    Id INT NOT NULL,
    Persona INT NOT NULL,
    PiacereViaggio INT NOT NULL,
    Serieta INT NOT NULL,
    Comportamento INT NOT NULL,
	PRIMARY KEY (CodVoto),
		FOREIGN KEY (Id)
        REFERENCES Utente(Id)
        ON DELETE CASCADE
);

CREATE TABLE AdesioniPool
(
	CodPool INT NOT NULL,
    IdFruitore INT NOT NULL,
		PRIMARY KEY (CodPool, IdFruitore),
		FOREIGN KEY (CodPool) 
		REFERENCES Pool(CodPool)
		ON DELETE CASCADE,
    
		FOREIGN KEY (IdFruitore)
		REFERENCES Utente(Id)
		ON DELETE NO ACTION
);

CREATE TABLE TragittoPool 
(
    CodTragitto INT NOT NULL AUTO_INCREMENT,
    KmPercorsi DOUBLE NOT NULL,
    CodPool INT NOT NULL,
            PRIMARY KEY(CodTragitto),
            FOREIGN KEY (CodPool)
            REFERENCES Pool(CodPool)
);


CREATE TABLE PosizioneArrivoPool
 (
    CodStrada INT NOT NULL,
    numChilometro DOUBLE NOT NULL,
        PRIMARY KEY(CodStrada),
        FOREIGN KEY(CodStrada) 
        REFERENCES Strada(CodStrada)
        ON DELETE CASCADE
);


CREATE TABLE PosizionePartenzaPool
(
    CodStrada INT NOT NULL,
    numChilometro DOUBLE NOT NULL,
        PRIMARY KEY(CodStrada),
        FOREIGN KEY(CodStrada) 
        REFERENCES Strada(CodStrada)
        ON DELETE CASCADE
);


CREATE TABLE SinistroPool
(
    CodSinistro  INT NOT NULL AUTO_INCREMENT,
    Modello  VARCHAR(24) NOT NULL,
    CasaAutomobilistica VARCHAR(24) NOT NULL,
    TargaVeicoloProponente VARCHAR(7) NOT NULL,
    Orario TIMESTAMP NOT NULL,    
    KmStrada INT NOT NULL,
    CodStrada INT NOT NULL,
    Dinamica VARCHAR(200) NOT NULL,
    PercentualeDiResponsabilita INT NOT NULL,
        PRIMARY KEY (CodSinistro),
        FOREIGN KEY (TargaVeicoloProponente)
        REFERENCES Auto(Targa)
        ON DELETE NO ACTION,
        FOREIGN KEY (CodStrada)
        REFERENCES Strada(CodStrada)
        ON DELETE NO ACTION	
);


CREATE TABLE GeneralitaSinistroPool
(
    NumDocumento VARCHAR (9) NOT NULL,
    CodFiscale VARCHAR(16) NOT NULL,
    Cognome VARCHAR(24) NOT NULL,
    Nome VARCHAR(24) NOT NULL,
    Indirizzo VARCHAR(24) NOT NULL,
    NumTelefono INT NOT NULL,
        PRIMARY KEY (NumDocumento),
        FOREIGN KEY (NumDocumento)
        REFERENCES Documento(NumDocumento)
        ON DELETE NO ACTION
);



CREATE TABLE DocumentoDiIdentitaSinistroPool
(
    NumDocumento VARCHAR (9) NOT NULL,
    Tipologia VARCHAR(100) NOT NULL,
    Scadenza VARCHAR(24) NOT NULL,
	EnteRilascio VARCHAR(100) NOT NULL,
        PRIMARY KEY (NumDocumento),
        FOREIGN KEY (NumDocumento)
        REFERENCES Documento(NumDocumento)
        ON DELETE NO ACTION

);


CREATE TABLE SommaCostiAttualePool
(
    CodPool INT NOT NULL,
    ConsumoCarburante DOUBLE NOT NULL DEFAULT 0,
    CostoCarburante DOUBLE NOT NULL,
    CostoOperativo DOUBLE NOT NULL DEFAULT 0,
    CostoUsura DOUBLE NOT NULL,
    ConsumoUrbano DOUBLE NOT NULL,
    ConsumoExtraUrbano DOUBLE NOT NULL,
    ConsumoMisto DOUBLE NOT NULL,
        PRIMARY KEY (CodPool),
        FOREIGN KEY (CodPool)
        REFERENCES Pool(CodPool)    
        ON DELETE CASCADE
);


CREATE TABLE ArchivioPoolVecchi 
(
    CodPool INT NOT NULL,    
    GradoFlessibilita ENUM ('BASSO', 'MEDIO', 'ALTO'),
    GiornoArrivo TIMESTAMP NOT NULL,
    GiornoPartenza TIMESTAMP NOT NULL,
	IdProponente INT NOT NULL, 
    Targa VARCHAR(7) NOT NULL, 
        PRIMARY KEY (CodPool),
        
        FOREIGN KEY (IdProponente)
        REFERENCES Utente(Id)
        ON DELETE CASCADE,
        
        FOREIGN KEY (Targa)
        REFERENCES Auto(Targa)
        ON DELETE CASCADE
);



CREATE TABLE SommaCostiVecchiaPool 
(
    CodPool INT NOT NULL,    
    ConsumoCarburante DOUBLE NOT NULL,
    CostoCarburante DOUBLE NOT NULL,
    CostoOperativo DOUBLE NOT NULL,
    CostoUsura DOUBLE NOT NULL,
    ConsumoUrbano DOUBLE NOT NULL,
    ConsumoExtraUrbano DOUBLE NOT NULL,
    ConsumoMisto DOUBLE NOT NULL,
        PRIMARY KEY (CodPool),
        FOREIGN KEY (CodPool)
        REFERENCES Pool(CodPool)
        ON DELETE NO ACTION
);



CREATE TABLE ConsumoMedio
(
    Targa VARCHAR(7) NOT NULL,
    Urbano  DOUBLE NOT NULL,
    ExtraUrbano DOUBLE NOT NULL,
    Misto DOUBLE NOT NULL,
        PRIMARY KEY (Targa),
        FOREIGN KEY (Targa)
        REFERENCES Auto(Targa) 
        ON DELETE CASCADE 
);


CREATE TABLE Caratteristiche 
(
    Targa VARCHAR(7) NOT NULL,
    NumPosti INT NOT NULL,
    VelocitaMax DOUBLE NOT NULL,
    AnnoImmatricolazione INT NOT NULL,
    Alimentazione VARCHAR(29) NOT NULL,
    Cilindrata  DOUBLE NOT NULL,
    Modello VARCHAR(29) NOT NULL,
    CasaProduttrice VARCHAR(29) NOT NULL,
        PRIMARY KEY (Targa),
        FOREIGN KEY (Targa)
        REFERENCES Auto(Targa)
        ON DELETE CASCADE 
);




CREATE TABLE StatoIniziale
(
    Targa VARCHAR(7) NOT NULL,
    KmPercorsi  DOUBLE NOT NULL,
    QuantitaCarburante DOUBLE NOT NULL,
    CostoUsura DOUBLE NOT NULL,
        PRIMARY KEY (Targa),
        FOREIGN KEY (Targa)
        REFERENCES Auto(Targa)
        ON DELETE CASCADE 
);



CREATE TABLE Optional 
(
    Targa VARCHAR(7) NOT NULL,
     Peso  DOUBLE NOT NULL, 
    Connettivita BOOL DEFAULT 0,
    Tavolino BOOL DEFAULT 0,
    TettoInVetro BOOL DEFAULT 0,
    Bagagliaio DOUBLE NOT NULL,
    ValutazioneAuto DOUBLE NOT NULL,
    RumoreMedio DOUBLE NOT NULL,
        PRIMARY KEY (Targa),
        FOREIGN KEY (Targa)
        REFERENCES Auto(Targa)
        ON DELETE CASCADE 
);



CREATE TABLE ChiamataRideSharing
(
    CodChiamata INT NOT NULL AUTO_INCREMENT,
    CodStrada VARCHAR(60) NOT NULL,
    kmStrada INT NOT NULL,
    Stato ENUM('ATTIVA','CHIUSA','RIFIUTATA')DEFAULT 'ATTIVA',
	TimeStamp TIMESTAMP NOT NULL,
    IdFruitore INT NOT NULL,
        PRIMARY KEY (CodChiamata),
        
        FOREIGN KEY (IdFruitore)
        REFERENCES Utente(Id)
        ON DELETE CASCADE
);



CREATE TABLE ArchivioChiamateSharingRifiutate 
(
    CodChiamata INT NOT NULL,
    CodStrada INT NOT NULL,
    kmStrada INT NOT NULL,
    IdFruitore INT NOT NULL,
        TimeStamp TIMESTAMP NOT NULL,
        PRIMARY KEY(CodChiamata),
        FOREIGN KEY(IdFruitore) 
        REFERENCES Utente(Id)
        ON DELETE CASCADE,
        
        FOREIGN KEY (CodStrada)
        REFERENCES Strada(codStrada)
        ON DELETE CASCADE
);



CREATE TABLE RideSharing 
(
    CodSharing INT NOT NULL AUTO_INCREMENT,
    IdProponente INT NOT NULL, 
    IdFruitore INT NOT NULL,
    OraPartenza TIMESTAMP NOT NULL, 
    OraStimatoArrivo  TIMESTAMP NOT NULL,
    Targa VARCHAR(7) NOT NULL,
    NumPosti INT NOT NULL,
        PRIMARY KEY(CodSharing),
        FOREIGN KEY(IdProponente) 
        REFERENCES Utente(Id)
        ON DELETE CASCADE,
        
       FOREIGN KEY(IdFruitore) 
        REFERENCES Utente(Id)
        ON DELETE CASCADE
	
);


CREATE TABLE AdesioniRideSharing 
(
    CodSharing INT NOT NULL,
    IdUtente INT NOT NULL,
        PRIMARY KEY(CodSharing,IdUtente),
        FOREIGN KEY(CodSharing) 
        REFERENCES RideSharing(CodSharing)
        ON DELETE CASCADE,
        
        FOREIGN KEY (IdUtente)
        REFERENCES Utente(Id)
        ON DELETE CASCADE
);


CREATE TABLE ValutazioneFruitoreRideSharing 
(
    CodVoto INT NOT NULL AUTO_INCREMENT,
    IdProponente INT NOT NULL, 
    IdFruitore INT NOT NULL,
    Recensione VARCHAR(200) NOT NULL,
        PRIMARY KEY (CodVoto),
        FOREIGN KEY(IdFruitore) 
        REFERENCES Utente(Id)
        ON DELETE CASCADE ,
        
        FOREIGN KEY(IdProponente) 
        REFERENCES Utente(Id)
        ON DELETE CASCADE 
);



CREATE TABLE StelleFruitoreRideSharing 
(
    CodVoto INT NOT NULL,
    Id INT NOT NULL,
    Persona DOUBLE NOT NULL,
    PiacereViaggio DOUBLE NOT NULL, 
    Serieta DOUBLE NOT NULL, 
    Comportamento DOUBLE NOT NULL,
        PRIMARY KEY (CodVoto),
        FOREIGN KEY(CodVoto) 
        REFERENCES ValutazioneFruitoreRideSharing(CodVoto)
        ON DELETE CASCADE ,
        
        FOREIGN KEY(Id)
        REFERENCES Utente(Id)
        ON DELETE CASCADE
);



CREATE TABLE ValutazioneProponenteRideSharing 
(
    CodVoto INT NOT NULL AUTO_INCREMENT,
    IdProponente INT NOT NULL, 
    IdFruitore INT NOT NULL,
    Recensione VARCHAR(200) NOT NULL,
        PRIMARY KEY (CodVoto),
        FOREIGN KEY(IdProponente) 
        REFERENCES Utente(Id)
        ON DELETE CASCADE 
);



CREATE TABLE StelleProponenteRideSharing 
(
    CodVoto INT NOT NULL, 
    Id INT NOT NULL,
    Persona DOUBLE NOT NULL,
    PiacereViaggio DOUBLE NOT NULL, 
    Serieta  DOUBLE NOT NULL, 
    Comportamento DOUBLE NOT NULL,
        PRIMARY KEY (CodVoto),
        FOREIGN KEY(CodVoto) 
        REFERENCES ValutazioneProponenteRideSharing(CodVoto)
        ON DELETE CASCADE 
);




CREATE TABLE ArchivioSharingVecchi
(
    CodSharing INT NOT NULL,
    OrarioPartenza TIMESTAMP NOT NULL, 
    IdProponente INT NOT NULL,
        PRIMARY KEY (CodSharing),
        FOREIGN KEY(CodSharing) 
        REFERENCES RideSharing(CodSharing)
        ON DELETE CASCADE 
);



CREATE TABLE TrackingSharing 
(
    Targa VARCHAR(7) NOT NULL,
    CodStrada INT NOT NULL  AUTO_INCREMENT,
    CodSharing INT NOT NULL,
    Password_ VARCHAR(24) NOT NULL,
    kmStrada INT NOT NULL,
    Timestamp_ TIMESTAMP NOT NULL,
        PRIMARY KEY (Targa , CodStrada ,kmStrada ,Timestamp_),
        FOREIGN KEY (CodStrada)
        REFERENCES Strada(CodStrada)
        ON DELETE NO ACTION,
		
        FOREIGN KEY (Targa)
        REFERENCES Auto(Targa)
        ON DELETE NO ACTION,
        
        FOREIGN KEY(CodSharing)
        REFERENCES RideSharing(CodSharing)
        ON DELETE NO ACTION
);



CREATE TABLE SinistroSharing 
(
    CodSinistro  INT NOT NULL AUTO_INCREMENT,
    Modello  VARCHAR(24) NOT NULL,
    CasaAutomobilistica VARCHAR(24) NOT NULL,
    TargaVeicoloProponente VARCHAR(7) NOT NULL,
    Orario TIMESTAMP NOT NULL,
    KmStrada INT NOT NULL,
    CodStrada INT NOT NULL,
    Dinamica VARCHAR(200) NOT NULL,
    PercentualeDiResponsabilita INT NOT NULL,
        PRIMARY KEY (CodSinistro),
        FOREIGN KEY (TargaVeicoloProponente)
        REFERENCES Auto(Targa)
        ON DELETE NO ACTION,
        
        FOREIGN KEY(CodStrada) 
        REFERENCES Strada(CodStrada)
        ON DELETE NO ACTION
);




CREATE TABLE GeneralitaSinistroSharing 
(
    NumDocumento VARCHAR (9) NOT NULL,
    CodFiscale VARCHAR(16) NOT NULL,
    Cognome VARCHAR(24) NOT NULL,
    Nome VARCHAR(24) NOT NULL,
    Indirizzo VARCHAR(24) NOT NULL,
    NumTelefono INT NOT NULL,
        PRIMARY KEY (NumDocumento),
        FOREIGN KEY (NumDocumento)
        REFERENCES Documento(NumDocumento)
        ON DELETE NO ACTION
);



CREATE TABLE DocumentoDiIdentitaSinistroSharing 
(
    NumDocumento VARCHAR (9) NOT NULL,
    Tipologia VARCHAR(100) NOT NULL,
    Scadenza DATE NOT NULL,
    EnteRilascio VARCHAR(100) NOT NULL,
        PRIMARY KEY (NumDocumento),
        FOREIGN KEY (NumDocumento)
        REFERENCES Documento(NumDocumento)
        ON DELETE NO ACTION
);



CREATE TABLE TrackingPool 
(
    Targa VARCHAR(7) NOT NULL,
    CodPool INT NOT NULL,
    CodStrada INT NOT NULL,
    Password_ VARCHAR(24) NOT NULL,
    kmStrada INT NOT NULL,
    Timestamp_ TIMESTAMP NOT NULL,
        PRIMARY KEY (Targa , CodStrada, Timestamp_),
        FOREIGN KEY (CodStrada)
        REFERENCES Strada(CodStrada)
        ON DELETE NO ACTION,
        
        FOREIGN KEY (CodPool)
        REFERENCES Pool(CodPool)
        ON DELETE NO ACTION,
        
        FOREIGN KEY (CodStrada)
        REFERENCES Strada(CodStrada)
        ON DELETE NO ACTION
);

CREATE TABLE StradeTragittoPool 
(
	CodStrada INT NOT NULL,
    CodPool INT NOT NULL,
    kmInizioStrada INT NOT NULL,
    kmFineStrada INT NOT NULL,
        PRIMARY KEY (CodStrada),
        FOREIGN KEY (CodStrada)
        REFERENCES Strada(CodStrada)
        ON DELETE NO ACTION,
        
        FOREIGN KEY (CodPool)
        REFERENCES Pool(CodPool)
        ON DELETE CASCADE
);

CREATE TABLE StradeTragittoSharing
(
	CodStrada INT NOT NULL,
    CodSharing INT NOT NULL,
    kmInizioStrada INT NOT NULL,
    kmFineStrada INT NOT NULL,
		PRIMARY KEY (CodStrada),
        FOREIGN KEY (CodStrada)
        REFERENCES Strada(CodStrada)
        ON DELETE NO ACTION,
        
        FOREIGN KEY (CodSharing)
        REFERENCES RideSharing(CodSharing)
        ON DELETE CASCADE
);

CREATE TABLE Incrocio
(
	CodStrada1 INT NOT NULL,
    CodStrada2 INT NOT NULL,
    kmStrada1 INT NOT NULL,
    kmStrada2 INT NOT NULL,
		PRIMARY KEY (CodStrada1, CodStrada2),
        FOREIGN KEY (CodStrada1)
        REFERENCES Strada(CodStrada)
        ON DELETE CASCADE,
        
        FOREIGN KEY (CodStrada2)
        REFERENCES Strada(CodStrada)
        ON DELETE CASCADE
);


/*TRIGGER*/
DELIMITER $$

CREATE TRIGGER controllo_incrocio
BEFORE INSERT ON Incrocio FOR EACH ROW
BEGIN
	DECLARE strada1 INT DEFAULT 0;
    DECLARE strada2 INT DEFAULT 0;
    DECLARE km1 INT DEFAULT 0;
    DECLARE km2 INT DEFAULT 0;
    
    SET strada1 = (SELECT COUNT(CodStrada)
					FROM Strada
                    WHERE CodStrada = NEW.CodStrada1);
                    
	SET strada2 = (SELECT COUNT(CodStrada)
					FROM Strada
                    WHERE CodStrada = NEW.CodStrada2);
	
    IF (strada1 = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire strada valida';
    END IF;
    
    IF (strada2 = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire strada valida';
    END IF;
    
    SET km1 = (SELECT Lunghezza
				FROM Strada
                WHERE CodStrada = NEW.CodStrada1);
	
      SET km2 = (SELECT Lunghezza
				FROM Strada
                WHERE CodStrada = NEW.CodStrada2);
                
		IF(km1 < NEW.kmStrada1)	THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Inserire chilometro valido';
		END IF;
        
        IF(km2 < NEW.kmStrada2)	THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Inserire chilometro valido';
		END IF;
END $$
		
CREATE TRIGGER aggiorna_media_voto
AFTER INSERT ON StelleUtente FOR EACH ROW

BEGIN
	SET @media_Persona = (SELECT AVG(Persona)
									 FROM StelleUtente
									 WHERE Id = new.Id
                                     );
	
	SET @media_PiacereViaggio = (SELECT AVG(PiacereViaggio)
									 FROM StelleUtente
									 WHERE Id = new.Id
                                     );		
                                     
	SET @media_Serieta =  (SELECT AVG(Serieta)
									 FROM StelleUtente
									 WHERE Id = new.Id
                                     );
	SET @media_Comportamento =  (SELECT AVG(Comportamento)
									 FROM StelleUtente
									 WHERE Id = new.Id
                                     );
	
    SET @media = (@media_Persona + @media_PiacereViaggio + @media_Serieta + @media_Comportamento)/4;
    
    IF((@media < 0) OR (@media > 5)) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
    END IF;
    
    UPDATE Utente
    SET MediaVoto = @media
    WHERE Id = NEW.Id;

END $$


-- Errore di default:
	/* SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'qualcosa';
	*/
    
CREATE TRIGGER controllo_stelle
BEFORE INSERT ON StelleUtente FOR EACH ROW
BEGIN

	IF(NEW.Persona > 5 OR NEW.Persona < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Comportamento > 5 OR NEW.Comportamento < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.PiacereViaggio > 5 OR NEW.PiacereViaggio < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Serieta > 5 OR NEW.Serieta < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
        
	END IF;

END $$

CREATE TRIGGER controllo_stelle_proponente_noleggio
BEFORE INSERT ON StelleProponenteNoleggio FOR EACH ROW
BEGIN

	IF(NEW.Persona > 5 OR NEW.Persona < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Comportamento > 5 OR NEW.Comportamento < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.PiacereViaggio > 5 OR NEW.PiacereViaggio < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Serieta > 5 OR NEW.Serieta < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
        
	END IF;

END $$


CREATE TRIGGER controllo_stelle_fruitore_noleggio
BEFORE INSERT ON StelleFruitoreNoleggio FOR EACH ROW
BEGIN

	IF(NEW.Persona > 5 OR NEW.Persona < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Comportamento > 5 OR NEW.Comportamento < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.PiacereViaggio > 5 OR NEW.PiacereViaggio < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Serieta > 5 OR NEW.Serieta < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
        
	END IF;

END $$

CREATE TRIGGER controllo_stelle_proponente_pool
BEFORE INSERT ON StelleProponentePool FOR EACH ROW
BEGIN

	IF(NEW.Persona > 5 OR NEW.Persona < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Comportamento > 5 OR NEW.Comportamento < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.PiacereViaggio > 5 OR NEW.PiacereViaggio < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Serieta > 5 OR NEW.Serieta < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
        
	END IF;

END $$

CREATE TRIGGER controllo_stelle_fruitore_pool
BEFORE INSERT ON StelleFruitorePool FOR EACH ROW
BEGIN

	IF(NEW.Persona > 5 OR NEW.Persona < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Comportamento > 5 OR NEW.Comportamento < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.PiacereViaggio > 5 OR NEW.PiacereViaggio < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Serieta > 5 OR NEW.Serieta < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
        
	END IF;

END $$

CREATE TRIGGER controllo_stelle_proponente_ride_sharing
BEFORE INSERT ON StelleProponenteRideSharing FOR EACH ROW
BEGIN

	IF(NEW.Persona > 5 OR NEW.Persona < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Comportamento > 5 OR NEW.Comportamento < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.PiacereViaggio > 5 OR NEW.PiacereViaggio < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Serieta > 5 OR NEW.Serieta < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
        
	END IF;

END $$

CREATE TRIGGER controllo_stelle_fruitore_ride_sharing
BEFORE INSERT ON StelleFruitoreRideSharing FOR EACH ROW
BEGIN

	IF(NEW.Persona > 5 OR NEW.Persona < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Comportamento > 5 OR NEW.Comportamento < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.PiacereViaggio > 5 OR NEW.PiacereViaggio < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
	
    ELSEIF(NEW.Serieta > 5 OR NEW.Serieta < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire voto valido';
        
	END IF;

END $$

CREATE TRIGGER controlla_data_scadenza_documenti
BEFORE INSERT ON Documento FOR EACH ROW

BEGIN
	IF(NEW.Scadenza < current_date()) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Documento scaduto';
	END IF;
    
    UPDATE Utente
    SET Stato = 'ATTIVO'
    WHERE Id = NEW.Id;
    
END $$ 
		
CREATE TRIGGER controlla_posizione_partenza_noleggio
BEFORE INSERT ON PosizionePartenzaNoleggio FOR EACH ROW

BEGIN
	SET @km = (SELECT Lunghezza
				FROM Strada
                WHERE CodStrada = NEW.CodStrada );
                
	IF(NEW.numChilometro > @km) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'numChilometro non valido';
	END IF;
    
END $$

CREATE TRIGGER controlla_posizione_arrivo_noleggio
BEFORE INSERT ON PosizioneArrivoNoleggio FOR EACH ROW

BEGIN
	SET @km = (SELECT Lunghezza
				FROM Strada
                WHERE CodStrada = NEW.CodStrada );
                
	IF(NEW.numChilometro > @km) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'numChilometro non valido';
	END IF;
    
END $$

CREATE TRIGGER verifica_pedaggio
BEFORE INSERT ON Pedaggio FOR EACH ROW

BEGIN
	IF(NEW.Importo < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Immettere importo valido';
	END IF;
        
	SET @strada = NEW.CodStrada;
    
    SET @tipo_strada_da_controllare = (SELECT Tipologia
										FROM Strada
                                        WHERE CodStrada = @strada);
	
    IF(@tipo_strada_da_controllare <> 'Autostrada') THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'La strada selezionata non è una autostrada';
	END IF;
        
	SET @km = (SELECT Lunghezza
				FROM Strada
                WHERE CodStrada = @strada);
	IF(NEW.kmStrada1 < 0 OR NEW.kmStrada2 < 0 OR NEW.kmStrada1 > @km OR NEW.kmStrada2 > @km) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Immettere un chilometro corretto';
	END IF;
END $$ 



CREATE TRIGGER controlla_prenotazione_di_noleggio
BEFORE INSERT ON PrenotazioneDiNoleggio FOR EACH ROW

BEGIN
	IF(NEW.DataInizio < current_date() OR NEW.DataFine < current_date()) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Immettere una data valida';
	END IF;

	SET @fruitore = (SELECT Id
					FROM Utente
					WHERE Id = NEW.IdFruitore);
                    
	IF(@fruitore = NULL) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Immettere un utente esistente';
	END IF;
	
    SET @ruolo = (SELECT Ruolo 
				FROM Utente
				WHERE Id = NEW.IdProponente);
                
	IF(@ruolo <> 'Proponente') THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Id associato ad un utente non proponente';
	END IF;
    
    IF(NEW.Prezzo < 0) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire prezzo valido';
	END IF;
    
     SET @auto = (SELECT Targa
					FROM Utente U 
						JOIN Auto A ON U.Id = A.Id
					WHERE NEW.Targa = Targa);
                    
	IF(@auto = NULL) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Nessuna auto registrata per questo utente';
	END IF;
    
    
END $$

CREATE TRIGGER aggiungi_consumo_iniziale
BEFORE INSERT ON PrenotazioneDiNoleggio FOR EACH ROW
BEGIN
	SET @carburante = (SELECT QuantitaCarburante
						FROM StatoIniziale
                        WHERE Targa = NEW.Targa);
	
    SET NEW.QuantitaCarburanteFinale = @carburante;
    
END $$


CREATE TRIGGER aggiorna_ruolo
AFTER INSERT ON Auto FOR EACH ROW

BEGIN
	SET @ruolo = (SELECT Ruolo
				  FROM Utente
                  WHERE Id = NEW.Id);
	
    IF(@ruolo = 'Fruitore') THEN
		UPDATE Utente
        SET Ruolo = 'Proponente'
        WHERE Id = NEW.Id;
	END IF;
END $$


CREATE TRIGGER verifica_immissione
BEFORE INSERT ON CorsieDiImmissione
FOR EACH ROW
BEGIN
	IF NEW.CodStrada1 = NEW.CodStrada2 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Le trade non possono essere uguali!';
	END IF;
END $$




CREATE TRIGGER verifica_limite_di_velocita
BEFORE INSERT ON LimitiDiVelocita FOR EACH ROW
BEGIN
	IF (NEW.kmFine <= NEW.kmInizio) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Chilometri non validi!';
	END IF;
    
    IF  ((NEW.ValoreLimite < 10) OR (NEW.ValoreLimite > 130) ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Valore Limite di velocità non valido';
	END IF;
    
    SET @chilometri = (SELECT Lunghezza
						FROM Strada
						WHERE CodStrada = NEW.CodStrada);
	
    IF( (NEW.kmFine > @chilometri) OR (NEW.kmInizio > @chilometri) OR (NEW.kmFine < 0) OR (NEW.kmInizio <0) ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Immettere un chilometro valido';
	END IF;
    
END $$


CREATE TRIGGER controlla_posizione_arrivo_sharing
BEFORE INSERT ON PosizioneArrivoSharing FOR EACH ROW

BEGIN
	SET @km = (SELECT Lunghezza
				FROM Strada
                WHERE CodStrada = NEW.CodStrada );
                
	IF(NEW.numChilometro > @km) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'numChilometro non valido';
	END IF;
    
END $$
 
 
 CREATE TRIGGER controlla_posizione_partenza_sharing
BEFORE INSERT ON PosizionePartenzaSharing FOR EACH ROW

BEGIN
	SET @km = (SELECT Lunghezza
				FROM Strada
                WHERE CodStrada = NEW.CodStrada );
                
	IF(NEW.numChilometro > @km) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'numChilometro non valido';
	END IF;
    
END $$


CREATE TRIGGER archivia_prenotazioni_di_noleggio
AFTER UPDATE ON PrenotazioneDiNoleggio FOR EACH ROW

BEGIN
	IF(NEW.Stato = 'CHIUSO') THEN
		INSERT ArchivioPrenotazioniVecchie
		SET CodNoleggio = NEW.CodNoleggio, DataInizio = NEW.DataInizio, DataFine = NEW.DataFine, IdFruitore 		= NEW.IdFruitore, Targa = NEW.Targa, IdProponente = NEW.IdProponente;
		DELETE FROM PrenotazioneDiNoleggio
		WHERE CodNoleggio = NEW.CodNoleggio;
    END IF;
    
    IF(NEW.Stato = 'RIFIUTATO') THEN
		INSERT ArchivioPrenotazioniRifiutate
		SET CodNoleggio = NEW.CodNoleggio, IdFruitore = NEW.IdFruitore, Targa = NEW.Targa, IdProponente = 		 NEW.IdProponente;
		DELETE FROM PrenotazioneDiNoleggio
		WHERE CodNoleggio = NEW.CodNoleggio;
    END IF;
    
    
END $$
	

CREATE TRIGGER controllo_sinistro_noleggio		
BEFORE INSERT ON SinistroNoleggio FOR EACH ROW

BEGIN
	IF(NEW.Orario > current_timestamp()) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire orario valido';
	END IF;
    
    SET @strada = (SELECT CodStrada
					FROM Strada
                    WHERE CodStrada = NEW.CodStrada);
                    
	 SET @chilometro = (SELECT Lunghezza
						FROM Strada
						WHERE CodStrada = NEW.CodStrada);
                    
	IF( (@strada = NULL) OR (NEW.kmStrada < 0) OR (NEW.kmStrada > @chilometro) ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire strada valida';
	END IF;
    
    
    IF( (NEW.PercentualeDiResponsabilita < 0) OR (NEW.PercentualeDiResponsabilita > 100) ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire percentuale valida';
	END IF;
    
    SET @modello = (SELECT Modello
					FROM Caratteristiche
                    WHERE Targa = NEW.TargaVeicoloProponente);
	SET NEW.Modello = @modello;
    
    SET @casaautomobilistica = (SELECT CasaProduttrice
								FROM Caratteristiche
                                WHERE Targa = NEW.TargaVeicoloProponente);
	SET NEW.CasaAutomobilistica = @casaautomobilistica;
    
END $$


CREATE TRIGGER controllo_generalita_sinistro_noleggio
BEFORE INSERT ON GeneralitaSinistroNoleggio FOR EACH ROW

BEGIN
	SET @numDocumento = (SELECT NumDocumento
						 FROM Documento D
							JOIN Utente U ON D.Id = U.Id
						 WHERE NEW.NumDocumento = NumDocumento);
                         
	IF((@numDocumento = NULL) OR (@numDocumento <> NEW.NumDocumento) ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Documento inserito non valido';
	END IF;
    
    SET @codFiscale = (SELECT CodFiscale
						FROM Utente U
							JOIN Documento D ON U.Id = D.Id
						WHERE NumDocumento = NEW.NumDocumento);
                        
	IF(@codFiscale = NULL) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente inserito non valido';
	END IF;
    
END$$


CREATE TRIGGER aggiungi_documento_sinistro_noleggio		#inserite le generalità di un utente inserisce 
													    # il suo documento
AFTER INSERT ON GeneralitaSinistroNoleggio FOR EACH ROW

BEGIN
	INSERT DocumentoDiIdentitaSinistroNoleggio
    SELECT NumDocumento, Tipologia, Scadenza, EnteRilascio
    FROM Documento
	WHERE NumDocumento = NEW.NumDocumento;
    
END $$
 
CREATE TRIGGER controllo_pool
BEFORE INSERT ON Pool FOR EACH ROW

BEGIN
	DECLARE postiauto INT DEFAULT 0;
	
	IF(NEW.GiornoArrivo < NEW.GiornoPartenza) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire un orario valido';
	END IF;
    
    SET @proponente = (SELECT Id
						FROM Utente
						WHERE NEW.IdProponente = Id);
                        
	IF(@proponente = NULL) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente non trovato';
	END IF;
    
    SET @ruolo = (SELECT Ruolo
					FROM Utente
					WHERE NEW.IdProponente = Id);
	
    
    IF(@ruolo <> 'Proponente') THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente inserito non registrato come proponente';
	END IF;
    
    SET @auto = (SELECT Targa
					FROM Utente U 
						JOIN Auto A ON U.Id = A.Id
					WHERE NEW.Targa = Targa);
                    
	IF(@auto = NULL) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Nessuna auto registrata per questo utente';
	END IF;
    
    SET postiauto = (SELECT NumPosti
					 FROM Caratteristiche
                     WHERE NEW.Targa = Targa);
    
    IF((NEW.NumPosti < 0) OR (NEW.NumPosti > postiauto)) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire un numero di posti valido';
	END IF;
    
    SET NEW.numPosti = postiauto - 1;
		
END $$

CREATE TRIGGER controllo_posto_disponibile_pool
BEFORE UPDATE ON Pool FOR EACH ROW
BEGIN
	IF(NEW.numPosti < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Il pool è pieno';
	END IF;
    
END $$ 

CREATE TRIGGER controllo_posto_disponibile_sharing
BEFORE INSERT ON AdesioniRideSharing FOR EACH ROW
BEGIN
	DECLARE postidisponibili INT DEFAULT 0;
    DECLARE postioccupati INT DEFAULT 0;
    DECLARE postirimanenti INT DEFAULT 0;
    
    SET postidisponibili = (SELECT NumPosti
							FROM RideSharing RS
                            WHERE RS.CodSharing = NEW.CodSharing);
                            
	SET postioccupati = (SELECT COUNT(*)
						 FROM AdesioniRideSharing ARS
                         WHERE NEW.CodSharing = ARS.CodSharing);
                         
	SET postirimanenti = postidisponibili - postioccupati;
	
    IF(postirimanenti - 1 < 0) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Lo sharing è pieno';
	END IF;

END$$ 


CREATE TRIGGER archivia_pool
AFTER UPDATE ON Pool FOR EACH ROW

BEGIN
	IF(NEW.Stato = 'CHIUSO') THEN
		INSERT ArchivioPoolVecchi
        SET CodPool = NEW.CodPool, GradoFlessibilita = NEW.GradoFlessibilita, GiornoArrivo = NEW.GiornoArrivo, GiornoPartenza = NEW.GiornoPartenza, Targa = NEW.Targa, IdProponente = NEW.IdProponente;
		DELETE FROM Pool
		WHERE CodPool = NEW.CodPool;
   END IF;
    
END $$


CREATE TRIGGER controlla_posizione_arrivo_pool
BEFORE INSERT ON PosizioneArrivoPool FOR EACH ROW

BEGIN
	SET @km = (SELECT Lunghezza
				FROM Strada
                WHERE CodStrada = NEW.CodStrada );
                
	IF(NEW.numChilometro > @km) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'numChilometro non valido';
	END IF;
    
END $$


CREATE TRIGGER controlla_posizione_partenza_pool
BEFORE INSERT ON PosizionePartenzaPool FOR EACH ROW

BEGIN
	SET @km = (SELECT Lunghezza
				FROM Strada
                WHERE CodStrada = NEW.CodStrada );
                
	IF(NEW.numChilometro > @km) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'numChilometro non valido';
	END IF;
    
END $$

CREATE TRIGGER controllo_sinistro_pool
BEFORE INSERT ON SinistroPool FOR EACH ROW

BEGIN
	IF(NEW.Orario > current_timestamp()) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire orario valido';
	END IF;
    
    SET @strada = (SELECT CodStrada
					FROM Strada
                    WHERE CodStrada = NEW.CodStrada);
                    
	 SET @chilometro = (SELECT Lunghezza
						FROM Strada
						WHERE CodStrada = NEW.CodStrada);
                    
	IF( (@strada = NULL) OR (NEW.kmStrada < 0) OR (NEW.kmStrada > @chilometro) ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire strada valida';
	END IF;
    
    
    IF( (NEW.PercentualeDiResponsabilita < 0) OR (NEW.PercentualeDiResponsabilita > 100) ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire percentuale valida';
	END IF;
    
    SET @modello = (SELECT Modello
					FROM Caratteristiche
                    WHERE Targa = NEW.TargaVeicoloProponente);
	SET NEW.Modello = @modello;
    
    SET @casaautomobilistica = (SELECT CasaProduttrice
								FROM Caratteristiche
                                WHERE Targa = NEW.TargaVeicoloProponente);
	SET NEW.CasaAutomobilistica = @casaautomobilistica;
END $$


CREATE TRIGGER controllo_generalita_sinistro_pool
BEFORE INSERT ON GeneralitaSinistroPool FOR EACH ROW

BEGIN
	SET @numDocumento = (SELECT NumDocumento
						 FROM Documento D
							JOIN Utente U ON D.Id = U.Id
						 WHERE NEW.NumDocumento = NumDocumento);
                         
	IF((@numDocumento = NULL) OR (@numDocumento <> NEW.NumDocumento) ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Documento inserito non valido';
	END IF;
    
    SET @codFiscale = (SELECT CodFiscale
						FROM Utente U
							JOIN Documento D ON U.Id = D.Id
						WHERE NumDocumento = NEW.NumDocumento);
                        
	IF(@codFiscale = NULL) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente inserito non valido';
	END IF;
    
END$$


CREATE TRIGGER aggiungi_documento_sinistro_pool		#inserite le generalità di un utente inserisce 
													    # il suo documento
AFTER INSERT ON GeneralitaSinistroPool FOR EACH ROW

BEGIN
	INSERT DocumentoDiIdentitaSinistroPool
    SELECT NumDocumento, Tipologia, Scadenza, EnteRilascio
    FROM Documento
	WHERE NumDocumento = NEW.NumDocumento;
    
END $$

CREATE TRIGGER controlla_somma_costi
BEFORE INSERT ON SommaCostiAttualePool FOR EACH ROW

BEGIN
	IF(NEW.ConsumoCarburante < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire importo valido';
	END IF;
    
    IF(NEW.CostoCarburante < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente inserito non valido';
	END IF;
    
    
    IF(NEW.CostoOperativo < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente inserito non valido';
	END IF;
    
    IF(NEW.CostoUsura < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente inserito non valido';
	END IF;
    
    IF(NEW.ConsumoUrbano < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente inserito non valido';
	END IF;
    
    IF(NEW.ConsumoExtraurbano < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente inserito non valido';
	END IF;
    
    IF(NEW.ConsumoMisto < 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente inserito non valido';
	END IF;
    
END $$
 
CREATE TRIGGER aggiungi_somma_costi_pool
AFTER INSERT ON Pool FOR EACH ROW

BEGIN

	SET @auto = (SELECT Targa
				 FROM Auto 
                 WHERE Targa = NEW.Targa);
     
	SET @urbano = (SELECT Urbano
					FROM ConsumoMedio
                    WHERE Targa = @auto);
	
	SET @extraurbano = (SELECT ExtraUrbano
					FROM ConsumoMedio
                    WHERE Targa = @auto);
                    
	SET @misto = (SELECT Misto
					FROM ConsumoMedio
                    WHERE Targa = @auto);
                    
    SET @usura = (SELECT CostoUsura
					FROM StatoIniziale
                    WHERE Targa = @auto);
                    
     SET @alimentazione = (SELECT Alimentazione
							FROM Caratteristiche
							WHERE Targa = @auto);               
	CASE 
		WHEN @alimentazione = 'Gasolio' THEN
			SET @costoCarburante = 1.5;
		WHEN @alimentazione = 'Benzina' THEN
			SET @costoCarburante = 1.6;
		WHEN @alimentazione = 'Gpl' THEN
			SET @costoCarburante = 0.7;
		WHEN @alimentazione = 'Metano' THEN
			SET @costoCarburante = 1;
		WHEN @alimentazione = 'Elettrica' THEN
			SET @costoCarburante = 0.01; -- 60 minuti di ricarica* 0.025 costo medio ricarica ENEL = 										-- 1.5€ per un autonomia media di 150 km.
	END CASE;
    
	INSERT SommaCostiAttualePool
    SET ConsumoUrbano = @urbano, ConsumoExtraUrbano = @extraurbano, ConsumoMisto = @misto, CodPool = NEW.CodPool, CostoUsura = @usura, CostoCarburante = @costoCarburante;
    
END $$


CREATE TRIGGER aggiungi_somma_costi_vecchia_pool
AFTER INSERT ON ArchivioPoolVecchi FOR EACH ROW

BEGIN
	INSERT SommaCostiVecchiaPool
    SELECT * 
    WHERE CodPool = NEW.CodPool;
END $$

CREATE TRIGGER aggiorna_posti_disponibili_pool
AFTER INSERT ON AdesioniPool FOR EACH ROW
BEGIN
	UPDATE Pool
    SET NumPosti = NumPosti - 1
    WHERE CodPool = NEW.CodPool;
END $$

CREATE TRIGGER controlla_consumo_medio
BEFORE INSERT ON ConsumoMedio FOR EACH ROW

BEGIN
			SET @targa = (SELECT Targa
							FROM Auto
							WHERE Targa = NEW.Targa);
                            
			IF(@targa = NULL) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Auto non presente nel db';
			END IF;

			IF(NEW.Urbano < 0) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Importo inserito non valido';
			END IF;
            
            IF(NEW.ExtraUrbano < 0) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Importo inserito non valido';
			END IF;
            
            IF(NEW.Misto < 0) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Importo inserito non valido';
			END IF;
            
END $$


CREATE TRIGGER controlla_caratteristiche
BEFORE INSERT ON Caratteristiche FOR EACH ROW 

BEGIN
			IF((NEW.NumPosti < 0) OR (NEW.NumPosti > 9)) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Inserire numero di posti valido';
			END IF;
            
            SET @targa = (SELECT Targa
							FROM Auto
							WHERE Targa = NEW.Targa);
                            
			IF(@targa = NULL) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Auto non presente nel db';
			END IF;
            
            IF ((NEW.VelocitaMax < 0) OR (NEW.VelocitaMax > 300)) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Velocità inserita non valida';
			END IF;
            
            IF(NEW.AnnoImmatricolazione > current_timestamp() ) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Anno inserito non valido';
			END IF;
            
            IF(NEW.Cilindrata < 0) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cilindrata inserita non valida';
			END IF;
END $$
            
CREATE TRIGGER controlla_stato_iniziale
BEFORE INSERT ON StatoIniziale FOR EACH ROW

BEGIN
			SET @targa = (SELECT Targa
							FROM Auto
							WHERE Targa = NEW.Targa);
                            
			IF(@targa = NULL) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Auto non presente nel db';
			END IF;
            
            IF(NEW.kmPercorsi < 0) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Km non validi';
			END IF;
            
            IF(NEW.QuantitaCarburante < 0) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Carburante inserito non valido';
			END IF;
            
            IF(NEW.CostoUsura < 0) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'CostoUsura inserito non valido';
			END IF;
END $$

CREATE TRIGGER controlla_optional
BEFORE INSERT ON Optional FOR EACH ROW

BEGIN
			IF(NEW.Peso < 0) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Peso inserito non valido';
			END IF;
            
            IF(NEW.ValutazioneAuto < 0) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'ValutazioneAuto inserita non valida';
			END IF;
            
            IF(NEW.RumoreMedio < 0) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'RumoreMedio inserito non valido';
			END IF;
            
END $$


CREATE TRIGGER aggiorna_servizio_car_sharing
AFTER INSERT ON PrenotazioneDiNoleggio FOR EACH ROW

BEGIN
	UPDATE Auto
    SET ServizioCarSharing = '1'
    WHERE Targa = NEW.Targa;
END $$

CREATE TRIGGER aggiorna_servizio_car_pooling
AFTER INSERT ON Pool FOR EACH ROW

BEGIN
	UPDATE Auto
    SET ServizioPooling = '1'
    WHERE Targa = NEW.Targa;
END $$

CREATE TRIGGER aggiorna_servizio_ride_sharing
AFTER INSERT ON RideSharing FOR EACH ROW

BEGIN
	UPDATE Auto
    SET ServizioRideSharing = '1'
    WHERE Targa = NEW.Targa;
END $$

CREATE TRIGGER aggiorna_stato_utente_dopo_eliminazione_auto
BEFORE DELETE ON Auto FOR EACH ROW

BEGIN
	SET @autorimanenti = (SELECT COUNT (Targa)
							FROM Auto 
							WHERE Id = OLD.Id);

	IF(@autorimanenti = 0) THEN
		UPDATE Utente
		SET Ruolo = 'Fruitore'
		WHERE Id = OLD.Id;
	END IF;
	
END $$

CREATE TRIGGER aggiungi_tragitto
AFTER INSERT ON Pool FOR EACH ROW
BEGIN
	INSERT TragittoPool
    SET CodPool = NEW.CodPool, kmPercorsi = 0;
END $$


CREATE TRIGGER calcolo_km_percorsi
AFTER INSERT ON StradeTragittoPool FOR EACH ROW
BEGIN
	DECLARE chilometraggio INT DEFAULT 0;
    SET chilometraggio = NEW.kmFineStrada - NEW.kmInizioStrada;
	
	UPDATE TragittoPool
    SET kmPercorsi = kmPercorsi + chilometraggio
    WHERE CodPool = NEW.CodPool;
    
        
END $$ 
        

CREATE TRIGGER controllo_chiamata_ride_sharing
BEFORE INSERT ON ChiamataRideSharing FOR EACH ROW

BEGIN
	SET @strada = (SELECT COUNT (CodStrada)
					FROM Strada
                    WHERE CodStrada = NEW.CodStrada);
		
	IF(@strada = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Strada non trovata';
	END IF;
    
    SET @fruitore = (SELECT COUNT (Id)
					 FROM Utente 
					 WHERE Id = NEW.IdFruitore);
	
    IF(@fruitore = 0)	THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente non trovato';
	END IF;
		
END $$

CREATE TRIGGER archivio_chiamate_sharing
AFTER UPDATE ON ChiamataRideSharing FOR EACH ROW

BEGIN
	IF(NEW.Stato = 'RIFIUTATA') THEN
		INSERT ArchivioChiamateSharingRifiutate
        SET CodChiamata = NEW.CodChiamata = NEW.Timestamp, IdFruitore = NEW.IdFruitore, CodStrada = NEW.CodStrada, kmStrada = NEW.kmStrada;
	END IF;
    
END $$


CREATE TRIGGER controllo_ride_sharing
BEFORE INSERT ON RideSharing FOR EACH ROW

BEGIN
	 DECLARE postiauto INT DEFAULT 0;

	SET @fruitore = (SELECT COUNT(Id)
					 FROM Utente
                     WHERE Id = NEW.IdFruitore);
                     
	SET @proponente = (SELECT COUNT(Id)
						FROM Utente
                        WHERE Id = NEW.IdProponente);
                        
	IF((@fruitore = 0) OR (@proponente = 0)) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente non trovato';
	END IF;
    
    
   -- -- -- -- -- --
	
	
    SET @ruolo = (SELECT Ruolo
					FROM Utente
					WHERE NEW.IdProponente = Id);
	
    
    IF(@ruolo <> 'Proponente') THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente inserito non registrato come proponente';
	END IF;
    
    SET @auto = (SELECT Targa
					FROM Utente U 
						JOIN Auto A ON U.Id = A.Id
					WHERE NEW.Targa = Targa);
                    
	IF(@auto = NULL) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Nessuna auto registrata per questo utente';
	END IF;
    
    SET postiauto = (SELECT NumPosti
					 FROM Caratteristiche
                     WHERE NEW.Targa = Targa);
    
    IF((NEW.NumPosti < 0) OR (NEW.NumPosti > postiauto)) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire un numero di posti valido';
	END IF;
    
    SET NEW.numPosti = postiauto - 1;
		
    
END $$


CREATE TRIGGER controllo_sinistro_sharing	
BEFORE INSERT ON SinistroSharing FOR EACH ROW

BEGIN
	IF(NEW.Orario > current_timestamp()) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire orario valido';
	END IF;
    
    SET @strada = (SELECT CodStrada
					FROM Strada
                    WHERE CodStrada = NEW.CodStrada);
                    
	 SET @chilometro = (SELECT Lunghezza
						FROM Strada
						WHERE CodStrada = NEW.CodStrada);
                    
	IF( (@strada = NULL) OR (NEW.kmStrada < 0) OR (NEW.kmStrada > @chilometro) ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire strada valida';
	END IF;
    
    
    IF( (NEW.PercentualeDiResponsabilita < 0) OR (NEW.PercentualeDiResponsabilita > 100) ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire percentuale valida';
	END IF;
    
    SET @modello = (SELECT Modello
					FROM Caratteristiche
                    WHERE Targa = NEW.TargaVeicoloProponente);
	SET NEW.Modello = @modello;
    
    SET @casaautomobilistica = (SELECT CasaProduttrice
								FROM Caratteristiche
                                WHERE Targa = NEW.TargaVeicoloProponente);
	SET NEW.CasaAutomobilistica = @casaautomobilistica;
    
END $$

CREATE TRIGGER controllo_generalita_sinistro_sharing
BEFORE INSERT ON GeneralitaSinistroSharing FOR EACH ROW

BEGIN
	SET @numDocumento = (SELECT NumDocumento
						 FROM Documento D
							JOIN Utente U ON D.Id = U.Id
						 WHERE NEW.NumDocumento = NumDocumento);
                         
	IF((@numDocumento = NULL) OR (@numDocumento <> NEW.NumDocumento) ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Documento inserito non valido';
	END IF;
    
    SET @codFiscale = (SELECT CodFiscale
						FROM Utente U
							JOIN Documento D ON U.Id = D.Id
						WHERE NumDocumento = NEW.NumDocumento);
                        
	IF(@codFiscale = NULL) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Utente inserito non valido';
	END IF;
    
END$$


CREATE TRIGGER aggiungi_documento_sinistro_sharing		
AFTER INSERT ON GeneralitaSinistroSharing FOR EACH ROW

BEGIN
	INSERT DocumentoDiIdentitaSinistroSharing
    SELECT NumDocumento, Tipologia, Scadenza, EnteRilascio
    FROM Documento
	WHERE NumDocumento = NEW.NumDocumento;
    
END $$



#controlla tracking

CREATE TRIGGER controlla_tracking_sharing
BEFORE INSERT ON TrackingSharing FOR EACH ROW

BEGIN
	SET @targa = (SELECT COUNT(Targa)
				  FROM Auto
                  WHERE Targa = NEW.Targa);
	
    IF(@targa = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Auto non trovata';
	END IF;
    
    SET @strada = (SELECT COUNT(CodStrada)
					FROM Strada
					WHERE CodStrada = NEW.CodStrada);
	
    IF(@strada = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Strada non trovata';
	END IF;
    
    SET @utente = (SELECT Id
					FROM RideSharing RS JOIN Utente U ON Id = IdProponente
                    WHERE U.Id = RS.IdProponente);
	
    SET @password_ = (SELECT Password_
					 FROM Utente
                     WHERE Id = @utente);
	
    IF(@password_ <> NEW.Password_) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Password inserita errata';
	END IF;
END $$

CREATE TRIGGER controlla_tracking_noleggio
BEFORE INSERT ON TrackingNoleggio FOR EACH ROW

BEGIN
	SET @targa = (SELECT COUNT(Targa)
				  FROM Auto
                  WHERE Targa = NEW.Targa);
	
    IF(@targa = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Auto non trovata';
	END IF;
    
    SET @strada = (SELECT COUNT(CodStrada)
					FROM Strada
					WHERE CodStrada = NEW.CodStrada);
	
    IF(@strada = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Strada non trovata';
	END IF;
    
    SET @utente = (SELECT Id
					FROM PrenotazioneDiNoleggio PDN JOIN Utente U ON Id = IdProponente
                    WHERE Id = IdProponente);
	
    SET @password_ = (SELECT Password_
					 FROM Utente
                     WHERE Id = @utente);
	
    IF(@password_ <> NEW.Password_) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Password inserita errata';
	END IF;
END $$

CREATE TRIGGER controlla_tracking_pool
BEFORE INSERT ON TrackingPool FOR EACH ROW

BEGIN
	SET @targa = (SELECT COUNT(Targa)
				  FROM Auto
                  WHERE Targa = NEW.Targa);
	
    IF(@targa = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Auto non trovata';
	END IF;
    
    SET @strada = (SELECT COUNT(CodStrada)
					FROM Strada
					WHERE CodStrada = NEW.CodStrada);
	
    IF(@strada = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Strada non trovata';
	END IF;
    
    SET @utente = (SELECT Id
					FROM Pool P JOIN Utente U ON Id = IdProponente
                    WHERE Id = IdProponente);
	
    SET @password_ = (SELECT Password_
					 FROM Utente
                     WHERE Id = @utente);
	
    IF(@password_ <> NEW.Password_) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Password inserita errata';
	END IF;
END $$

#Set di trigger che si occupano di gestire l'inserimento automatico delle stelle e delle valutazioni all'interno della tabella generale dell'utente
-- Noleggio
CREATE TRIGGER aggiungi_voto_fruitore_noleggio 
AFTER INSERT ON ValutazioneFruitoreNoleggio FOR EACH ROW

BEGIN
	INSERT ValutazioneUtente
    SET CodVoto = NEW.CodVoto, Id = NEW.IdFruitore, Ruolo = 'Fruitore', Recensione = NEW.Recensione;
END $$ 

	
CREATE TRIGGER aggiungi_stelle_fruitore_noleggio 
AFTER INSERT ON StelleFruitoreNoleggio FOR EACH ROW
		
BEGIN
	INSERT StelleUtente
    SET CodVoto = NEW.CodVoto, Id = NEW.Id, Persona = NEW.Persona, PiacereViaggio = NEW.PiacereViaggio, 	Comportamento = NEW.Comportamento, Serieta = NEW.Serieta;
END $$

CREATE TRIGGER aggiungi_voto_prenotazione_di_noleggio_proponente
AFTER INSERT ON ValutazioneProponenteNoleggio FOR EACH ROW

BEGIN
	INSERT ValutazioneUtente
    SET CodVoto = NEW.CodVoto+1000, Id = NEW.IdFruitore, Ruolo = 'Fruitore', Recensione = NEW.Recensione;
END $$ 

CREATE TRIGGER aggiungi_stelle_proponente_noleggio 
AFTER INSERT ON StelleProponenteNoleggio FOR EACH ROW
		
BEGIN
	INSERT StelleUtente
    SET CodVoto = NEW.CodVoto+1000, Id = NEW.Id, Persona = NEW.Persona, PiacereViaggio = NEW.PiacereViaggio, 	Comportamento = NEW.Comportamento, Serieta = NEW.Serieta;
END $$


-- Ride Sharing

CREATE TRIGGER aggiungi_voto_ride_sharing_fruitore 
AFTER INSERT ON ValutazioneFruitoreRideSharing FOR EACH ROW

BEGIN
	INSERT ValutazioneUtente
    SET CodVoto = NEW.CodVoto+2000, Id = NEW.IdFruitore, Ruolo = 'Fruitore', Recensione = NEW.Recensione;
END $$ 

CREATE TRIGGER aggiungi_stelle_ride_sharing_fruitore #aggiunge automaticamente le stelle dei ride sharing
AFTER INSERT ON StelleFruitoreRideSharing FOR EACH ROW
		
BEGIN
	INSERT StelleUtente
    SET CodVoto = NEW.CodVoto+2000, Id = NEW.Id, Persona = NEW.Persona, PiacereViaggio = NEW.PiacereViaggio, 	Comportamento = NEW.Comportamento, Serieta = NEW.Serieta;
END $$

CREATE TRIGGER aggiungi_voto_ride_sharing_proponente
AFTER INSERT ON ValutazioneProponenteRideSharing FOR EACH ROW

BEGIN
	INSERT ValutazioneUtente
    SET CodVoto = NEW.CodVoto+3000, Id = NEW.IdProponente, Ruolo = 'Fruitore', Recensione = NEW.Recensione;
END $$ 

CREATE TRIGGER aggiungi_stelle_ride_sharing_proponente #aggiunge automaticamente le stelle dei ride sharing
AFTER INSERT ON StelleProponenteRideSharing FOR EACH ROW
		
BEGIN
	INSERT StelleUtente
    SET CodVoto = NEW.CodVoto+3000, Id = NEW.Id, Persona = NEW.Persona, PiacereViaggio = NEW.PiacereViaggio, 	Comportamento = NEW.Comportamento, Serieta = NEW.Serieta;
END $$
    
-- Pool


CREATE TRIGGER aggiungi_stelle_proponente_pool 
AFTER INSERT ON StelleProponentePool FOR EACH ROW
		
BEGIN
	INSERT StelleUtente
    SET CodVoto = NEW.CodVoto+4000, Id = NEW.Id, Persona = NEW.Persona, PiacereViaggio = NEW.PiacereViaggio, 	Comportamento = NEW.Comportamento, Serieta = NEW.Serieta;
END $$


CREATE TRIGGER aggiungi_voto_proponente_pool
AFTER INSERT ON ValutazioneProponentePool FOR EACH ROW

BEGIN
	INSERT ValutazioneUtente
    SET CodVoto = NEW.CodVoto+4000, Id = NEW.IdProponente, Ruolo = 'Fruitore', Recensione = NEW.Recensione;
END $$ 

CREATE TRIGGER aggiungi_stelle_fruitore_pool 
AFTER INSERT ON StelleFruitorePool FOR EACH ROW
		
BEGIN
	INSERT StelleUtente
    SET CodVoto = NEW.CodVoto+5000, Id = NEW.Id, Persona = NEW.Persona, PiacereViaggio = NEW.PiacereViaggio, 	Comportamento = NEW.Comportamento, Serieta = NEW.Serieta;
END $$

CREATE TRIGGER aggiungi_voto_fruitore_pool
AFTER INSERT ON ValutazioneFruitorePool FOR EACH ROW

BEGIN
	INSERT ValutazioneUtente
    SET CodVoto = NEW.CodVoto+5000, Id = NEW.IdProponente, Ruolo = 'Fruitore', Recensione = NEW.Recensione;
END $$ 
 
CREATE TRIGGER aggiungi_orario_tracking_noleggio
BEFORE INSERT ON TrackingNoleggio FOR EACH ROW
BEGIN
	SET NEW.Timestamp_ = current_timestamp();
END $$

CREATE TRIGGER aggiungi_orario_tracking_pool
BEFORE INSERT ON TrackingPool FOR EACH ROW
BEGIN
	SET NEW.Timestamp_ = current_timestamp();
END $$
 
 CREATE TRIGGER aggiungi_orario_tracking_sharing
BEFORE INSERT ON TrackingSharing FOR EACH ROW
BEGIN
	SET NEW.Timestamp_ = current_timestamp();
END $$



 /*OPERAZIONI DI SISTEMA*/

CREATE PROCEDURE CalcolaOrarioArrivoStimato(IN _codSharing INT)
BEGIN
	DECLARE esiste INT DEFAULT 0;
	DECLARE _kminizio DOUBLE DEFAULT 0;
    DECLARE _kmfine DOUBLE DEFAULT 0;
    DECLARE _limite INT DEFAULT 0;
    DECLARE _codstrada INT DEFAULT 0;
    DECLARE finito INT DEFAULT 0;
    DECLARE densita DOUBLE DEFAULT 0;
    DECLARE tempo VARCHAR(6) DEFAULT 0;
    DECLARE autoN INT DEFAULT 0;
    DECLARE autoS INT DEFAULT 0;
    DECLARE autoP INT DEFAULT 0;
    DECLARE numeroauto INT DEFAULT 0;
    DECLARE iniziolimite DOUBLE DEFAULT 0;
    DECLARE finelimite DOUBLE DEFAULT 0;
    
    
    #scorre tutte le strada di uno sharing
    DECLARE cursorSharing CURSOR FOR
		SELECT STS.codStrada ,STS.kmInizioStrada, STS.kmFineStrada
        FROM StradeTragittoSharing STS 
				INNER JOIN RideSharing RS ON STS.CodSharing = RS.CodSharing
        WHERE RS.CodSharing = _codSharing;
	
    DECLARE cursorLimite CURSOR FOR
		SELECT ValoreLimite, kmInizio, kmFine
        FROM LimitiDiVelocita LDV 
			INNER JOIN StradeTragittoSharing STS ON STS.CodStrada = LDV.CodStrada
		WHERE 	STS.CodSharing = _codSharing;
			
        
	DECLARE CONTINUE HANDLER 
		FOR NOT FOUND SET finito = 1;
		
    
    SET esiste = (SELECT COUNT(*)
					FROM RideSharing
					WHERE CodSharing = _codSharing);
                    
	IF(esiste = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire uno sharing valido';
	END IF;
    
    OPEN cursorSharing;
   
    
    preleva: LOOP
		FETCH cursorSharing INTO _codstrada, _kminizio, _kmfine;
    
		IF(finito = 1) THEN
			LEAVE preleva;
		END IF;
        
        /*SET _limite = (SELECT ValoreLimite
						FROM LimitiDiVelocita LDV 
							INNER JOIN StradeTragittoSharing STS ON LDV.CodStrada = STS.CodStrada
						WHERE STS.CodSharing = _codSharing
							AND LDV.CodStrada = _codstrada
								AND  LDV.kmInizio <= _kminizio
									AND LDV.kmFine >= _kmfine);*/
		
			
		-- secondo loop per ciclare limiti
       OPEN cursorLimite;
		
		limite: LOOP
			FETCH cursorLimite INTO _limite, iniziolimite, finelimite;
			
            IF(finito = 1) THEN
				SET finito = 0;
				LEAVE preleva;
			END IF;
            
                    
				IF ((finelimite >= _kmfine) AND (iniziolimite > _kminizio) )  THEN
					SET tempo = tempo + ((_kmfine - iniziolimite)/_limite)*60;
                    
				ELSEIF ((finelimite < _kmfine) AND (iniziolimite >= _kminizio) )  THEN
					SET tempo = tempo + ((finelimite - iniziolimite)/_limite)*60;
                    
				ELSEIF ((finelimite >= _kmfine) AND (iniziolimite <= _kminizio) )  THEN
					SET tempo = tempo + ((_kmfine - _kminizio)/_limite)*60;
                    
				ELSEIF ((finelimite < _kmfine) AND (iniziolimite < _kminizio) )  THEN
					SET tempo = tempo + ((finelimite - _kminizio)/_limite)*60;
				
				END IF;
                
		END LOOP limite;
        
        CLOSE cursorLimite;
     
     
     
     
     -- calcolo numeroauto su strada che sto percorrendo //funziona
		
        SET autoN = (SELECT COUNT(DISTINCT Targa)
					FROM TrackingNoleggio TN
                    WHERE TN.CodStrada = _codstrada
						AND TN.kmStrada <= _kmfine
							AND TN.kmStrada >= _kminizio);
		
        SET autoP = (SELECT COUNT(DISTINCT Targa)
					FROM TrackingPool TP
                    WHERE TP.CodStrada = _codstrada
						AND TP.kmStrada <= _kmfine
							AND TP.kmStrada >= _kminizio);
                            
        SET autoS = (SELECT COUNT(DISTINCT Targa)
					FROM TrackingSharing TS
                    WHERE TS.CodStrada = _codstrada
						AND TS.kmStrada <= _kmfine
							AND TS.kmStrada >= _kminizio);
                    
		SET numeroauto = numeroauto + autoN + autoP + autoS; 
        
	
    END LOOP preleva;
        
	CLOSE cursorSharing;
    
    
    SELECT tempo;
	
    
END $$

DELIMITER ;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 /*OPERAZIONI*/

DELIMITER $$
 -- OPERAZIONE 1: REGISTRAZIONE DI UN UTENTE
DROP PROCEDURE IF EXISTS RegistraUtente $$
CREATE PROCEDURE RegistraUtente(
									IN _password VARCHAR(24), 
                                    IN _indirizzo VARCHAR(100), 
                                    IN _cognome VARCHAR(20), 
                                    IN _nome VARCHAR(20), 
                                    IN _codfiscale VARCHAR(16),
                                    IN _numdocumento VARCHAR(9),
                                    IN _tipologia VARCHAR(50),
                                    IN _scadenza DATE,
                                    IN _enterilascio VARCHAR(50)                                    
								)
BEGIN
	
    DECLARE esiste INT DEFAULT 0;
    DECLARE idutente INT DEFAULT 0;
    
    -- Verifico se l'utente già esiste
    SET esiste =	(
						SELECT COUNT(*)
						FROM 	Utente U
						WHERE	U.CodFiscale = _codfiscale
					);
    
    IF esiste = 1 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Utente già esistente';
	ELSEIF esiste = 0 THEN
		INSERT INTO Utente(Password_, Ruolo, Indirizzo, Cognome, Nome, CodFiscale, MediaVoto,DataIscrizione) VALUES (_password, 'fruitore', _indirizzo, _cognome, _nome, _codfiscale, 0,current_timestamp());
         
		SELECT	Id INTO idutente
        FROM 	Utente U
        WHERE	U.CodFiscale = _codfiscale;
         
		INSERT INTO Documento(NumDocumento, Id, Tipologia, Scadenza, EnteRilascio) VALUES (_numdocumento, idutente, _tipologia, _scadenza, _enterilascio);
    END IF;
 END $$


-- OPERAZIONE 2: ELIMINAZIONE DI UN UTENTE
CREATE PROCEDURE EliminazioneUtente(IN _id INT)
BEGIN
	
    DECLARE esiste INT DEFAULT 0;
    DECLARE idutente INT DEFAULT 0;
    
    -- Verifico se l'utente esiste
    SET esiste =	(
	    			SELECT COUNT(*)
				FROM 	Utente U
				WHERE	U.Id = _id
			);
    
    IF esiste = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Utente non esistente';
	ELSEIF esiste = 1 THEN
		DELETE FROM Utente WHERE Id = _id;
		DELETE FROM Documento WHERE Id = _id;
		DELETE FROM Auto WHERE Id = _id;
	END IF;
END $$


-- OPERAZIONE 3: VISUALIZZAZIONE CARATTERISTICHE AUTO

DROP PROCEDURE IF EXISTS CaratteristicheAuto $$
CREATE PROCEDURE CaratteristicheAuto(IN _targa VARCHAR(9))
BEGIN
	
    DECLARE esiste INT DEFAULT 0;
    
    -- Verifico se l'auto esiste
    SET esiste =(
			SELECT COUNT(*)
			FROM 	Auto A
			WHERE	A.Targa = _targa
		);
    
    IF esiste = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Auto non esistente';
	ELSEIF esiste = 1 THEN
		SELECT a.targa,c.numPosti,c.velocitaMax,c.annoImmatricolazione, c.alimentazione, c.cilindrata, c.modello,c.casaProduttrice, cm.urbano AS consumoUrbano, cm.extraUrbano AS consumoExtraUrbano, cm.misto AS consumoMisto,o.peso, o.connettivita,o.tavolino,o.tettoInVetro,o.bagagliaio,o.valutazioneAuto,o.rumoreMedio
        FROM Auto a NATURAL JOIN Optional o NATURAL JOIN ConsumoMedio cm NATURAL JOIN Caratteristiche c
        WHERE a.Targa = _targa;
        
	END IF;
END $$


-- OPERAZIONE 4: REGISTRAZIONE NUOVA AUTO

DROP PROCEDURE IF EXISTS RegistrazioneAuto $$
CREATE PROCEDURE RegistrazioneAuto	(
										IN _targa VARCHAR(9),
										IN _id INT, 
										IN _NumPosti INT,
										IN _VelocitaMax DOUBLE,
										IN _AnnoImmatricolazione INT,
										IN _Alimentazione VARCHAR(29),
                                        IN _Cilindrata INT,
                                        IN _Modello VARCHAR(29), 
										IN _CasaProduttrice VARCHAR(29), 
										IN _KmPercorsi  DOUBLE,
                                        IN _QuantitaCarburante DOUBLE,
                                        IN _CostoUsura DOUBLE,
                                        IN _Peso DOUBLE,
                                        IN _Connettività BOOL,
                                        IN _Tavolino BOOL,
                                        IN _TettoInVetro BOOL,
                                        IN _Bagagliaio DOUBLE,
                                        IN _ValutazioneAuto DOUBLE,
                                        IN _RumoreMedio DOUBLE,
                                        IN _ConsumoMedioUrbano DOUBLE,
                                        IN _ConsumoMedioExtraurbano DOUBLE,
                                        IN _ConsumoMedioMisto DOUBLE
									)
BEGIN
	
    DECLARE esiste INT DEFAULT 0;
    
    -- Verifico se l'auto già esiste
    SET esiste =	(
						SELECT COUNT(*)
						FROM 	Auto A
						WHERE	A.Targa = _targa
					);
    
    IF esiste = 1 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Auto già esistente';
	ELSEIF esiste = 0 THEN
		INSERT INTO Auto(Targa, Id) VALUES (_targa, _id);
        INSERT INTO Caratteristiche(Targa, NumPosti, VelocitaMax, AnnoImmatricolazione, Alimentazione, Cilindrata, Modello, CasaProduttrice) VALUES (_targa, _NumPosti, _VelocitaMax, _AnnoImmatricolazione, _Alimentazione, _Cilindrata, _Modello, _CasaProduttrice);
        INSERT INTO StatoIniziale(Targa, KmPercorsi, QuantitaCarburante, CostoUsura) VALUES (_targa, _KmPercorsi, _QuantitaCarburante, _CostoUsura);
        INSERT INTO Optional(Targa, Peso, Connettivita, Tavolino, TettoInVetro, Bagagliaio, ValutazioneAuto, RumoreMedio) VALUES (_targa, _Peso, _Connettivita, _Tavolino, _TettoInVetro, _Bagagliaio, _ValutazioneAuto, _RumoreMedio);
        INSERT INTO ConsumoMedio(Targa,Urbano,Extraurbano,Misto) VALUES (_targa, _ConsumoMedioUrbano, _ConsumoMedioExtraurbano,_ConsumoMedioMisto);
	END IF;
END $$


-- OPERAZIONE 5: VISUALIZZAZIONE VALUTAZIONE UTENTE
DROP PROCEDURE IF EXISTS ValutazioneUtente $$
CREATE PROCEDURE ValutazioneUtente(IN _id INT)
BEGIN
	
    DECLARE esiste INT DEFAULT 0;
    
    
    SET esiste = (
			SELECT COUNT(*)
			FROM 	Utente U
			WHERE	U.Id = _id
		 );
    
   	IF esiste = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Utente non esistente';
	ELSEIF esiste = 1 THEN
		SELECT	U.MediaVoto, AVG(S.Persona) AS Persona, AVG(S.PiacereViaggio) AS PiacereDiViaggio, AVG(S.Serieta) AS Serieta, AVG(S.Comportamento) AS Comportamento
        FROM 	Utente U NATURAL JOIN StelleUtente S
        WHERE 	U.Id = _id;
    END IF;
END $$


-- OPERAZIONE 6: CALCOLO COSTO DI UN POOL
DROP PROCEDURE IF EXISTS CostoPool $$
CREATE PROCEDURE CostoPool(IN _codpool INT)
BEGIN
	
    -- Dichiarazione delle vasiabili
    DECLARE esiste INT DEFAULT 0;
    DECLARE numKm DOUBLE DEFAULT 0;
    DECLARE costocarbutante DOUBLE DEFAULT 0;
    DECLARE usura DOUBLE DEFAULT 0;
    DECLARE urbano DOUBLE DEFAULT 0;
    DECLARE extraurbano DOUBLE DEFAULT 0;
    DECLARE misto DOUBLE DEFAULT 0;
    DECLARE stradapercorsa DOUBLE DEFAULT 0;
    DECLARE kmperstradaurbana DOUBLE DEFAULT 0;
    DECLARE kmperstradaextra DOUBLE DEFAULT 0;
    DECLARE kmperstradamista DOUBLE DEFAULT 0;
    DECLARE tipostrada VARCHAR(30) DEFAULT ' '; 
    DECLARE finito INT DEFAULT 0;
    DECLARE tot VARCHAR(4) DEFAULT 0; 	#per arrotondare 
    DECLARE kmfinest DOUBLE DEFAULT 0;
    DECLARE kminiziost DOUBLE DEFAULT 0;
    DECLARE _codstrada INT DEFAULT 0;
    
    
    -- Dichiarazione dei cursuori
    DECLARE InizioStrada CURSOR FOR
		SELECT	kmInizioStrada
		FROM	StradeTragittoPool
        WHERE	CodPool = _codpool;
		
	DECLARE FineStrada CURSOR FOR
		SELECT	kmFineStrada
		FROM	StradeTragittoPool
        WHERE	CodPool = _codpool;
	
     DECLARE Codicestrada CURSOR FOR
		SELECT	CodStrada
		FROM	StradeTragittoPool
        WHERE	CodPool = _codpool;
	
    -- Dichiarazione Handler
    DECLARE CONTINUE HANDLER
		FOR NOT FOUND SET finito = 1; 
        
    -- Verifico se l'utente già esiste
    SET esiste =	(
						SELECT COUNT(*)
						FROM 	Pool P
						WHERE	P.CodPool = _codpool
					);
                    
    
    
    IF esiste = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Pool non esistente';
	ELSEIF esiste = 1 THEN
		BEGIN
			SELECT 	TP.KmPercorsi INTO numKm
            FROM	TragittoPool TP
            WHERE	TP.CodPool = _codpool;
            
            SELECT 	S.CostoCarburante INTO costocarbutante
            FROM	SommaCostiAttualePool S
            WHERE	S.CodPool = _codpool;
            
			SELECT 	S.CostoUsura INTO usura
            FROM	SommaCostiAttualePool S
            WHERE	S.CodPool = _codpool;
            
            SELECT 	S.ConsumoUrbano INTO urbano
            FROM	SommaCostiAttualePool S
            WHERE	S.CodPool = _codpool;
            
            SELECT 	S.ConsumoExtraUrbano INTO extraurbano
            FROM	SommaCostiAttualePool S
            WHERE	S.CodPool = _codpool;
            
            SELECT 	S.ConsumoMisto INTO misto
            FROM	SommaCostiAttualePool S
            WHERE	S.CodPool = _codpool;
			
            OPEN InizioStrada;
			OPEN FineStrada;
            OPEN Codicestrada;
			
            -- Ciclo
preleva : 	LOOP
				IF finito = 1 THEN
					LEAVE preleva;
				END IF;
                
                FETCH InizioStrada INTO kminiziost;
				FETCH FineStrada INTO kmfinest;
				FETCH Codicestrada INTO _codstrada;
                
                SET stradapercorsa = kmfinest - kminiziost;
                
                SELECT 	ClassificazioneTecnica INTO tipostrada
                FROM	Strada
                WHERE	CodStrada = _codstrada;
                
                CASE
					WHEN tipostrada = 'Urbana' THEN
						SET kmperstradaurbana = kmperstradaurbana + stradapercorsa;
					WHEN tipostrada = 'ExtraUrbana' OR tipostrada = 'Autostrada' THEN
						SET kmperstradaextra = kmperstradaextra + stradapercorsa;
					WHEN tipostrada = 'Misto' THEN
						SET kmperstradamista = kmperstradamista + stradapercorsa;                        
                END CASE;
            END LOOP preleva;
            
            CLOSE InizioStrada;
			CLOSE FineStrada;
            CLOSE Codicestrada;
            
            UPDATE	SommaCostiAttualePool
			SET		CostoOperativo = numKm*usura
			WHERE	CodPool = _codpool;
            
            UPDATE	SommaCostiAttualePool
			SET		ConsumoCarburante = (kmperstradaurbana/urbano) + (kmperstradaextra/extraurbano) + (kmperstradamista/misto)
			WHERE	CodPool = _codpool;
            
            
            SET tot = (kmperstradaurbana/urbano)*costocarbutante + (kmperstradaextra/extraurbano)*costocarbutante + (kmperstradamista/misto)*costocarbutante + numKm*usura;
			SELECT tot AS CostoPool;
		END;
	END IF;
END $$


-- OPERAZIONE 7: VISUALIZZAZIONE AFFIDABILITA' UTENTE
DROP PROCEDURE IF EXISTS AffidabilitaUtente $$
CREATE PROCEDURE AffidabilitaUtente(IN _id INT)
BEGIN
	DECLARE esiste INT DEFAULT 0;
    DECLARE mediavoto DOUBLE DEFAULT 0;
	DECLARE X INT DEFAULT 0;
	DECLARE Y DOUBLE DEFAULT 0;
	DECLARE percent DOUBLE DEFAULT 0;
    DECLARE finito INT DEFAULT 0;
    DECLARE Affidabilita DOUBLE DEFAULT 0;


    DECLARE PercentCursorNoleggio CURSOR FOR
		SELECT	PercentualeDiResponsabilita
        FROM 	SinistroNoleggio 
        WHERE 	IdGuidatore = _id
				AND
				YEAR(CURRENT_DATE) -  4  < YEAR(Orario);
	
    DECLARE PercentCursorSharing CURSOR FOR
		SELECT	SS.PercentualeDiResponsabilita
        FROM 	SinistroSharing SS INNER JOIN Auto A ON SS.TargaVeicoloProponente = A.Targa
        WHERE 	A.Id = _id
				AND
				YEAR(CURRENT_DATE) -  4  < YEAR(SS.Orario);
	
    DECLARE PercentCursorPool CURSOR FOR
		SELECT	SP.PercentualeDiResponsabilita
        FROM 	SinistroPool SP INNER JOIN Auto A ON SP.TargaVeicoloProponente = A.Targa
        WHERE 	A.Id = _id
				AND
				YEAR(CURRENT_DATE) - 4 < YEAR(SP.Orario);
    
    -- Dichiarazione Handler
    DECLARE CONTINUE HANDLER
		FOR NOT FOUND SET finito = 1;  
    
    -- Verifico se l'utente già esiste
    SET esiste =	(
						SELECT COUNT(*)
						FROM 	Utente U
						WHERE	U.Id = _id
					);
    
    IF esiste = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Utente non esistente';
	ELSEIF esiste = 1 THEN
		
        SELECT 	U.MediaVoto INTO mediavoto
		FROM	Utente U
		WHERE	U.Id = _id;
        
        CASE 
			WHEN (mediavoto <= 5.0) AND (mediavoto >= 4.8) THEN
				SET X = 0;
			WHEN (mediavoto <= 4.7) AND (mediavoto >= 4.5) THEN
				SET X = 10;
			WHEN (mediavoto <= 4.4) AND (mediavoto >= 4.1) THEN
				SET X = 15;
			WHEN (mediavoto <= 4.0) AND (mediavoto >= 3.7) THEN
				SET X = 20;
			WHEN (mediavoto <= 3.6) AND (mediavoto >= 3.1) THEN
				SET X = 35;
			WHEN (mediavoto <= 3.0) AND (mediavoto >= 2.8) THEN
				SET X = 40;
			WHEN (mediavoto <= 2.4) AND (mediavoto >= 2.2) THEN
				SET X = 50;
			WHEN (mediavoto <= 1.9) AND (mediavoto >= 1.0) THEN
				SET X = 60;
			WHEN (mediavoto <= 0.9) AND (mediavoto >= 0) THEN
				SET X = 80;
			
			ELSE
				BEGIN
				END;
		END CASE;    
        
       
        
		OPEN PercentCursorNoleggio;
        
       
        
		prelevanoleggio: LOOP
        
        FETCH PercentCursorNoleggio INTO percent;
			IF finito = 1 THEN
				SET finito = 0;
				LEAVE prelevanoleggio;
			END IF;
			
			
			
		
			
			CASE 
				WHEN (percent <= 100) AND (percent >= 91) THEN
                    SET Y = Y + percent*(10/20);
				WHEN (percent <= 90) AND (percent >= 71) THEN
					SET Y = Y + percent*(6/20);
				WHEN (percent <= 70) AND (percent >= 51) THEN
					SET Y = Y + percent*(5/20);
				WHEN (percent <= 50) AND (percent >= 31) THEN
					SET Y = Y + percent*(4/20);
				WHEN (percent <= 30) AND (percent >= 21) THEN
					SET Y = Y + percent*(3/20);
				WHEN (percent <= 20) AND (percent >= 11) THEN
					SET Y = Y + percent*(2/20);
				WHEN (percent <= 10) AND (percent >= 0) THEN
					SET Y = Y + percent*(1/20);
			
				ELSE
					BEGIN
                    END;
            END CASE; 
            
		END LOOP prelevanoleggio;
        
        CLOSE PercentCursorNoleggio;
     
		OPEN PercentCursorSharing;       
        
        prelevasharing: LOOP
        FETCH PercentCursorSharing INTO percent;
			IF finito = 1 THEN
				SET finito = 0;
				LEAVE prelevasharing;
			END IF;
			
			
			
            
			
			CASE 
				WHEN (percent <= 100) AND (percent >= 91) THEN
					SET Y = Y + percent*(10/20);
				WHEN (percent <= 90) AND (percent >= 71) THEN
					SET Y = Y + percent*(6/20);
				WHEN (percent <= 70) AND (percent >= 51) THEN
					SET Y = Y + percent*(5/20);
				WHEN (percent <= 50) AND (percent >= 31) THEN
					SET Y = Y + percent*(4/20);
				WHEN (percent <= 30) AND (percent >= 21) THEN
					SET Y = Y + percent*(3/20);
				WHEN (percent <= 20) AND (percent >= 11) THEN
					SET Y = Y + percent*(2/20);
				WHEN (percent <= 10) AND (percent >= 0) THEN
					SET Y = Y + percent*(1/20);
				
                ELSE
					BEGIN
                    END;
			END CASE; 
		END LOOP prelevasharing;                    
		
        CLOSE PercentCursorSharing;

         OPEN PercentCursorPool;
         
        prelevapool: LOOP
        FETCH PercentCursorPool INTO percent;
			IF finito = 1 THEN
				LEAVE prelevapool;
			END IF;
			
			
			
		
			
			CASE 
					WHEN (percent <= 100) AND (percent >= 91) THEN
					SET Y = Y + percent*(10/20);
				WHEN (percent <= 90) AND (percent >= 71) THEN
					SET Y = Y + percent*(6/20);
				WHEN (percent <= 70) AND (percent >= 51) THEN
					SET Y = Y + percent*(5/20);
				WHEN (percent <= 50) AND (percent >= 31) THEN
					SET Y = Y + percent*(4/20);
				WHEN (percent <= 30) AND (percent >= 21) THEN
					SET Y = Y + percent*(3/20);
				WHEN (percent <= 20) AND (percent >= 11) THEN
					SET Y = Y + percent*(2/20);
				WHEN (percent <= 10) AND (percent >= 0) THEN
					SET Y = Y + percent*(1/20);
				
                ELSE
					BEGIN
                    END;
			END CASE; 
		END LOOP prelevapool; 
        
        CLOSE PercentCursorPool;
        
        
        SET Affidabilita = (40 - X) + (60 - Y);
        
        CASE
			WHEN (Affidabilita <= 50) THEN 
				UPDATE Utente U
				SET U.Affidabilita = 'BASSA'
                WHERE U.id = _id;
			WHEN (Affidabilita BETWEEN 50 AND 70) THEN 
				UPDATE Utente U
				SET U.Affidabilita = 'MEDIA'
                WHERE U.id = _id;
			WHEN (Affidabilita >= 70) THEN 
				UPDATE Utente U
				SET U.Affidabilita = 'ALTA'
                WHERE U.id = _id;
			END CASE;
       
       SELECT	Affidabilita, X, Y;
        
        
    END IF;
END $$

-- OPERAZIONE 8: Calcolo numero posti rimanenti pool
DROP PROCEDURE IF EXISTS NumeroPostiRimanentiPool $$
CREATE PROCEDURE NumeroPostiRimanentiPool(IN _codPool INT)
BEGIN 
	DECLARE postirimanenti INT DEFAULT 0;
	DECLARE postioccupati INT DEFAULT 0;
    DECLARE postidisponibili INT DEFAULT 0;
    
    SET postioccupati = (SELECT COUNT(*)
						 FROM AdesioniPool
                         WHERE CodPool = _codPool);
	
    SET postidisponibili = (SELECT NumPosti
							FROM Pool 
							WHERE CodPool = _codPool);
                            
	
    SELECT postioccupati, postidisponibili;
END $$

-- OPERAZIONE 8bis: Calcolo numero posti rimanenti su un ride sharing
DROP PROCEDURE IF EXISTS NumeroPostiRimanentiSharing $$
CREATE PROCEDURE NumeroPostiRimanentiSharing(IN _codSharing INT)
BEGIN 
	DECLARE postirimanenti INT DEFAULT 0;
	DECLARE postioccupati INT DEFAULT 0;
    DECLARE postidisponibili INT DEFAULT 0;
    
    SET postioccupati = (SELECT COUNT(CodSharing)
						 FROM AdesioniRideSharing);
	
    SET postidisponibili = (SELECT NumPosti
							FROM RideSharing 
							WHERE CodSharing = _codSharing);
                            
	SET postirimanenti = postidisponibili - postioccupati;
    
    SELECT postioccupati, postidisponibili, postirimanenti;
END $$


-- OPERAZIONE 9: CALCOLO NUMERO DI POOL E RIDE SHARING FATTI DA UN SINGOLO UTENTE
DROP PROCEDURE IF EXISTS NumeroServiziErogati $$
CREATE PROCEDURE NumeroServiziErogati(IN _id INT)
BEGIN
	
    DECLARE esiste INT DEFAULT 0;
	DECLARE n INT DEFAULT 0;
 	
    -- Verifico se l'utente già esiste
    SET esiste =	(
						SELECT 	COUNT(*)
						FROM 	Utente U
						WHERE	U.Id = _id
					);
    
    IF esiste = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Utente non esistente';
	ELSEIF esiste = 1 THEN
	SET N =	(
				SELECT	COUNT(*)
				FROM 	RideSharing
                WHERE	IdProponente = _id
			)
            +
            (
				SELECT	COUNT(*)
				FROM 	Pool
                WHERE	IdProponente = _id
            );
            
            SELECT n AS NumeroServiziErogati;
    END IF;
END $$

DELIMITER ;
 

/*INSERT*/

-- UTENTE 
CALL RegistraUtente('root' , 'Largo Catallo 11', 'Marino', 'Gabriele','PGGLRD98E28C309F','AX96439','Carta di identità','2023-03-01','Comune');
CALL RegistraUtente('root' , 'Via Strada di Salci 46', 'Poggiani', 'Leonardo','ANDR674OE9203','AE162249','Carta di identità','2023-03-01','Comune');
CALL RegistraUtente('root' , 'Via Roma 11', 'Francesca', 'Tonioni','ANRR6EWRERE9203','AC54321','Carta di identità','2023-03-01','Comune');
CALL RegistraUtente('root' , 'Via Napoli 45', 'Andrea Angelo', 'Scebba','ANRRFWEWWW9203','AW92812','Carta di identità','2023-03-01','Comune');
CALL RegistraUtente('root' , 'Via Ponticelli 12', 'Salvatore', 'Chiodi','SLVCDH98E28C309F','AM12652','Carta di identità','2021-10-21','Comune');
CALL RegistraUtente('root' , 'Via Toniolo 33', 'Matteo', 'Randazzo','MTTRZZ38E28C309F','AA12652','Carta di identità','2023-10-01','Comune');
CALL RegistraUtente('root' , 'Lungarno Mediceo 29', 'Placido', 'Longo','PCDLNG47E21C102F','AC12652','Carta di identità','2021-10-21','Comune');

-- AUTO
CALL RegistrazioneAuto('AE987CB','1','4','200','2010','Gasolio','1200','Panamera','Porsche','10000','12','0.4','10000', '1', '0', '0', '20', '12000', '24','12.4','11.2','11.5');
CALL RegistrazioneAuto('AW123OB','3','4','200','2010','Gasolio','1500','Focus','Ford','10000','12','0.4','10000', '1', '0', '0', '20', '12000', '24','18.9','17.3','18.4');

-- STRADA
INSERT INTO Strada(Tipologia, ClassificazioneTecnica, Lunghezza) VALUES ('statale', 'Urbana', '100');
INSERT INTO Strada(Tipologia, ClassificazioneTecnica, Lunghezza) VALUES ('statale', 'Urbana', '100');
-- CORSIE DI IMMISSIONE
INSERT INTO CorsieDiImmissione(CodStrada1, CodStrada2, kmStrada1, kmStrada2) VALUES ('1', '2', '10', '20');
-- LIMITI DI VELOCITA'
INSERT INTO `progetto`.`limitidivelocita` (`ValoreLimite`, `kmFine`, `kmInizio`, `CodStrada`) VALUES ('50', '20', '1', '1');
INSERT INTO `progetto`.`limitidivelocita` (`ValoreLimite`, `kmFine`,`kmInizio`, `CodStrada`) VALUES ('30', '40','1', '2');
INSERT INTO `progetto`.`limitidivelocita` (`CodLimite`, `ValoreLimite`, `kmFine`, `kmInizio`, `CodStrada`) VALUES ('3', '70', '50', '20', '1');


-- SHARING MULTIPLO
-- INSERT INTO ChiamataSharingMultiplo VALUES ('1', '2017-02-02 12:33:33' , 'Roma', '1');
-- ancora non fatto sharing  INSERT INTO SharingMultiplo(Id, codSharing1, codSharing2) 

-- RIDE SHARING
INSERT INTO TragittoSharing (kmPercorsi) VALUES ('8');
-- POSIZIONE SHARING
INSERT INTO PosizionePartenzaSharing VALUES ('1', '12');
INSERT INTO PosizioneArrivoSharing VALUES ('1', '20');
-- VALUTAZIONE RIDE SHARING


-- CAR SHARING
INSERT INTO PrenotazioneDiNoleggio (DataInizio, DataFine, idFruitore, Targa, idProponente,Prezzo) VALUES ('2019-01-01', '2019-01-01', '2', 'AE987CB', '3','100');
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
INSERT INTO `progetto`.`valutazioneproponentenoleggio` (`IdProponente`, `IdFruitore`, `Recensione`) VALUES ('3', '1', 'Si dai');

-- STELLE PROPONENTE NOLEGGIO
INSERT INTO `progetto`.`stelleproponentenoleggio` (`CodVoto`, `Id`, `Persona`, `PiacereViaggio`, `Comportamento`, `Serieta`) VALUES ('1', '1', '2', '4', '5', '1');
INSERT INTO `progetto`.`stelleproponentenoleggio` (`CodVoto`, `Id`, `Persona`, `PiacereViaggio`, `Comportamento`, `Serieta`) VALUES ('2', '1', '2', '4', '1', '5');


-- TRAGITTO NOLEGGIO
INSERT INTO TragittoNoleggio(kmPercorsi) VALUES ('20');
-- POSIZIONE NOLEGGIO
INSERT INTO PosizioneArrivoNoleggio VALUES ('1','10');
INSERT INTO PosizionePartenzaNoleggio VALUES ('1', '1');
-- SINISTR0 NOLEGGIO
INSERT INTO `progetto`.`sinistronoleggio` ( `TargaVeicoloProponente`,`IdGuidatore`, `Orario`, `CodStrada`, `KmStrada`, `Dinamica`, `PercentualeDiResponsabilita`) VALUES ('AE987CB','2', '2017-01-10 10:31:33', '1', '5', 'Na botta assurda', '55');
INSERT INTO GeneralitaSinistroNoleggio VALUES ('AE162249', 'PGGLRD98E28C309F', 'Poggiani', 'Leonardo','Via Strada di Salci 46', '345344660');
INSERT INTO `progetto`.`sinistronoleggio` ( `TargaVeicoloProponente`,`IdGuidatore`, `Orario`, `CodStrada`, `KmStrada`, `Dinamica`, `PercentualeDiResponsabilita`) VALUES ('AE987CB','2', '2017-01-10 10:35:33', '1', '5', 'Na botta assurda', '10');



-- POOL
INSERT INTO `progetto`.`pool` (`GiornoPartenza`, `GiornoArrivo`, `IdProponente`, `Targa`, `GradoFlessibilitA`) VALUES ('2018-12-11 14:00:00', '2018-12-11 15:00:00', '3', 'AW123OB', 'BASSO');
INSERT INTO `progetto`.`stradetragittopool` (`CodStrada`, `CodPool`, `kmInizioStrada`, `kmFineStrada`) VALUES ('1', '1', '2', '6');
INSERT INTO `progetto`.`stradetragittopool` (`CodStrada`, `CodPool`, `kmInizioStrada`, `kmFineStrada`) VALUES ('2', '1', '3', '10');
INSERT INTO `progetto`.`adesionipool` (`CodPool`, `IdFruitore`) VALUES ('1','2');
INSERT INTO `progetto`.`adesionipool` (`CodPool` ,`IdFruitore`) VALUES ('1','4');
INSERT INTO `progetto`.`adesionipool` (`CodPool`, `IdFruitore`) VALUES ('1', '3');


-- SINISTRO POOL
INSERT INTO `progetto`.`sinistropool` (`TargaVeicoloProponente`, `Orario`, `KmStrada`, `CodStrada`, `Dinamica`, `PercentualeDiResponsabilita`) VALUES ('AW123OB', '2018-11-12 15:00:00', '3', '1', 'Addosso a un palo', '80');
INSERT INTO `progetto`.`generalitasinistropool` (`NumDocumento`, `CodFiscale`, `Cognome`, `Nome`, `Indirizzo`, `NumTelefono`) VALUES ('AC54321', 'ANRR6EWRERE9203', 'Tonioni', 'Francesca', 'Via Roma 11', '344405678');

-- RIDE SHARING
INSERT INTO `progetto`.`ridesharing` (`IdProponente`, `IdFruitore`, `OraPartenza`, `OraStimatoArrivo`, `Targa`) VALUES ('1', '2', '2019-10-11 15:00:00', '2019-10-11 16:00:00', 'AE987CB');
INSERT INTO `progetto`.`adesioniridesharing` (`CodSharing`, `IdUtente`) VALUES ('1', '4');
INSERT INTO `progetto`.`adesioniridesharing` (`CodSharing`, `IdUtente`) VALUES ('1', '5');
INSERT INTO `progetto`.`adesioniridesharing` (`CodSharing`, `IdUtente`) VALUES ('1', '6');
INSERT INTO `progetto`.`stradetragittosharing` (`CodStrada`, `CodSharing`, `kmInizioStrada`, `kmFineStrada`) VALUES ('1', '1', '1', '40');
INSERT INTO `progetto`.`stradetragittosharing` (`CodStrada`, `CodSharing`, `kmInizioStrada`, `kmFineStrada`) VALUES ('2', '1', '1', '20');


-- TRACKING SHARING
	INSERT INTO `progetto`.`trackingsharing` (`Targa`, `CodStrada`, `CodSharing`, `Password_`, `kmStrada`) VALUES ('AE987CB', '1', '1', 'root', '4');
INSERT INTO `progetto`.`trackingsharing` (`Targa`, `CodStrada`, `CodSharing`, `Password_`, `kmStrada`) VALUES ('AE987CB', '1', '1', 'root', '6');


