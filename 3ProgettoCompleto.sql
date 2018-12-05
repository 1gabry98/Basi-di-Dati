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




/*TRIGGER*/
DELIMITER $$
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

CREATE TRIGGER controlla_data_scadenza_documenti
BEFORE INSERT ON Documento FOR EACH ROW

BEGIN
	IF(NEW.Scadenza < current_date()) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Documento scaduto';
	END IF;
    
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

CREATE TRIGGER aggiungi_voto #aggiunge automaticamente i voti dei noleggi
AFTER INSERT ON ValutazioneFruitoreNoleggio FOR EACH ROW

BEGIN
	INSERT ValutazioneUtente
    SET CodVoto = NEW.CodVoto, Id = NEW.IdFruitore, Ruolo = 'Fruitore', Recensione = NEW.Recensione;
END $$ 

	
CREATE TRIGGER aggiungi_stelle #aggiunge automaticamente le stelle dei noleggi
AFTER INSERT ON StelleFruitoreNoleggio FOR EACH ROW
		
BEGIN
	INSERT StelleUtente
    SET CodVoto = NEW.CodVoto, Id = NEW.Id, Persona = NEW.Persona, PiacereViaggio = NEW.PiacereViaggio, 	Comportamento = NEW.Comportamento, Serieta = NEW.Serieta;
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

CREATE TRIGGER controllo_stelle__fruitore_noleggio
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
	

CREATE TRIGGER controllo_sinistro_noleggio		#TODO: inserire caratteristiche auto 
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
    
    IF((NEW.NumPosti < 0)OR (NEW.NumPosti > 9)) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Inserire un numero di posti valido';
	END IF;
		
END $$

CREATE TRIGGER archivia_pool
AFTER UPDATE ON Pool FOR EACH ROW

BEGIN
	IF(NEW.Stato = 'CHIUSO') THEN
		INSERT ArchivioPoolVecchi
        SET CodPool = NEW.CodPool, GradoFlessibilita = NEW.GradoFlessibilita, GiornoArrivo = NEW.GiornoArrivo, GiornoPartenza = NEW.GiornoPartenza, Targa = NEW.Targa, IdProponente = NEW.IdProponente;
		DELETE FROM Pool
		WHERE CodPool = NEW.CodPool;
   END IF;
    
END$$


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

CREATE TRIGGER controllo_sinistro_pool	#TODO: inserire caratteristiche auto 
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
 

CREATE TRIGGER aggiungi_somma_costi_vecchia_pool
AFTER INSERT ON ArchivioPoolVecchi FOR EACH ROW

BEGIN
	INSERT SommaCostiVecchiaPool
    SELECT * 
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
    SET ServizioCarSharing = 1
    WHERE Targa = NEW.Targa;
END $$

CREATE TRIGGER aggiorna_servizio_car_pooling
AFTER INSERT ON Pool FOR EACH ROW

BEGIN
	UPDATE Auto
    SET ServizioCarPooling = 1
    WHERE Targa = NEW.Targa;
END $$

CREATE TRIGGER aggiorna_servizio_ride_sharing
AFTER INSERT ON RideSharing FOR EACH ROW

BEGIN
	UPDATE Auto
    SET ServizioRideSharing = 1
    WHERE Targa = NEW.Targa;
END $$

CREATE TRIGGER aggiorna_stato_utente_dopo_eliminazione_auto
AFTER DELETE ON Auto FOR EACH ROW

BEGIN
	SET @autorimanenti = (SELECT COUNT*
							FROM Auto 
                            WHERE Id = NEW.Id);
	IF(@autorimanenti = 0) THEN
		UPDATE Utente
        SET Ruolo = 'Fruitore'
        WHERE Id = NEW.Id;
END;
DELIMITER ;
 
 /*OPERAZIONI*/

DELIMITER $$
 -- REGISTRAZIONE DI UN UTENTE
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
						SELECT 	COUNT(*)
						FROM 	Utente U
						WHERE	U.CodFiscale = _codfiscale
					);
    
    IF esiste = 1 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Utente già esistente';
	ELSEIF esiste = 0 THEN
		INSERT INTO Utente(Password, Ruolo, Indirizzo, Cognome, Nome, CodFiscale, MediaVoto) VALUES (_password, 'fruitore', _indirizzo, _cognome, _nome, _codfiscale, 0);
         
		SELECT	Id INTO idutente
        FROM 	Utente U
        WHERE	U.CodFiscale = _codfiscale;
         
		INSERT INTO Documento(NumDocumento, Id, Tipologia, Scadenza, EnteRilascio) VALUES (_numdocumento, idutente, _tipologia, _scadenza, _enterilascio);
    END IF;
 END $$

-- VISUALIZZAZIONE CARATTERISTICHE AUTO

DROP PROCEDURE IF EXISTS CaratteristicheAuto $$
CREATE PROCEDURE CaratteristicheAuto(IN _targa INT)
BEGIN
	
    DECLARE esiste INT DEFAULT 0;
    
    -- Verifico se l'utente già esiste
    SET esiste =(
			SELECT 	COUNT(*)
			FROM 	Auto A
			WHERE	A.Targa = _targa
		);
    
    IF esiste = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Auto non esistente';
	ELSEIF esiste = 1 THEN
		SELECT	C.*, O.Peso, O.Connettività, O.Tavolino, O.TettoInVetro, O.Bagagliaio, O.ValutazioneAuto, O.RumoreMedio, CM.Urbano AS ConsumoUrbano, CM.ExtraUrbano AS ConsumoExtraUrbano, CM.Misto AS ConsumoMisto
		FROM	(ConsumoMedio CM NATURAL JOIN Caratteristiche C) NATURAL JOIN Optional O;
	END IF;
END $$
					  
					  
					  
-- ELIMINAZIONE DI UN UTENTE
CREATE PROCEDURE EliminazioneUtente(IN _id INT)
BEGIN
	
    DECLARE esiste INT DEFAULT 0;
    DECLARE idutente INT DEFAULT 0;
    
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
		DELETE FROM Utente WHERE Id = _id;
		DELETE FROM Documento WHERE Id = _id;
		DELETE FROM Auto WHERE Id = _id;
	END IF;
END $$


-- REGISTRAZIONE NUOVA AUTO

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
                                        IN _RumoreMedio DOUBLE
									)
BEGIN
	
    DECLARE esiste INT DEFAULT 0;
    
    -- Verifico se l'utente già esiste
    SET esiste =	(
						SELECT 	COUNT(*)
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
	END IF;
END $$

DELIMITER ;
 

/*INSERT*/

-- UTENTE 
CALL RegistraUtente('root' , 'Largo Catallo 11', 'Marino', 'Gabriele','PGGLRD98E28C309F','AX964319','Carta di identità','2023-03-01','Comune');
CALL RegistraUtente('root' , 'Via Strada di Salci 46', 'Poggiani', 'Leonardo','ANDR674OE9203','AE162249','Carta di identità','2023-03-01','Comune');
CALL RegistraUtente('root' , 'Via Roma 11', 'Francesca', 'Tonioni','ANRR6EWRERE9203','AC54321','Carta di identità','2023-03-01','Comune');
CALL RegistraUtente('root' , 'Via Napoli 45', 'Andrea Angelo', 'Scebba','ANRRFWEWWW9203','AW92812','Carta di identità','2023-03-01','Comune');

-- AUTO
CALL RegistrazioneAuto('AE987CB','1','4','200','2010','Gasolio','1200','Panamera','Porsche','10000','12','0.4','10000', '1', '0', '0', '20', '12000', '24');
CALL RegistrazioneAuto('AW123OB','3','4','200','2010','Gasolio','1500','Focus','Ford','10000','12','0.4','10000', '1', '0', '0', '20', '12000', '24');

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
INSERT INTO PrenotazioneDiNoleggio (DataInizio, DataFine, idFruitore, Targa, idProponente,Prezzo) VALUES ('2019-01-01', '2019-01-01', '1', 'AS214HM', '3','100');
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



