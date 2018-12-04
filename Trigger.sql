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
	END IF;
    
    IF(NEW.Stato = 'RIFIUTATO') THEN
		INSERT ArchivioPrenotazioniRifiutate
		SET CodNoleggio = NEW.CodNoleggio, IdFruitore = NEW.IdFruitore, Targa = NEW.Targa, IdProponente = 		 NEW.IdProponente;
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


CREATE TRIGGER aggiungi_documento_sinistro_noleggio		#inserisce le generalità di un utente inserisce 
													    # il suo documento
AFTER INSERT ON GeneralitaSinistroNoleggio FOR EACH ROW

BEGIN
	INSERT DocumentoDiIdentitaSinistroNoleggio
    SELECT NumDocumento, Tipologia, Scadenza, EnteRilascio
    FROM Documento
	WHERE NumDocumento = NEW.NumDocumento;
    
END $$
 
 


 DELIMITER ;
