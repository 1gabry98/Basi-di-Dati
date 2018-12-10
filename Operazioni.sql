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
    DECLARE idutente INT DEFAULT 0DELIMITER $$
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
						SELECT 	COUNT(*)
						FROM 	Utente U
						WHERE	U.CodFiscale = _codfiscale
					);
    
    IF esiste = 1 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Utente già esistente';
	ELSEIF esiste = 0 THEN
		INSERT INTO Utente(Password, Ruolo, Indirizzo, Cognome, Nome, CodFiscale, MediaVoto,DataIscrizione) VALUES (_password, 'fruitore', _indirizzo, _cognome, _nome, _codfiscale, 0,current_timestamp());
         
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



-- OPERAZIONE 3: VISUALIZZAZIONE CARATTERISTICHE AUTO
DROP PROCEDURE IF EXISTS CaratteristicheAuto $$
CREATE PROCEDURE CaratteristicheAuto(IN _targa VARCHAR(9))
BEGIN
	
    DECLARE esiste INT DEFAULT 0;
    
    -- Verifico se l'auto esiste
    SET esiste =(
			SELECT 	COUNT(*)
			FROM 	Auto A
			WHERE	A.Targa = _targa
		);
    
    IF esiste = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Auto non esistente';
	ELSEIF esiste = 1 THEN
		SELECT A.targa, C.numPosti, C.velocitaMax, C.annoImmatricolazione, C.alimentazione, C.cilindrata, C.modello, C.casaProduttrice, CM.urbano AS consumoUrbano, CM.extraUrbano AS consumoExtraUrbano, CM.Misto AS consumoMisto, O.peso, O.connettivita, O.tavolino, O.tettoInVetro, O.bagagliaio, O.valutazioneAuto, O.rumoreMedio
        FROM Auto A NATURAL JOIN Optional O NATURAL JOIN ConsumoMedio CM NATURAL JOIN Caratteristiche C
        WHERE A.Targa = _targa;
        
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
        INSERT INTO ConsumoMedio(Targa,Urbano,Extraurbano,Misto) VALUES (_targa, _ConsumoMedioUrbano, _ConsumoMedioExtraurbano,_ConsumoMedioMisto);
	END IF;
END $$



-- OPERAZIONE 5: VISUALIZZAZIONE VALUTAZIONE UTENTE
DROP PROCEDURE IF EXISTS ValutazioneUtente $$
CREATE PROCEDURE ValutazioneUtente(IN _id INT)
BEGIN
	
    DECLARE esiste INT DEFAULT 0;
    
    
    SET esiste = (
			SELECT 	COUNT(*)
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
    DECLARE consumocarbutante DOUBLE DEFAULT 0;
    DECLARE operativo DOUBLE DEFAULT 0;
    DECLARE usura DOUBLE DEFAULT 0;
    DECLARE urbano DOUBLE DEFAULT 0;
    DECLARE extraurbano DOUBLE DEFAULT 0;
    DECLARE misto DOUBLE DEFAULT 0;
    DECLARE stradapercorsa DOUBLE DEFAULT 0;
    DECLARE consumoperstrada DOUBLE DEFAULT 0;
    DECLARE tipostrada VARCHAR(30) DEFAULT ' '; 

    DECLARE finito INT DEFAULT 0;
    
    DECLARE tot DOUBLE DEFAULT 0;
    
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
						SELECT 	COUNT(*)
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
            
            SELECT 	S.ConsumoCarburante INTO consumocarbutante
            FROM	SommaCostiAttualePool S
            WHERE	S.CodPool = _codpool;
            
            SELECT 	S.CostoCarburante INTO costocarbutante
            FROM	SommaCostiAttualePool S
            WHERE	S.CodPool = _codpool;
            
            SELECT 	S.CostoOperativo INTO operativo
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
                
                SET stradapercorsa = FineStrada - InizioStrada;
                
                SELECT 	Categorizzazione INTO tipostrada
                FROM	Strada 
                WHERE	CodStrada = Codicestrada;
                
                CASE
					WHEN tipostrada = 'Urbana' THEN
						SET consumoperstrada = consumoperstrada + stradapercorsa*urbano;
					WHEN tipostrada = 'ExtraUrbana' OR tipostrada = 'Autostrada' THEN
						SET consumoperstrada = consumoperstrada + stradapercorsa*extraurbano;
					WHEN tipostrada = 'Misto' THEN
						SET consumoperstrada = consumoperstrada + stradapercorsa*misto;                        
                END CASE;
            END LOOP preleva;
            
            SET tot = consumoperstrada + costocarbutante + consumocarbutante*numKm + operativo*numKm + usura*numKm;
			
            SELECT tot AS CostoPool;
		END;
	END IF;
END $$

DELIMITER ;
    
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



DELIMITER ;
