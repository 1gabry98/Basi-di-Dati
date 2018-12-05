DROP DATABASE IF EXISTS Progetto;
CREATE DATABASE Progetto;

USE PROGETTO;

CREATE TABLE Utente 
(
    Id INT NOT NULL AUTO_INCREMENT,
    Password VARCHAR(24) NOT NULL,
    Ruolo ENUM ('Fruitore','Proponente') DEFAULT 'Fruitore',
    Indirizzo VARCHAR (100) NOT NULL,
    Cognome VARCHAR(20) NOT NULL,
    Nome VARCHAR(20) NOT NULL,
    CodFiscale VARCHAR (16) NOT NULL,
    MediaVoto DOUBLE DEFAULT 0,
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
    PRIMARY KEY(CodVoto),
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
        PRIMARY KEY (CodVoto),
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
        PRIMARY KEY(CodStrada)
        -- FOREIGN KEY(CodStrada) 
        -- REFERENCES Strada(CodStrada)
        -- ON DELETE CASCADE
);




CREATE TABLE PosizioneArrivoSharing (
CodStrada INT NOT NULL,
numChilometro DOUBLE NOT NULL,
    PRIMARY KEY(CodStrada)
    -- FOREIGN KEY(CodStrada) REFERENCES Strada(CodStrada)
    -- ON DELETE CASCADE
);




CREATE TABLE CorsieDiImmissione 
(
    CodImmissione INT AUTO_INCREMENT NOT NULL,
    CodStrada1 INT NOT NULL,
    CodStrada2 INT NOT NULL,    
    kmStrada1 DOUBLE NOT NULL,
    kmStrada2 DOUBLE NOT NULL,
        PRIMARY KEY(CodImmissione)
        -- FOREIGN KEY (CodStrada1, CodStrada2) 
        -- REFERENCES Strada(CodStrada, CodStrada)
        -- ON DELETE CASCADE
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
    Stato ENUM ('ATTIVO', 'CHIUSO','RIFIUTATO') DEFAULT 'ATTIVO',
        PRIMARY KEY(CodNoleggio),
        FOREIGN KEY (IdProponente)
        REFERENCES Utente(Id)
        ON DELETE CASCADE
);    



CREATE TABLE ValutazioneFruitoreNoleggio 
(
    CodVoto INT NOT NULL AUTO_INCREMENT,
    IdProponente INT NOT NULL,
    IdFruitore INT NOT NULL,
    Recensione VARCHAR(200),
        PRIMARY KEY(CodVoto)
        -- FOREIGN KEY (IdProponente, IdFruitore) 
        -- REFERENCES Utente(Id)
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
);

CREATE TABLE ValutazioneProponenteNoleggio 
(
    CodVoto INT NOT NULL AUTO_INCREMENT,
    IdProponente INT NOT NULL,
    IdFruitore INT NOT NULL,
    Recensione VARCHAR(200) NOT NULL,
        PRIMARY KEY(CodVoto),
        FOREIGN KEY (IdProponente) 
        REFERENCES Utente(Id),

        FOREIGN KEY (IdFruitore) 
        REFERENCES Utente(Id)

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
);




CREATE TABLE StelleProponenteNoleggio (
    CodVoto INT NOT NULL,
    Persona DOUBLE NOT NULL,
    PiacereViaggio DOUBLE NOT NULL,
    Comportamento DOUBLE NOT NULL,
    Serieta DOUBLE NOT NULL,
    PRIMARY KEY (CodVoto),
    FOREIGN KEY (CodVoto)
        REFERENCES ValutazioneProponenteNoleggio (CodVoto)
);



CREATE TABLE ArchivioPrenotazioniRifiutate (
    CodNoleggio INT NOT NULL,
    IdFruitore INT NOT NULL,
    IdProponente INT NOT NULL,
    Targa VARCHAR(7) NOT NULL,
    PRIMARY KEY (CodNoleggio),
    FOREIGN KEY (IdFruitore)
        REFERENCES Utente (Id),
	FOREIGN KEY (IdProponente)
		REFERENCES Utente(Id)
);


CREATE TABLE ArchivioPrenotazioniVecchie (
    CodNoleggio INT NOT NULL,
    DataInizio DATE NOT NULL,
    DataFine DATE NOT NULL,
    IdFruitore INT NOT NULL,
    Targa VARCHAR(7) NOT NULL,
    IdProponente INT NOT NULL,
    PRIMARY KEY (CodNoleggio)
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
    Password VARCHAR(24) NOT NULL,
    kmStrada INT NOT NULL,
    Timestamp TIMESTAMP NOT NULL,
        PRIMARY KEY (Targa , CodStrada),
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
    Orario TIMESTAMP NOT NULL, 
    CodStrada INT NOT NULL,
    KmStrada INT NOT NULL,
    Dinamica VARCHAR(200) NOT NULL,
    PercentualeDiResponsabilita INT NOT NULL,
        PRIMARY KEY (CodSinistro)
);


CREATE TABLE GeneralitaSinistroNoleggio
(
    NumDocumento VARCHAR (9) NOT NULL,
    CodFiscale VARCHAR(16) NOT NULL,
    Cognome VARCHAR(40) NOT NULL,
    Nome VARCHAR(40) NOT NULL,
    Indirizzo VARCHAR(40) NOT NULL,
    NumTelefono INT NOT NULL,
        PRIMARY KEY (NumDocumento),
        FOREIGN KEY (NumDocumento)
        REFERENCES Documento(NumDocumento)
);


CREATE TABLE DocumentoDiIdentitaSinistroNoleggio
(
    NumDocumento VARCHAR (9) NOT NULL,
    Tipologia VARCHAR(24) NOT NULL,
    Scadenza DATE NOT NULL,
    EnteRilascio VARCHAR(24) NOT NULL,
        PRIMARY KEY (NumDocumento),
        FOREIGN KEY (NumDocumento)
        REFERENCES Documento(NumDocumento)
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
);

CREATE TABLE AdesioniPool
(
	CodPool INT NOT NULL,
    IdFruitore INT NOT NULL,
    PRIMARY KEY (CodPool, IdFruitore),
    FOREIGN KEY (CodPool) 
    REFERENCES Pool(CodPool),
    FOREIGN KEY (IdFruitore)
    REFERENCES Utente(Id)
);

CREATE TABLE TragittoPool 
(
    CodTragitto INT NOT NULL AUTO_INCREMENT,
    KmPercorsi DOUBLE NOT NULL,
            PRIMARY KEY(CodTragitto)
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
        REFERENCES Auto(Targa),
        FOREIGN KEY (CodStrada)
        REFERENCES Strada(CodStrada)
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
);



CREATE TABLE DocumentoDiIdentitaSinistroPool
(
    NumDocumento VARCHAR (9) NOT NULL,
    Tipologia VARCHAR(16) NOT NULL,
    Scadenza VARCHAR(24) NOT NULL,
	EnteRilascio VARCHAR(24) NOT NULL,
        PRIMARY KEY (NumDocumento),
        FOREIGN KEY (NumDocumento)
        REFERENCES Documento(NumDocumento)

);


CREATE TABLE SommaCostiAttualePool
(
    CodPool INT NOT NULL,
    ConsumoCarburante INT NOT NULL,
    CostoCarburante INT NOT NULL,
    CostoOperativo INT NOT NULL,
    CostoUsura INT NOT NULL,
    ConsumoUrbano INT NOT NULL,
    ConsumoExtraUrbano INT NOT NULL,
    ConsumoMisto INT NOT NULL,
        PRIMARY KEY (CodPool),
        FOREIGN KEY (CodPool)
        REFERENCES Pool(CodPool)    
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
        FOREIGN KEY (CodPool)
        REFERENCES Pool(CodPool),
        FOREIGN KEY (IdProponente)
        REFERENCES Utente(Id),
        FOREIGN KEY (Targa)
        REFERENCES Auto(Targa)
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
    CIlindrata  DOUBLE NOT NULL,
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
    Connettività BOOL DEFAULT 0,
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
    CodChiamata INT NOT NULL,
    Destinazione VARCHAR(60) NOT NULL,
    Stato ENUM('ATTIVA','CHIUSA','RIFIUTATA')DEFAULT 'ATTIVA',
	TimeStamp TIMESTAMP NOT NULL,
    IdFruitore INT NOT NULL,
        PRIMARY KEY (CodChiamata),
        FOREIGN KEY (CodChiamata)
        REFERENCES ChiamataSharingMultiplo(CodChiamata)
);



CREATE TABLE ArchivioChiamateSharingRifiutate 
(
    CodChiamata INT NOT NULL,
    Destinazione VARCHAR(60) NOT NULL,
    IdFruitore INT NOT NULL,
        TimeStamp TIMESTAMP NOT NULL,
        PRIMARY KEY(CodChiamata),
        FOREIGN KEY(IdFruitore) 
        REFERENCES Utente(Id)
);



CREATE TABLE RideSharing 
(
    CodSharing INT NOT NULL AUTO_INCREMENT,
    IdProponente INT NOT NULL, 
    IdFruitore INT NOT NULL,
    OraPartenza TIMESTAMP NOT NULL, 
    OraStimatoArrivo  TIMESTAMP NOT NULL,
    Targa INT NOT NULL,
        PRIMARY KEY(CodSharing),
        FOREIGN KEY(IdProponente) 
        REFERENCES Utente(Id)
        ON DELETE CASCADE
);


CREATE TABLE AdesioniRideSharing 
(
    CodSharing INT NOT NULL,
    IdUtente INT NOT NULL,
        PRIMARY KEY(CodSharing),
        FOREIGN KEY(CodSharing) 
        REFERENCES RideSharing(CodSharing)
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
        ON DELETE CASCADE 
);



CREATE TABLE StelleFruitoreRideSharing 
(
    CodVoto INT NOT NULL, 
    Persona DOUBLE NOT NULL,
    PiacereViaggio DOUBLE NOT NULL, 
    Serietà  DOUBLE NOT NULL, 
    Comportamento DOUBLE NOT NULL,
        PRIMARY KEY (CodVoto),
        FOREIGN KEY(CodVoto) 
        REFERENCES ValutazioneFruitoreRideSharing(CodVoto)
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
    Persona DOUBLE NOT NULL,
    PiacereViaggio DOUBLE NOT NULL, 
    Serietà  DOUBLE NOT NULL, 
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
    Password VARCHAR(24) NOT NULL,
    kmStrada INT NOT NULL,
    Timestamp_ TIMESTAMP NOT NULL,
        PRIMARY KEY (Targa , CodStrada),
        FOREIGN KEY (CodStrada)
        REFERENCES Strada(CodStrada)
);



CREATE TABLE SinistroSharing 
(
    CodSinistro  INT NOT NULL AUTO_INCREMENT,
    Modello  VARCHAR(24) NOT NULL,
    CasaAutomobilistica VARCHAR(24) NOT NULL,
    TargaVeicoloProponente VARCHAR(7) NOT NULL,
    Orario TIMESTAMP NOT NULL,
    KmStrada INT NOT NULL,
    Dinamica VARCHAR(200) NOT NULL,
    PercentualeDiResponsabilità INT NOT NULL,
        PRIMARY KEY (CodSinistro),
        FOREIGN KEY (TargaVeicoloProponente)
        REFERENCES Auto(Targa)
);




CREATE TABLE GeneralitaSinistroSharing 
(
    NumDocumento VARCHAR (9) NOT NULL,
    CodFiscale VARCHAR(16) NOT NULL,
    Congome VARCHAR(24) NOT NULL,
    Nome VARCHAR(24) NOT NULL,
    Indizirro VARCHAR(24) NOT NULL,
    NumTelefono INT NOT NULL,
        PRIMARY KEY (NumDocumento),
        FOREIGN KEY (NumDocumento)
        REFERENCES Documento(NumDocumento)
);



CREATE TABLE DocumentoDiIdentitaSinistroSharing 
(
    NumDocumento VARCHAR (9) NOT NULL,
    Tipologia VARCHAR(24) NOT NULL,
    Scadenza DATE NOT NULL,
    Ente VARCHAR(24) NOT NULL,
        PRIMARY KEY (NumDocumento),
        FOREIGN KEY (NumDocumento)
        REFERENCES Documento(NumDocumento)
);



CREATE TABLE TrackingPool 
(
    Targa VARCHAR(7) NOT NULL,
    CodStrada INT NOT NULL,
    Password VARCHAR(24) NOT NULL,
    kmStrada INT NOT NULL,
    Timestamp_ TIMESTAMP NOT NULL,
        PRIMARY KEY (Targa , CodStrada),
        FOREIGN KEY (CodStrada)
        REFERENCES Strada(CodStrada)
);


