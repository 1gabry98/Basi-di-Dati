DROP DATABASE IF EXISTS Progetto;
CREATE DATABASE Progetto;

USE PROGETTO;

CREATE TABLE Utente 
(
    Id INT NOT NULL AUTO_INCREMENT,
    Password_ VARCHAR(128) NOT NULL,
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
    CodChiamata INT NOT NULL AUTO_INCREMENT,
    CodStradaArrivo INT NOT NULL,
    kmStradaArrivo INT NOT NULL,
	CodStradaPartenza INT NOT NULL,
    kmStradaPartenza INT NOT NULL,
    Stato ENUM('ATTIVA','CHIUSA','RIFIUTATA')DEFAULT 'ATTIVA',
	TimeStamp TIMESTAMP NOT NULL,
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
    CodSharing1 INT ,
    CodSharing2 INT ,
        PRIMARY KEY(CodSharingMultiplo),
        FOREIGN KEY(Id) 
        REFERENCES Utente(Id)
        ON DELETE CASCADE
);


CREATE TABLE TragittoSharing 
(
    CodTragitto INT NOT NULL AUTO_INCREMENT,
    CodSharing INT NOT NULL,
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
	CodSharing INT NOT NULL,
    CodStrada INT NOT NULL,
    numChilometro DOUBLE NOT NULL,
        PRIMARY KEY(CodStrada,CodSharing),
        FOREIGN KEY(CodStrada) 
        REFERENCES Strada(CodStrada)
        ON DELETE CASCADE
);




CREATE TABLE PosizioneArrivoSharing (
CodSharing INT NOT NULL,
CodStrada INT NOT NULL,
numChilometro DOUBLE NOT NULL,
    PRIMARY KEY(CodStrada,CodSharing),
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
    Password_ VARCHAR(128) NOT NULL,
    kmStrada INT NOT NULL,
    Timestamp_ TIMESTAMP NOT NULL,
        PRIMARY KEY (Targa , CodStrada,kmstrada ,Timestamp_),
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
    GradoFlessibilita ENUM ('BASSO', 'MEDIO', 'ALTO'),
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
	CodPool INT NOT NULL,
    CodStrada INT NOT NULL,
    numChilometro DOUBLE NOT NULL,
        PRIMARY KEY(CodStrada),
        FOREIGN KEY(CodStrada) 
        REFERENCES Strada(CodStrada)
        ON DELETE CASCADE
);


CREATE TABLE PosizionePartenzaPool
(
	CodPool INT NOT NULL,
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
    CodStradaArrivo INT NOT NULL,
    kmStradaArrivo INT NOT NULL,
	CodStradaPartenza INT NOT NULL,
    kmStradaPartenza INT NOT NULL,
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
    OraStimatoArrivo  TIMESTAMP,
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
    Password_ VARCHAR(128) NOT NULL,
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
    Password_ VARCHAR(128) NOT NULL,
    kmStrada INT NOT NULL,
    Timestamp_ TIMESTAMP NOT NULL,
        PRIMARY KEY (Targa , CodStrada, kmStrada, Timestamp_),
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
		PRIMARY KEY (CodStrada,CodSharing),
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
		PRIMARY KEY (CodStrada1, CodStrada2,kmStrada1,kmStrada2),
        FOREIGN KEY (CodStrada1)
        REFERENCES Strada(CodStrada)
        ON DELETE CASCADE,
        
        FOREIGN KEY (CodStrada2)
        REFERENCES Strada(CodStrada)
        ON DELETE CASCADE
);

CREATE TABLE Variazione
(
	CodVariazione INT NOT NULL AUTO_INCREMENT,
    IdRichiedente INT NOT NULL,
    Codstrada INT NOT NULL,
    kmAggiunta INT NOT NULL,
	CodPool INT NOT NULL,
    Stato ENUM ('ACCETTATA','RIFIUTATA','in attesa') DEFAULT 'in attesa',
		PRIMARY KEY (CodVariazione),
        
        FOREIGN KEY (CodStrada)
        REFERENCES Strada(CodStrada)
        ON DELETE CASCADE,
        
        FOREIGN KEY (CodPool)
        REFERENCES Pool(CodPool)
        ON DELETE CASCADE
);


/*TRIGGER*/ -- ------------------------------------------------------------------------------------------------
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
				FROM Strada S
					INNER JOIN StradeTragittoSharing STS ON S.CodStrada = STS.CodStrada
                WHERE S.CodStrada = NEW.CodStrada
					AND STS.CodSharing = NEW.CodSharing);
                
	IF(NEW.numChilometro > @km) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'numChilometro non valido';
	END IF;
    
END $$
 
 
CREATE TRIGGER controlla_posizione_partenza_sharing
BEFORE INSERT ON PosizionePartenzaSharing FOR EACH ROW

BEGIN
	SET @km = (SELECT Lunghezza
				FROM Strada S
					INNER JOIN StradeTragittoSharing STS ON S.CodStrada = STS.CodStrada
                WHERE S.CodStrada = NEW.CodStrada 
					AND STS.CodSharing = NEW.CodSharing);
                
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

CREATE TRIGGER aggiorna_km_percorsi_dopo_variazione
AFTER UPDATE ON StradeTragittoPool FOR EACH ROW
BEGIN
	UPDATE TragittoPool
    SET kmPercorsi = kmpercorsi + ABS((NEW.kmInizioStrada - OLD.kmInizioStrada) + ABS(NEW.kmFineStrada - OLD.kmFineStrada))
    WHERE CodPool = NEW.CodPool;
END $$
        

CREATE TRIGGER archivio_chiamate_sharing
AFTER UPDATE ON ChiamataRideSharing FOR EACH ROW

BEGIN
	IF(NEW.Stato = 'RIFIUTATA') THEN
		INSERT ArchivioChiamateSharingRifiutate
        SET CodChiamata = NEW.CodChiamata = NEW.Timestamp, IdFruitore = NEW.IdFruitore, CodStradaPartenza = NEW.CodStradaPartenza, kmStradaPartenza = NEW.kmStradaPartenza,CodStradaArrivo = NEW.CodStradaArrivo, kmStradaArrivo = NEW.kmStradaArrivo;
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



-- Trigger per aggiornamento tracking

CREATE TRIGGER inizio_sharing
AFTER INSERT ON PosizionePartenzaSharing FOR EACH ROW
BEGIN
	DECLARE _targa VARCHAR(7);
    DECLARE _password VARCHAR(100);
    
   SET _targa = (SELECT RS.Targa
					FROM RideSharing RS
						INNER JOIN Auto A ON RS.Targa = A.Targa
                    WHERE CodSharing = NEW.CodSharing);
                    
	SET _password = (SELECT Password_
						FROM Utente U 
							INNER JOIN RideSharing RS ON RS.IdProponente = U.id
						WHERE RS.CodSharing = NEW.CodSharing);
	
    INSERT TrackingSharing
    SET Targa = _targa, CodStrada = NEW.CodStrada,CodSharing = NEW.CodSharing, Password_ = _password, kmStrada = NEW.numChilometro, Timestamp_ = current_timestamp();
    
END $$

                     
CREATE EVENT aggiornamento_ride_sharing
ON SCHEDULE EVERY 5 MINUTE
DO BEGIN
	DECLARE orariopartenza DATETIME;
    DECLARE orarioarrivo DATETIME;
    
	SELECT OraPartenza,OraStimatoArrivo INTO orariopartenza, orarioarrivo
    FROM RideSharing
    WHERE OraPartenza > current_timestamp() AND OraStimatoArrivo < current_timestamp();
		
	UPDATE TrackingSharing
	SET  kmstrada = kmstrada + 5, Timestamp_ = current_timestamp()
	WHERE  current_timestamp() > orariopartenza AND orarioarrivo < current_timestamp();

END ;

CREATE TRIGGER controlla_se_strada_finita
BEFORE UPDATE ON TrackingSharing FOR EACH ROW
BEGIN
	DECLARE kmfine INT DEFAULT 0;
    DECLARE nuovaStrada INT DEFAULT 0;
    
    SET kmfine = (SELECT kmFineStrada
					FROM StradeTragittoSharing
                    WHERE CodSharing = NEW.codSharing
						AND CodStrada = NEW.codStrada);
	
    SET nuovaStrada = (SELECT CodStrada
						FROM StradeTragittoSharing
                        WHERE CodSharing = NEW.CodSharing	
							AND CodStrada = NEW.CodStrada + 1);
                            
	IF( (NEW.kmStrada > kmfine) AND (nuovaStrada <> NULL) ) THEN
		SET NEW.CodStrada = NEW.CodStrada + 1;
	END IF;
END $$


CREATE TRIGGER inizia_pool
AFTER INSERT ON PosizionePartenzaPool FOR EACH ROW
BEGIN
    DECLARE _password VARCHAR(100);
    DECLARE _targa VARCHAR(7);
    
    SET _targa = (SELECT Targa
					FROM Pool
                    WHERE CodPool = NEW.CodPool);
    
	SET _password = (SELECT U.Password_
						FROM Utente U 
							INNER JOIN Auto A ON A.id = U.id
								INNER JOIN Pool P ON P.Targa = A.Targa
						WHERE P.CodPool = NEW.CodPool);
	
    INSERT TrackingPool
    SET Targa = _targa , CodStrada = NEW.CodStrada,CodPool = NEW.CodPool, Password_ = _password, kmStrada = NEW.numChilometro, Timestamp_ = current_timestamp();
		
END $$

CREATE EVENT aggiornamento_pool
ON SCHEDULE EVERY 5 MINUTE
DO BEGIN
	DECLARE orariopartenza DATETIME;
    DECLARE orarioarrivo DATETIME;
    
	SELECT GiornoPartenza,GiornoArrivo INTO orariopartenza, orarioarrivo
    FROM Pool
    WHERE GiornoPartenza > current_timestamp() AND GiornoArrivo < current_timestamp();
		
	UPDATE TrackingPool
	SET  kmstrada = kmstrada + 5, Timestamp_ = current_timestamp()
	WHERE  current_timestamp() > orariopartenza AND orarioarrivo < current_timestamp();

END $$

CREATE TRIGGER controlla_se_strada_finita_pool
BEFORE UPDATE ON TrackingPool FOR EACH ROW
BEGIN
	DECLARE kmfine INT DEFAULT 0;
    DECLARE nuovaStrada INT DEFAULT 0;
    
    SET kmfine = (SELECT kmFineStrada
					FROM StradeTragittoPool
                    WHERE CodPool = NEW.codPool
						AND CodStrada = NEW.codStrada);
	
    SET nuovaStrada = (SELECT CodStrada
						FROM StradeTragittoPool
                        WHERE CodPool = NEW.CodPool
							AND CodStrada = NEW.CodStrada + 1);
                            
	IF( (NEW.kmStrada > kmfine) AND (nuovaStrada <> NULL) ) THEN
		SET NEW.CodStrada = NEW.CodStrada + 1;
	END IF;
END $$


CREATE TRIGGER controlla_chiamata_ride_sharing
BEFORE INSERT ON ChiamataRideSharing FOR EACH ROW
BEGIN
	DECLARE kmfine INT DEFAULT 0;
    DECLARE kminizio INT DEFAULT 0;
    
    SET kmfine = (SELECT MAX(kmFineStrada)
					FROM StradeTragittoSharing 
					WHERE CodStrada = NEW.CodStradaPartenza);
                    
                    
	 SET kminizio = (SELECT MIN(kmInizioStrada)
					FROM StradeTragittoSharing 
					WHERE CodStrada = NEW.CodStradaPartenza);
	
    #TODO: con una precisione di 2 km
    
    IF ( ( NEW.kmStradaPartenza > kmFine) OR (NEW.kmStradaPartenza < kminizio) ) THEN
		INSERT ChiamataSharingMultiplo
        SET CodStradaArrivo = NEW.CodStradaArrivo, kmStradaArrivo = NEW.kmStradaArrivo, CodStradaPartenza = NEW.CodStradaPartenza, kmStradaPartenza = NEW.kmStradaPartenza, TimeStamp = current_timestamp(), IdFruitore = NEW.IdFruitore;
	

    ELSEIF( (NEW.kmStradaArrivo > kmFine) OR (NEW.kmStradaArrivo < kminizio) ) THEN
		INSERT ChiamataSharingMultiplo
        SET CodStradaArrivo = NEW.CodStradaArrivo, kmStradaArrivo = NEW.kmStradaArrivo, CodStradaPartenza = NEW.CodStradaPartenza, kmStradaPartenza = NEW.kmStradaPartenza, TimeStamp = current_timestamp(), IdFruitore = NEW.IdFruitore;

	END IF;
    
END $$

CREATE TRIGGER sharing_multiplo    
AFTER INSERT ON ChiamataSharingMultiplo FOR EACH ROW
BEGIN
   
   DECLARE strada INT DEFAULT 0;
   DECLARE strada2 INT DEFAULT 0;
   DECLARE sharing INT DEFAULT 0;
   DECLARE iniziostrada INT DEFAULT 0;
   DECLARE finestrada INT DEFAULT 0;
   DECLARE finito INT DEFAULT 0;
   
    DECLARE stradetragitto CURSOR FOR
		SELECT CodSharing,kmInizioStrada,kmFineStrada
        FROM StradeTragittoSharing;
        
	DECLARE CONTINUE HANDLER
		FOR NOT FOUND SET finito = 1;
        
        OPEN stradetragitto;
        
preleva: LOOP
			FETCH stradetragitto INTO sharing,iniziostrada,finestrada;
			IF finito = 1 THEN
				LEAVE preleva;
			END IF;
			
            SELECT LEAST(finestrada,I.kmStrada1), CodStrada2 INTO finestrada, strada2
								FROM StradeTragittoSharing STS
									INNER JOIN Incrocio I
								WHERE I.CodStrada1 = STS.CodStrada
									AND STS.kmFineStrada < I.kmStrada1;
			
           
            SET strada = NEW.CodStradaArrivo;
                            
			SET @esiste = (SELECT COUNT(CodSharingMultiplo)
							FROM SharingMultiplo
                            WHERE CodSharing1 = sharing AND CodSharing2 = sharing + 1 AND NEW.IdFruitore = Id);
              
            SET @valido = (SELECT COUNT(CodSharingMultiplo)
							FROM SharingMultiplo
                            WHERE CodSharing1 = sharing AND CodSharing2 = sharing + 1);  
              
			IF( (@esiste = 0) AND (@valido = 0) ) THEN
				INSERT SharingMultiplo
				SET Id = NEW.idFruitore, CodSharing1 = sharing, CodSharing2 = sharing + 1;
			END IF;
																	
			
        END LOOP preleva;
		CLOSE stradetragitto;
 
END $$
        
CREATE PROCEDURE CalcoloOrarioStimatoSharing(IN _codSharing INT)
BEGIN
	DECLARE esiste INT DEFAULT 0;
    DECLARE TempoStimato DOUBLE DEFAULT 0;
    DECLARE T1 DOUBLE DEFAULT 0;
    DECLARE T2 DOUBLE DEFAULT 0;
    DECLARE T3 DOUBLE DEFAULT 0;
    DECLARE T4 DOUBLE DEFAULT 0;
    DECLARE nAuto INT DEFAULT 0;
    DECLARE nCorsieInMedia INT DEFAULT 0;
    DECLARE nStrade INT DEFAULT 0;
    DECLARE Chilometri INT DEFAULT 0;
    DECLARE densita DOUBLE DEFAULT 0;
    
    
    
    SET esiste = (
					SELECT COUNT(*)
					FROM RideSharing
					WHERE CodSharing = _codSharing
				);
	
    
	IF(esiste = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire uno sharing valido';
    ELSEIF esiste = 1 THEN
			SET nAuto = (
							SELECT	COUNT(DISTINCT TN.Targa)
							FROM 	StradeTragittoSharing STS INNER JOIN TrackingNoleggio TN ON STS.CodStrada = TN.CodStrada
							WHERE	STS.kmInizioStrada <= TN.kmStrada
									AND
									STS.kmFineStrada >= TN.kmStrada
						)
                        +
                        (
							SELECT	COUNT(DISTINCT TS.Targa)
							FROM 	StradeTragittoSharing STS INNER JOIN TrackingSharing TS ON STS.CodStrada = TS.CodStrada
							WHERE	STS.kmInizioStrada <= TS.kmStrada
									AND
									STS.kmFineStrada >= TS.kmStrada
                        )
                        +
                        (
							SELECT	COUNT(DISTINCT TP.Targa)
							FROM 	StradeTragittoSharing STS INNER JOIN TrackingPool TP ON STS.CodStrada = TP.CodStrada
							WHERE	STS.kmInizioStrada <= TP.kmStrada
									AND
									STS.kmFineStrada >= TP.kmStrada
                        );
            
			SET nStrade = 	(
								SELECT	COUNT(*)
								FROM	StradeTragittoSharing
							);
                            
			SET nCorsieInMedia =	(
										SELECT	SUM(S.NumCorsie)
										FROM 	StradeTragittoSharing STS INNER JOIN Strada S ON STS.CodStrada = S.CodStrada
									) / nStrade;
			
            SET Chilometri = (	
								SELECT 	KmPercorsi 
								FROM 	TragittoSharing
                                WHERE 	CodSharing = _codsharing
							);
                                    
			SET densita = nAuto/(Chilometri*nCorsieInMedia);
            
            SELECT  MIN(((LDV.kmFine - STS.kmInizioStrada)/LDV.ValoreLimite)*60) INTO T1
			FROM	StradeTragittoSharing STS INNER JOIN LimitiDiVelocita LDV ON STS.CodStrada = LDV.CodStrada
			WHERE 	STS.CodSharing = _codSharing
					AND 
					LDV.kmInizio < STS.kmInizioStrada
					AND
					LDV.kmFine <= STS.kmFineStrada
					AND
					LDV.kmFine >= STS.kmInizioStrada;
					
 			SELECT 	MIN(((LDV.kmFine - LDV.kmInizio)/LDV.ValoreLimite)*60) INTO T2
			FROM	StradeTragittoSharing STS INNER JOIN LimitiDiVelocita LDV ON STS.CodStrada = LDV.CodStrada
			WHERE 	STS.CodSharing = _codSharing
					AND 
					LDV.kmInizio >= STS.kmInizioStrada
					AND
					LDV.kmFine <= STS.kmFineStrada;
 					
			SELECT 	MIN(((STS.kmFineStrada - LDV.kmInizio)/LDV.ValoreLimite)*60) INTO T3
			FROM	StradeTragittoSharing STS INNER JOIN LimitiDiVelocita LDV ON STS.CodStrada = LDV.CodStrada
			WHERE 	STS.CodSharing = _codSharing
					AND 
					LDV.kmInizio > STS.kmInizioStrada
					AND
					LDV.kmFine >= STS.kmFineStrada
					AND
					LDV.kmInizio <= STS.kmFineStrada;
					
			
			SELECT 	MIN(((STS.kmFineStrada - STS.kmInizioStrada)/LDV.ValoreLimite)*60) INTO T4
			FROM	StradeTragittoSharing STS INNER JOIN LimitiDiVelocita LDV ON STS.CodStrada = LDV.CodStrada
			WHERE 	STS.CodSharing = _codSharing
					AND 
					LDV.kmInizio <= STS.kmInizioStrada
					AND
					LDV.kmFine >= STS.kmFineStrada; 
 	
			SET TempoStimato = IFNULL(T1, 0) + IFNULL(T2, 0) + IFNULL(T3, 0) + IFNULL(T4, 0);
            
			
            CASE
				WHEN densita <= 35 THEN
					SET TempoStimato = TempoStimato;
				WHEN densita > 35 AND densita <= 50  THEN
					SET TempoStimato = TempoStimato + TempoStimato*0.2;
				WHEN densita > 50 AND densita <= 65  THEN
					SET TempoStimato = TempoStimato + TempoStimato*0.4;
				WHEN densita > 65 AND densita <= 80  THEN
					SET TempoStimato = TempoStimato + TempoStimato*0.6;
				WHEN densita > 80 AND densita <= 95  THEN
					SET TempoStimato = TempoStimato + TempoStimato*0.8;
				WHEN densita > 95  THEN
					SET TempoStimato = TempoStimato + TempoStimato*1;
            END CASE;
            
            SELECT TempoStimato, densita;
			UPDATE RideSharing
			SET OraStimatoArrivo = OraPartenza + INTERVAL TempoStimato MINUTE
            WHERE CodSharing = _codSharing;
            
            
    END IF;
END $$

CREATE PROCEDURE CalcoloOrarioStimatoPool(IN _codPool INT)
BEGIN
	DECLARE esiste INT DEFAULT 0;
    DECLARE TempoStimato DOUBLE DEFAULT 0;
    DECLARE T1 DOUBLE DEFAULT 0;
    DECLARE T2 DOUBLE DEFAULT 0;
    DECLARE T3 DOUBLE DEFAULT 0;
    DECLARE T4 DOUBLE DEFAULT 0;
    DECLARE nAuto INT DEFAULT 0;
    DECLARE nCorsieInMedia INT DEFAULT 0;
    DECLARE nStrade INT DEFAULT 0;
    DECLARE Chilometri INT DEFAULT 0;
    DECLARE densita DOUBLE DEFAULT 0;
    
    
    
    SET esiste = (
					SELECT COUNT(*)
					FROM Pool
					WHERE CodPool = _codPool
				);
	
    
	IF(esiste = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire uno sharing valido';
    ELSEIF esiste = 1 THEN
			SET nAuto = (
							SELECT	COUNT(DISTINCT TN.Targa)
							FROM 	StradeTragittoPool STP INNER JOIN TrackingNoleggio TN ON STP.CodStrada = TN.CodStrada
							WHERE	STP.kmInizioStrada <= TN.kmStrada
									AND
									STP.kmFineStrada >= TN.kmStrada
						)
                        +
                        (
							SELECT	COUNT(DISTINCT TS.Targa)
							FROM 	StradeTragittoPool STP INNER JOIN TrackingSharing TS ON STP.CodStrada = TS.CodStrada
							WHERE	STP.kmInizioStrada <= TS.kmStrada
									AND
									STP.kmFineStrada >= TS.kmStrada
                        )
                        +
                        (
							SELECT	COUNT(DISTINCT TP.Targa)
							FROM 	StradeTragittoPool STP INNER JOIN TrackingPool TP ON STP.CodStrada = TP.CodStrada
							WHERE	STP.kmInizioStrada <= TP.kmStrada
									AND
									STP.kmFineStrada >= TP.kmStrada
                        );
            
			SET nStrade = 	(
								SELECT	COUNT(*)
								FROM	StradeTragittoPool
							);
                            
			SET nCorsieInMedia =	(
										SELECT	SUM(S.NumCorsie)
										FROM 	StradeTragittoPool STP INNER JOIN Strada S ON STP.CodStrada = S.CodStrada
									) / nStrade;
			
            SET Chilometri = (	
								SELECT 	KmPercorsi 
								FROM 	TragittoPool
                                WHERE 	CodPool = _codPool
							);
                                    
			SET densita = nAuto/(Chilometri*nCorsieInMedia);
            
            SELECT  SUM(((LDV.kmFine - STP.kmInizioStrada)/LDV.ValoreLimite)*60) INTO T1
			FROM	StradeTragittoPool STP INNER JOIN LimitiDiVelocita LDV ON STP.CodStrada = LDV.CodStrada
			WHERE 	STP.CodPool = _codPool
					AND 
					LDV.kmInizio < STP.kmInizioStrada
					AND
					LDV.kmFine <= STP.kmFineStrada
					AND
					LDV.kmFine >= STP.kmInizioStrada;
					
 			SELECT 	SUM(((LDV.kmFine - LDV.kmInizio)/LDV.ValoreLimite)*60) INTO T2
			FROM	StradeTragittoPool STP INNER JOIN LimitiDiVelocita LDV ON STP.CodStrada = LDV.CodStrada
			WHERE 	STP.CodPool = _codPool
					AND 
					LDV.kmInizio >= STP.kmInizioStrada
					AND
					LDV.kmFine <= STP.kmFineStrada;
 					
			SELECT 	SUM(((STP.kmFineStrada - LDV.kmInizio)/LDV.ValoreLimite)*60) INTO T3
			FROM	StradeTragittoPool STP INNER JOIN LimitiDiVelocita LDV ON STP.CodStrada = LDV.CodStrada
			WHERE 	STP.CodPool = _codPool
					AND 
					LDV.kmInizio > STP.kmInizioStrada
					AND
					LDV.kmFine >= STP.kmFineStrada
					AND
					LDV.kmInizio <= STP.kmFineStrada;
					
			
			SELECT 	SUM(((STP.kmFineStrada - STP.kmInizioStrada)/LDV.ValoreLimite)*60) INTO T4
			FROM	StradeTragittoPool STP INNER JOIN LimitiDiVelocita LDV ON STP.CodStrada = LDV.CodStrada
			WHERE 	STP.CodPool = _codPool
					AND 
					LDV.kmInizio <= STP.kmInizioStrada
					AND
					LDV.kmFine >= STP.kmFineStrada; 
 	
			SET TempoStimato = IFNULL(T1, 0) + IFNULL(T2, 0) + IFNULL(T3, 0) + IFNULL(T4, 0);
            
			
            CASE
				WHEN densita <= 35 THEN
					SET TempoStimato = TempoStimato;
				WHEN densita > 35 AND densita <= 50  THEN
					SET TempoStimato = TempoStimato + TempoStimato*0.2;
				WHEN densita > 50 AND densita <= 65  THEN
					SET TempoStimato = TempoStimato + TempoStimato*0.4;
				WHEN densita > 65 AND densita <= 80  THEN
					SET TempoStimato = TempoStimato + TempoStimato*0.6;
				WHEN densita > 80 AND densita <= 95  THEN
					SET TempoStimato = TempoStimato + TempoStimato*0.8;
				WHEN densita > 95  THEN
					SET TempoStimato = TempoStimato + TempoStimato*1;
            END CASE;
            
            SELECT TempoStimato, densita;
			UPDATE Pool
			SET GiornoArrivo = GiornoPartenza + INTERVAL TempoStimato MINUTE
            WHERE CodPool = _codPool;
            
            
    END IF;
END $$
 
 -- Ranking
 
CREATE PROCEDURE Classifica()
BEGIN
	SELECT @row_number := @row_number + 1 AS Posizione, U.*
	FROM (SELECT @row_number := 0) AS N, Utente U
    ORDER BY MediaVoto DESC;
END $$

CREATE EVENT bonus
ON SCHEDULE EVERY 1 YEAR 
DO BEGIN
	DECLARE sinistrinoleggi INT DEFAULT 0;
    DECLARE sinistrisharing INT DEFAULT 0;
    DECLARE sinistripool INT DEFAULT 0;
    DECLARE finito INT DEFAULT 0;
    DECLARE utente INT DEFAULT 0;
        
	DECLARE utenti CURSOR FOR
		SELECT Id
        FROM Utenti;
        
	 DECLARE CONTINUE HANDLER
		FOR NOT FOUND SET finito = 1;
	
    OPEN utenti;
preleva: LOOP
	FETCH utenti INTO utente;
    
    IF finito = 1 THEN
		LEAVE preleva;
	END IF;
    
    SET sinistrinoleggi = (SELECT COUNT(*)
							FROM SinistroNoleggio
                            WHERE IdGuidatore = utente);
                            
	SET @targa = (SELECT targa
				FROM Auto
                WHERE Id = utente);
                
	SET sinistrisharing = (SELECT COUNT(*)
							FROM SinistroSharing
                            WHERE TargaVeicoloProponente = @targa);
                            
	SET sinistripool = (SELECT COUNT(*)
							FROM SinistroPool
                            WHERE TargaVeicoloProponente = @targa);
                            
                            
	IF( (sinistrisharing + sinistipool + sinistrinoleggi) = 0 ) THEN
		UPDATE Utente
        SET mediavoto = mediavoto + 0.1
        WHERE Id = utente
			AND Stato = 'ATTIVO'
				AND mediaVoto < 4.9;
	END IF;
    
    END LOOP preleva;
    CLOSE utenti;
    
END $$

CREATE TRIGGER chiudi_chiamata_sharing
AFTER INSERT ON AdesioniRideSharing FOR EACH ROW
BEGIN
	UPDATE ChiamataRideSharing
    SET Stato = 'CHIUSA'
    WHERE IdFruitore = NEW.IdUtente;
END $$

CREATE EVENT chiudi_chiamate_vecchie
ON SCHEDULE EVERY 1 day
DO BEGIN
	UPDATE ChiamataRideSharing
    SET Stato = 'RIFIUTATA'
    WHERE TimeStamp <= current_timestamp() - INTERVAL 48 HOUR;
END $$

CREATE PROCEDURE RichiediVariazione(IN _idrichiedente INT,IN _strada INT, IN _km INT,IN _codPool INT)
BEGIN
	DECLARE _flessibilita ENUM ('BASSO','MEDIO','ALTO');
    DECLARE _variazioniprecedenti INT DEFAULT 0;
    DECLARE _kmrichiesta INT DEFAULT 0;
    DECLARE _kmpartenza INT  DEFAULT 0;
    DECLARE _stradapartenza INT DEFAULT 0;
	DECLARE _kmarrivo INT  DEFAULT 0;
    DECLARE _stradaarrivo INT DEFAULT 0;
    
	INSERT Variazione
    SET IdRichiedente = _idrichiedente, CodStrada = _strada, kmAggiunta = _km, CodPool = _codPool;
    
    SET _flessibilita = (SELECT GradoFlessibilita
							FROM Pool
							WHERE CodPool = _codPool);
                            
	SET _variazioniprecedenti = (SELECT COUNT(*)
									FROM Variazione
									WHERE IdRichiedente = _idrichiedente
										AND CodPool = _codPool
											AND Stato = 'ACCETTATO');
                                            
	SELECT numChilometro, CodStrada INTO _kmpartenza, _stradapartenza
	FROM PosizionePartenzaPool
	WHERE CodPool = _codPool;
    
    SELECT numChilometro, CodStrada INTO _kmarrivo, _stradaarrivo
	FROM PosizioneArrivoPool
	WHERE CodPool = _codPool;
    
    #se il richiedente ha già effettuato troppo richieste di variazioni, rifiuta la richiesta attuale
	CASE
		WHEN ( (_variazioniprecedenti >= 1) AND (_flessibilita = 'BASSO') ) THEN
			UPDATE Variazione
            SET Stato = 'RIFIUTATA'
            WHERE IdRichiedente = _idrichiedente
				AND CodPool = _codPool;
                
		WHEN ( (_variazioniprecedenti >= 2) AND (_flessibilita = 'MEDIO') ) THEN
			UPDATE Variazione
            SET Stato = 'RIFIUTATA'
            WHERE IdRichiedente = _idrichiedente
				AND CodPool = _codPool;
                
		WHEN ( ( _variazioniprecedenti >= 3) AND (_flessibilita = 'ALTO') ) THEN
			UPDATE Variazione
            SET Stato = 'RIFIUTATA'
            WHERE IdRichiedente = _idrichiedente
				AND CodPool = _codPool;
		ELSE
			UPDATE Variazione
            SET Stato = 'in attesa'
            WHERE IdRichiedente = _idrichiedente
				AND CodPool = _codPool;
	END CASE;
    
    #controllo che la variazione non passi troppo lontano dal tragitto che percorre il pool
    
    -- caso in cui chiedo la variazione nella strada di partenza
	IF (_strada = _stradapartenza) THEN
		SET _kmrichiesta = ABS(_km - _kmpartenza)*2;       #perchè dopo devo tornare indietro
    
    -- caso in cui chiedo la variazionne nella strada di arrivo 
    ELSEIF (_strada = _stradaarrivo) THEN
		SET _kmrichiesta = ABS(_km - _kmarrivo)*2; 
        
	END IF;
    
    #TODO: se passa su un altra strada del tragitto del pool?
    
    -- devo vedere se è raggiungibille
    
	IF ( (_strada <> _stradapartenza) AND (_strada <> _stradaarrivo) ) THEN
    
	SET _kmrichiesta = (SELECT ABS(_km - I.kmStrada2)
							FROM Incrocio I
								INNER JOIN StradeTragittoPool STP ON STP.CodStrada = I.CodStrada1
							WHERE I.CodStrada2 = _strada);
                                
    END IF;
    
    CASE
		WHEN ( (_flessibilita = 'BASSO') AND (_kmrichiesta <= 2) AND ((_stradapartenza = _strada) OR (_stradaarrivo = _strada)) ) THEN
			
			UPDATE StradeTragittoPool
            SET kmInizioStrada = _kmrichiesta
            WHERE CodPool = _codPool
            	AND CodStrada = _strada;
            
            UPDATE Variazione
            SET Stato = 'ACCETTATA'
            WHERE IdRichiedente = _idrichiedente
				AND CodPool = _codPool;
                
		WHEN ( (_flessibilita = 'MEDIA') AND (_kmrichiesta <= 4) AND ((_stradapartenza = _strada) OR (_stradaarrivo = _strada))) THEN
        
			UPDATE StradeTragittoPool
            SET kmInizioStrada = _kmrichiesta
            WHERE CodPool = _codPool
            	AND CodStrada = _strada;
            
            UPDATE Variazione
            SET Stato = 'ACCETTATA'
            WHERE IdRichiedente = _idrichiedente
				AND CodPool = _codPool;
                
		WHEN ( (_flessibilita = 'ALTO') AND (_kmrichiesta <= 6)AND ((_stradapartenza = _strada) OR (_stradaarrivo = _strada))) THEN
			IF(_stradapartenza = _strada) THEN
			UPDATE StradeTragittoPool
            SET kmInizioStrada = _km
            WHERE CodPool = _codPool
				AND CodStrada = _strada;
            
            UPDATE Variazione
            SET Stato = 'ACCETTATA'
            WHERE IdRichiedente = _idrichiedente
				AND CodPool = _codPool;
            
            ELSEIF(_stradaarrivo = _strada) THEN
			UPDATE StradeTragittoPool
            SET kmFineStrada = _km
            WHERE CodPool = _codPool
				AND CodStrada = _strada;
            
            UPDATE Variazione
            SET Stato = 'ACCETTATA'
            WHERE IdRichiedente = _idrichiedente
				AND CodPool = _codPool;
			END IF;
                
		WHEN ( (_strada <> _stradapartenza) AND (_strada <> _stradaarrivo) AND (_flessibilita = 'BASSO') AND (_kmrichiesta <= 2) ) THEN
			
            INSERT StradeTragittoPool
            SET CodStrada = _strada, CodPool = _codPool, kmInizioStrada = _km, kmFineStrada = _km + @raggiungibile;
            
            UPDATE Variazione
            SET Stato = 'ACCETTATA'
            WHERE IdRichiedente = _idrichiedente
				AND CodPool = _codPool;
                
		WHEN ( (_strada <> _stradapartenza) AND (_strada <> _stradaarrivo) AND (_flessibilita = 'MEDIO') AND (_kmrichiesta <= 4) ) THEN
			
            INSERT StradeTragittoPool
            SET CodStrada = _strada, CodPool = _codPool, kmInizioStrada = _km, kmFineStrada = _km + @raggiungibile;
            
            UPDATE Variazione
            SET Stato = 'ACCETTATA'
            WHERE IdRichiedente = _idrichiedente
				AND CodPool = _codPool;
		
        WHEN ( (_strada <> _stradapartenza) AND (_strada <> _stradaarrivo) AND (_flessibilita = 'ALTO') AND (_kmrichiesta <= 6) ) THEN
			
            INSERT StradeTragittoPool
            SET CodStrada = _strada, CodPool = _codPool, kmInizioStrada = _km, kmFineStrada = _km + @raggiungibile;
            
            UPDATE Variazione
            SET Stato = 'ACCETTATA'
            WHERE IdRichiedente = _idrichiedente
				AND CodPool = _codPool;
                
		ELSE
			BEGIN
				UPDATE Variazione
				SET Stato = 'RIFIUTATA'
				WHERE IdRichiedente = _idrichiedente
					AND CodPool = _codPool;
            END;
            
		END CASE;
            
	SELECT _kmrichiesta, @raggiungibile;
    
END $$
 
 /*OPERAZIONI*/ -- ------------------------------------------------------------------------------------


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
		INSERT INTO Utente(Password_, Ruolo, Indirizzo, Cognome, Nome, CodFiscale, MediaVoto,DataIscrizione) VALUES (SHA1(_password), 'fruitore', _indirizzo, _cognome, _nome, _codfiscale, 0,current_timestamp());
         
		SELECT	Id INTO idutente
        FROM 	Utente U
        WHERE	U.CodFiscale = _codfiscale;
         
		INSERT INTO Documento(NumDocumento, Id, Tipologia, Scadenza, EnteRilascio) VALUES (_numdocumento, idutente, _tipologia, _scadenza, _enterilascio);
    END IF;
 END $$


-- OPERAZIONE 2: ELIMINAZIONE DI UN UTENTE
CREATE PROCEDURE EliminazioneUtente(IN _id INT, IN _password VARCHAR(128))
BEGIN
	
    DECLARE esiste INT DEFAULT 0;
    DECLARE idutente INT DEFAULT 0;
    DECLARE controllo VARCHAR(128);
    
    -- Verifico se l'utente esiste
    SET esiste =	(
	    			SELECT COUNT(*)
				FROM 	Utente U
				WHERE	U.Id = _id
			);
    
    SET controllo = (SELECT Password_
						FROM Utente
                        WHERE Id = _id);
    
    IF esiste = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Utente non esistente';
	ELSEIF ( (esiste = 1) AND (controllo = SHA1(_password)) ) THEN
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
	
    -- Dichiarazione delle variabili
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
			WHEN (mediavoto <= 0.9) THEN
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
			WHEN (Affidabilita <= 40) THEN 
				UPDATE Utente U
				SET U.Affidabilita = 'BASSA'
                WHERE U.id = _id;
			WHEN (Affidabilita BETWEEN 40 AND 70) THEN 
				UPDATE Utente U
				SET U.Affidabilita = 'MEDIA'
                WHERE U.id = _id;
			WHEN (Affidabilita >= 70) THEN 
				UPDATE Utente U
				SET U.Affidabilita = 'ALTA'
                WHERE U.id = _id;
			END CASE;
   SELECT Affidabilita;
   
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
						 FROM AdesioniRideSharing
                         WHERE CodSharing = _codSharing);
	
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
 

/*INSERT*/-- ------------------------------------------------------------------------------------------

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
INSERT INTO `progetto`.`incrocio` (`CodStrada1`, `CodStrada2`, `kmStrada1`, `kmStrada2`) VALUES ('1', '2', '20', '20');
INSERT INTO `progetto`.`incrocio` (`CodStrada1`, `CodStrada2`, `kmStrada1`, `kmStrada2`) VALUES ('1', '2', '55', '55');

-- PER POOL 
INSERT INTO Strada(Tipologia, ClassificazioneTecnica, Lunghezza) VALUES ('statale', 'Urbana', '4');
INSERT INTO `progetto`.`incrocio` (`CodStrada1`, `CodStrada2`, `kmStrada1`, `kmStrada2`) VALUES ('1', '2', '6', '3');
INSERT INTO `progetto`.`incrocio` (`CodStrada1`, `CodStrada2`, `kmStrada1`, `kmStrada2`) VALUES ('1', '3', '4', '4');
INSERT INTO `progetto`.`limitidivelocita` (`ValoreLimite`, `kmFine`, `kmInizio`, `CodStrada`) VALUES ('50', '4', '0', '3');

INSERT INTO Strada(Tipologia, ClassificazioneTecnica, Lunghezza) VALUES ('statale', 'Urbana', '10');
INSERT INTO `progetto`.`incrocio` (`CodStrada1`, `CodStrada2`, `kmStrada1`, `kmStrada2`) VALUES ('1', '4', '5', '3');
INSERT INTO `progetto`.`limitidivelocita` (`ValoreLimite`, `kmFine`, `kmInizio`, `CodStrada`) VALUES ('50', '10', '0', '4');

-- CORSIE DI IMMISSIONE
INSERT INTO CorsieDiImmissione(CodStrada1, CodStrada2, kmStrada1, kmStrada2) VALUES ('1', '2', '10', '20');
-- LIMITI DI VELOCITA'
INSERT INTO `progetto`.`limitidivelocita` (`ValoreLimite`, `kmFine`, `kmInizio`, `CodStrada`) VALUES ('50', '20', '0', '1');

INSERT INTO `progetto`.`limitidivelocita` ( `ValoreLimite`, `kmFine`, `kmInizio`, `CodStrada`) VALUES ( '70', '50', '21', '1');

INSERT INTO `progetto`.`limitidivelocita` (`ValoreLimite`, `kmFine`,`kmInizio`, `CodStrada`) VALUES ('30', '40','0', '2');

INSERT INTO `progetto`.`limitidivelocita` (`ValoreLimite`, `kmFine`, `kmInizio`, `CodStrada`) VALUES ('50', '100', '41', '2');

INSERT INTO `progetto`.`limitidivelocita` (`ValoreLimite`, `kmFine`, `kmInizio`, `CodStrada`) VALUES ('50', '100', '51','1');


-- SHARING MULTIPLO
-- INSERT INTO ChiamataSharingMultiplo VALUES ('1', '2017-02-02 12:33:33' , 'Roma', '1');
-- ancora non fatto sharing  INSERT INTO SharingMultiplo(Id, codSharing1, codSharing2) 


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
INSERT INTO `progetto`.`pool` (`GiornoPartenza`, `GiornoArrivo`, `IdProponente`, `Targa`, `GradoFlessibilita`) VALUES ('2018-12-11 14:00:00', '2018-12-11 15:00:00', '3', 'AW123OB', 'ALTO');
INSERT INTO `progetto`.`stradetragittopool` (`CodStrada`, `CodPool`, `kmInizioStrada`, `kmFineStrada`) VALUES ('1', '1', '2', '6');
INSERT INTO `progetto`.`stradetragittopool` (`CodStrada`, `CodPool`, `kmInizioStrada`, `kmFineStrada`) VALUES ('2', '1', '3', '10');

INSERT INTO `progetto`.`posizionepartenzapool` (`CodPool`, `CodStrada`, `numChilometro`) VALUES ('1', '1', '2');
INSERT INTO `progetto`.`posizionearrivopool` (`CodPool`, `CodStrada`, `numChilometro`) VALUES ('1', '2', '10');

INSERT INTO `progetto`.`adesionipool` (`CodPool`, `IdFruitore`) VALUES ('1','2');
INSERT INTO `progetto`.`adesionipool` (`CodPool` ,`IdFruitore`) VALUES ('1','4');
INSERT INTO `progetto`.`adesionipool` (`CodPool`, `IdFruitore`) VALUES ('1', '3');
CALL CalcoloOrarioStimatoPool(1);

-- SINISTRO POOL
INSERT INTO `progetto`.`sinistropool` (`TargaVeicoloProponente`, `Orario`, `KmStrada`, `CodStrada`, `Dinamica`, `PercentualeDiResponsabilita`) VALUES ('AW123OB', '2018-11-12 15:00:00', '3', '1', 'Addosso a un palo', '80');
INSERT INTO `progetto`.`generalitasinistropool` (`NumDocumento`, `CodFiscale`, `Cognome`, `Nome`, `Indirizzo`, `NumTelefono`) VALUES ('AC54321', 'ANRR6EWRERE9203', 'Tonioni', 'Francesca', 'Via Roma 11', '344405678');

-- RIDE SHARING
INSERT INTO `progetto`.`ridesharing` (`IdProponente`, `IdFruitore`, `OraPartenza`, `Targa`) VALUES ('1', '2', '2018-12-18 13:00:00', 'AE987CB');
INSERT INTO `progetto`.`adesioniridesharing` (`CodSharing`, `IdUtente`) VALUES ('1', '4');
INSERT INTO `progetto`.`adesioniridesharing` (`CodSharing`, `IdUtente`) VALUES ('1', '5');
INSERT INTO `progetto`.`adesioniridesharing` (`CodSharing`, `IdUtente`) VALUES ('1', '6');
INSERT INTO `progetto`.`stradetragittosharing` (`CodStrada`, `CodSharing`, `kmInizioStrada`, `kmFineStrada`) VALUES ('1', '1', '0', '40');
INSERT INTO `progetto`.`stradetragittosharing` (`CodStrada`, `CodSharing`, `kmInizioStrada`, `kmFineStrada`) VALUES ('2', '1', '0', '40');


INSERT INTO `progetto`.`valutazionefruitoreridesharing` (`IdProponente`, `IdFruitore`, `Recensione`) VALUES ('1', '2', 'Bene');
INSERT INTO `progetto`.`valutazionefruitoreridesharing` (`IdProponente`, `IdFruitore`, `Recensione`) VALUES ('1', '4', 'Bravo');
INSERT INTO `progetto`.`valutazionefruitoreridesharing` (`IdProponente`, `IdFruitore`, `Recensione`) VALUES ('1', '5', 'Malissimo');
INSERT INTO `progetto`.`valutazionefruitoreridesharing` (`IdProponente`, `IdFruitore`, `Recensione`) VALUES ('1', '6', 'Non ci siamo');
INSERT INTO `progetto`.`stellefruitoreridesharing` (`CodVoto`,`Id`, `Persona`, `PiacereViaggio`, `Serieta`, `Comportamento`) VALUES ('1','2', '3', '3', '3', '3');
INSERT INTO `progetto`.`stellefruitoreridesharing` (`CodVoto`,`Id`, `Persona`, `PiacereViaggio`, `Serieta`, `Comportamento`) VALUES ('2','4', '2', '5', '1', '3');
INSERT INTO `progetto`.`stellefruitoreridesharing` (`CodVoto`,`Id`, `Persona`, `PiacereViaggio`, `Serieta`, `Comportamento`) VALUES ('3','5', '1', '1', '2', '2');
INSERT INTO `progetto`.`stellefruitoreridesharing` (`CodVoto`,`Id`, `Persona`, `PiacereViaggio`, `Serieta`, `Comportamento`) VALUES ('4','6', '4', '4', '5', '3');



INSERT INTO `progetto`.`valutazioneproponenteridesharing` (`IdProponente`, `IdFruitore`, `Recensione`) VALUES ('1', '2', 'Bravissima persona');
INSERT INTO `progetto`.`valutazioneproponenteridesharing` (`IdProponente`, `IdFruitore`, `Recensione`) VALUES ('1', '4', 'Soddisfacente');
INSERT INTO `progetto`.`valutazioneproponenteridesharing` (`IdProponente`, `IdFruitore`, `Recensione`) VALUES ('1', '5', 'Un cafone');
INSERT INTO `progetto`.`valutazioneproponenteridesharing` (`IdProponente`, `IdFruitore`, `Recensione`) VALUES ('1', '6', 'Piacevole viaggio');
INSERT INTO `progetto`.`stelleproponenteridesharing` (`CodVoto`,`Id`, `Persona`, `PiacereViaggio`, `Serieta`, `Comportamento`) VALUES ('1','1', '4', '4', '4', '4');
INSERT INTO `progetto`.`stelleproponenteridesharing` (`CodVoto`,`Id`, `Persona`, `PiacereViaggio`, `Serieta`, `Comportamento`) VALUES ('2','1', '2', '3', '4', '2');
INSERT INTO `progetto`.`stelleproponenteridesharing` (`CodVoto`,`Id`, `Persona`, `PiacereViaggio`, `Serieta`, `Comportamento`) VALUES ('3','1', '1', '4', '3', '5');
INSERT INTO `progetto`.`stelleproponenteridesharing` (`CodVoto`,`Id`, `Persona`, `PiacereViaggio`, `Serieta`, `Comportamento`) VALUES ('4','1', '1', '4', '3', '5');


-- RIDE SHARING
INSERT INTO TragittoSharing VALUES ('1','1','80');

-- POSIZIONE SHARING
INSERT INTO PosizionePartenzaSharing VALUES ('1','1', '0');
INSERT INTO PosizioneArrivoSharing VALUES ('1','2', '40');

CALL CalcoloOrarioStimatoSharing(1);


INSERT INTO `progetto`.`ridesharing` (`IdProponente`, `IdFruitore`, `OraPartenza`, `Targa`) VALUES ( '3', '4', '2018-12-18 13:00:00', 'AW123OB');
INSERT INTO `progetto`.`adesioniridesharing` (`CodSharing`, `IdUtente`) VALUES ('2', '1');
INSERT INTO `progetto`.`adesioniridesharing` (`CodSharing`, `IdUtente`) VALUES ('2', '5');
INSERT INTO `progetto`.`adesioniridesharing` (`CodSharing`, `IdUtente`) VALUES ('2', '6');
INSERT INTO `progetto`.`stradetragittosharing` (`CodStrada`, `CodSharing`, `kmInizioStrada`, `kmFineStrada`) VALUES ('2', '2', '10', '60');


INSERT INTO TragittoSharing  VALUES ('2','2','50');

INSERT INTO PosizionePartenzaSharing VALUES ('2','2', '10');
INSERT INTO PosizioneArrivoSharing VALUES ('2','2', '60');


CALL CalcoloOrarioStimatoSharing(2);

INSERT INTO `progetto`.`ridesharing` (`IdProponente`, `IdFruitore`, `OraPartenza`, `Targa`) VALUES ('1', '3', '2018-12-18 13:00:00', 'AE987CB');
INSERT INTO `progetto`.`adesioniridesharing` (`CodSharing`, `IdUtente`) VALUES ('3', '4');
INSERT INTO `progetto`.`adesioniridesharing` (`CodSharing`, `IdUtente`) VALUES ('3', '5');
INSERT INTO `progetto`.`adesioniridesharing` (`CodSharing`, `IdUtente`) VALUES ('3', '6');
INSERT INTO `progetto`.`stradetragittosharing` (`CodStrada`, `CodSharing`, `kmInizioStrada`, `kmFineStrada`) VALUES ('2', '3', '50', '80');

INSERT INTO TragittoSharing  VALUES ('3','3','30');

INSERT INTO PosizionePartenzaSharing VALUES ('3','2', '50');
INSERT INTO PosizioneArrivoSharing VALUES ('3','2', '80');

CALL CalcoloOrarioStimatoSharing(3);

INSERT INTO `progetto`.`chiamataridesharing` (`CodStradaArrivo`, `kmStradaArrivo`, `CodStradaPartenza`, `kmStradaPartenza`, `IdFruitore`, `TimeStamp`) VALUES ('2', '80', '1', '10', '4',current_timestamp());


CALL AffidabilitaUtente(1);
CALL AffidabilitaUtente(2);
CALL AffidabilitaUtente(3);
CALL AffidabilitaUtente(4);
CALL AffidabilitaUtente(5);
CALL AffidabilitaUtente(6);
CALL AffidabilitaUtente(7);

CALL ValutazioneUtente(1);
CALL ValutazioneUtente(2);
CALL ValutazioneUtente(3);
CALL ValutazioneUtente(4);
CALL ValutazioneUtente(5);
CALL ValutazioneUtente(6);

CALL CostoPool(1);
CALL NumeroServiziErogati(1);
CALL NumeroPostiRimanentiSharing(1);
CALL CaratteristicheAuto('AE987CB');
CALL EliminazioneUtente(7,'root');


CALL Classifica();

CALL RichiediVariazione(1,3,2,1);
CALL RichiediVariazione(2,4,10,1);
CALL RichiediVariazione(3,4,0,1);
CALL RichiediVariazione(1,2,12,1);
CALL RichiediVariazione(4,1,40,1);
