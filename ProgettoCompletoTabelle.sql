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
    ServizioRideSharing BOOL DEFAULT NULL,
    ServizioCarSharing BOOL DEFAULT NULL,
    ServizioPooling  BOOL DEFAULT NULL,
        PRIMARY KEY (Targa),
        FOREIGN KEY (Id)
        REFERENCES Utente(Id)
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
        REFERENCES Strada(CodStrada)
); 




CREATE TABLE SinistroNoleggio
(
    CodSinistro  INT NOT NULL  AUTO_INCREMENT,
    Modello  VARCHAR(24) NOT NULL,
    CasaAutomobilistica VARCHAR(24) NOT NULL,
    TargaVeicoloProponente VARCHAR(7) NOT NULL,
    Orario TIMESTAMP NOT NULL,    -- ?
    KmStrada INT NOT NULL,
    Dinamica VARCHAR(200) NOT NULL,
    PercentualeDiResponsabilità INT NOT NULL,
        PRIMARY KEY (CodSinistro),
        FOREIGN KEY (TargaVeicoloProponente)
        REFERENCES     Auto(Targa)
);


CREATE TABLE GeneralitàSinistroNoleggio
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


CREATE TABLE DocumentoDiIdentitàSinistroNoleggio
(
    NumDocumento VARCHAR (9) NOT NULL,
    Tipologia VARCHAR(24) NOT NULL,
    Scadenza DATE NOT NULL,
    Ente VARCHAR(24) NOT NULL,
        PRIMARY KEY (NumDocumento),
        FOREIGN KEY (NumDocumento)
        REFERENCES Documento(NumDocumento)
);


CREATE TABLE Pool 
(
    CodPool INT NOT NULL AUTO_INCREMENT,
    GiornoPartenza TIMESTAMP NOT NULL,
    OraPartenza TIMESTAMP NOT NULL,
    Stato BOOLEAN, 
    GiornoArrivo TIMESTAMP NOT NULL,
    Id INT NOT NULL, 
    Targa VARCHAR(7) NOT NULL, 
    GradoFlessibilità ENUM ('BASSO', 'MEDIO', 'ALTO'),
    NumPosti INT NOT NULL,
        PRIMARY KEY (CodPool),
        FOREIGN KEY (Id)
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
    Dinamica VARCHAR(200) NOT NULL,
    PercentualeDiResponsabilità INT NOT NULL,
        PRIMARY KEY (CodSinistro),
        FOREIGN KEY (TargaVeicoloProponente)
        REFERENCES Auto(Targa)
);


CREATE TABLE GeneralitàSinistroPool
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



CREATE TABLE DocumentoDiIdentitàSinistroPool
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



CREATE TABLE AdesionePool
(
    CodPool INT NOT NULL,
    Id INT NOT NULL,
        PRIMARY KEY (CodPool),
        FOREIGN KEY (CodPool)
        REFERENCES Pool(CodPool)    
);




CREATE TABLE SommaCostiAttuale
(
    CodPool INT NOT NULL,
    ConsumoCarburante INT NOT NULL,
    CostoCarburante INT NOT NULL,
    CostoOperativo INT NOT NULL,
    CostoUsura INT NOT NULL,
    ConsumeUrbano INT NOT NULL,
    ConsumoExtraUrbano INT NOT NULL,
    CosnumoMisto INT NOT NULL,
        PRIMARY KEY (CodPool),
        FOREIGN KEY (CodPool)
        REFERENCES Pool(CodPool)    
);


CREATE TABLE ArchivioPoolVecchi 
(
    CodPool INT NOT NULL,    
    GradoDIFlessibilita ENUM ('BASSO', 'MEDIO', 'ALTO'),
    GiornoDiArrivo TIMESTAMP NOT NULL,
    GiornoDiPartenza TIMESTAMP NOT NULL,
    OrarioDiPartenza TIMESTAMP NOT NULL,
        PRIMARY KEY (CodPool),
        FOREIGN KEY (CodPool)
        REFERENCES Pool(CodPool)
);



CREATE TABLE SommaCostiVecchiaPool 
(
    CodPool INT NOT NULL,    
    ConsumoCarburante DOUBLE NOT NULL,
    CostoCarburante DOUBLE NOT NULL,
    CostoOperativo DOUBLE NOT NULL,
    CostoUsura DOUBLE NOT NULL,
    ConsumeUrbano DOUBLE NOT NULL,
    ConsumoExtraUrbano DOUBLE NOT NULL,
    CosnumoMisto DOUBLE NOT NULL,
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
    VelocitàMax DOUBLE NOT NULL,
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
    QuantitàCarburante DOUBLE NOT NULL,
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
    Stato BOOLEAN NOT NULL,
     TimeStamp TIMESTAMP NOT NULL,
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
    OraPartenza TIMESTAMP NOT NULL, 
    OraStimatoArrivo  TIMESTAMP NOT NULL,
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




CREATE TABLE GeneralitàSinistroSharing 
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



CREATE TABLE DocumentoDiIdentitàSinistroSharing 
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
		
CREATE TRIGGER controlla_posizione_partenza
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

CREATE TRIGGER controlla_posizione_arrivo
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

DROP TRIGGER IF EXISTS verifica_immissione $$
CREATE TRIGGER verifica_immissione
AFTER INSERT ON CorsieDiImmissione
FOR EACH ROW
BEGIN
	IF NEW.CodStrada1 = NEW.CodStrada2 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Le trade non possono essere uguali!';
	END IF;
END $$



DROP TRIGGER IF EXISTS verifica_limite_di_velocita $$
CREATE TRIGGER verifica_limite_di_velocita
AFTER INSERT ON LimitiDiVelocita
FOR EACH ROW
BEGIN
	IF NEW.kmFine = NEW.kmInizio THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Chilometri non validi!';
	END IF;
    
    IF ValoreLimite%10 <> 0 OR ValoreLimite < 10 OR ValoreLimite > 130 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Valore Limite di velocità non valido';
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
 
 DELIMITER ;

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
