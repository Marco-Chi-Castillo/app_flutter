use bdReservaciones;
SET GLOBAL log_bin_trust_function_creators = 1;

delimiter $$
CREATE TRIGGER before_reservaciones_insert
BEFORE INSERT
ON reservaciones FOR EACH ROW
BEGIN
    IF EXISTS ( SELECT * FROM reservaciones
				WHERE NEW.idReservaciones <> idReservaciones AND NEW.fechaReservacion= fechaReservacion
			    AND NEW.espacios_idespacios = espacios_idespacios AND
                (NEW.horaInicio BETWEEN horaInicio AND horaTermino OR
                NEW.horaTermino BETWEEN horaInicio AND horaTermino OR
                (NEW.horaInicio <= horaInicio AND NEW.horatermino > horaTermino))
    
			  )
              THEN 
              SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'There is already a reservation on that date and time';
	END IF;
END; $$
delimiter ;

              
INSERT INTO roles 
			 VALUES (1, "Docente");



INSERT INTO edificios 
			VALUES (1, "Edificio G");
            
INSERT INTO usuarios 
			VALUES (1, "Abraham", "Caamal", "abraham@gmail.com", "123", 1),
				   (2, "Marco", "Chi", "marco@gmail.com", "123", 1);
                   
INSERT INTO espacios 
			VALUES(1, "sala de juntas 1", "sala de juntas XD", "50", 1, 1 );

INSERT INTO reservaciones
            VALUES (1, '2008-07-15', 'Reservar 1', '05:00:00', '06:00:00', 20,  1, 1);
		
#Pruebas         
INSERT INTO reservaciones
            VALUES (3, '2008-07-15', 'Reservar 2', '04:00:00', '04:40:00', 10, 2, 1);
select * from reservaciones;


drop database bdreservaciones


