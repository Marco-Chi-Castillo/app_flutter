CREATE TABLE Roles(
	id	INTEGER NOT NULL,
	rol	TEXT NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE Usuarios(
	id	INTEGER NOT NULL,
	nombre TEXT NOT NULL,
	apellido TEXT,
	email TEXT NOT NULL,
	contrasenia TEXT NOT NULL,
    roles_id	INTEGER NOT NULL,
	PRIMARY KEY(id)
	FOREIGN KEY(roles_id) REFERENCES Roles(id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

CREATE TABLE Edificios (
	id	INTEGER PRIMARY KEY,
	nombre	TEXT NOT NULL
);

 CREATE TABLE Espacios(
	id INTEGER PRIMARY KEY,
	nombre TEXT NOT NULL,
	descripcion TEXT,
	capacidad INTEGER,
    estatus INTEGER NOT NULL,
    imagen TEXT,
    idEdificio INTEGER NOT NULL,
	FOREIGN KEY(idEdificio) REFERENCES Edificios(id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

CREATE TABLE Reservas(
	id INTEGER PRIMARY KEY,
	fechaReservacion DATE NOT NULL,
	detalle TEXT,
	horaInicio TIME NOT NULL,
    horaFinal TIME NOT NULL,
    numAsistentes INTEGER NOT NULL,
    idUsuario INTEGER NOT NULL,
	idEspacio INTEGER NOT NULL,
	FOREIGN KEY(idUsuario) REFERENCES Usuarios(id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
	
	FOREIGN KEY(idEspacio) REFERENCES Espacios(id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);


CREATE TRIGGER before_reservas_insert BEFORE INSERT ON Reservas
FOR EACH ROW
BEGIN
SELECT RAISE (ABORT, 'There is already a reservation on that date and time.') 
WHERE  EXISTS (SELECT 1 FROM Reservas 
		WHERE 
		NEW.id <> Reservas.id AND NEW.fechaReservacion= Reservas.fechaReservacion
	   AND NEW.idEspacio = Reservas.idEspacio AND
       (NEW.horaInicio BETWEEN Reservas.horaInicio AND Reservas.horaFinal OR
        NEW.horaFinal BETWEEN Reservas.horaInicio AND Reservas.horaFinal OR
       (NEW.horaInicio <= Reservas.horaInicio AND NEW.horaFinal >= Reservas.horaFinal)));
END;


--Pruebas de implementación
INSERT INTO Roles 
			 VALUES (1, "Docente");



INSERT INTO Edificios 
			VALUES (1, "Edificio G");
            
INSERT INTO Usuarios 
			VALUES (1, "Abraham", "Caamal", "abraham@gmail.com", "123", 1),
				   (2, "Marco", "Chi", "marco@gmail.com", "123", 1);
                   
INSERT INTO Espacios 
			VALUES(1, "sala de juntas 1", "sala de juntas XD", "50", 1, "espacio.png", 1 );

		
	
INSERT INTO Reservas(id, fechaReservacion, idEspacio, horaInicio, horaFinal, detalle, numAsistentes,  idUsuario)
			VALUES(6, '2008-07-16', 1,  '06:00:00', '06:39:00', 'Reserva 1', 20, 1);

SELECT * from Reservas		




