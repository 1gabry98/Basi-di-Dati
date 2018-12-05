DELIMITER $$
 -- REGISTRAZIONE DI UN UTENTE
DROP PROCEDURE IF EXISTS RegistraUtente $$
CREATE PROCEDURE RegistraUtente(
									IN _password VARCHAR(24), 
                                    IN _indirizzo VARCHAR(100), 
                                    IN _cognome VARCHAR(20), 
                                    IN _nome VARCHAR(20), 
                                    IN _codficale VARCHAR(16),
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
						WHERE	U.CodFiscale = _codficale
					);
    
    IF esiste = 1 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore. Utente già esistente';
	ELSEIF esiste = 0 THEN
		INSERT INTO Utente(Password, Ruolo, Indirizzo, Cognome, Nome, CodFiscale, MediaVoto) VALUES (_password, 'fruitore', _indirizzo, _cognome, _nome, _codficale, 0);
         
		SELECT	Id INTO idutente
        FROM 	Utente U
        WHERE	U.CodFiscale = _codficale;
         
		INSERT INTO Documento(NumDocumento, Id, Tipologia, Scadenza, EnteRilascio) VALUES (_numdocumento, idutente, _tipologia, _scadenza, _enterilascio);
    END IF;
 END $$
 
 -- ELIMINAZIONE DI UN UTENTE
DROP PROCEDURE IF EXISTS EliminazioneUtente $$
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
		DELETE FROM ValutazioneUtente WHERE Id = _id;
        	DELETE FROM Documento WHERE Id = _id;
		DELETE FROM Auto WHERE Id = _id;
	END IF;
END $$


-- VISUALIZZAZIONE CARATTERISTICHE AUTO

DROP PROCEDURE IF EXISTS CaratteristicheAuto $$
CREATE PROCEDURE CaratteristicheAuto(IN _targa INT)
BEGIN
	
    DECLARE esiste INT DEFAULT 0;
    DECLARE idutente INT DEFAULT 0;
    
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
		SELECT	C.*, CM.Urbano AS ConsumoUrbano, CM.ExtraUrbano AS ConsumoExtraUrbano, CM.Misto AS ConsumoMisto
		FROM	ConsumoMedio CM NATURAL JOIN Caratteristiche C;
	END IF;
END $$



DELIMITER ;
 
DELIMITER ;
