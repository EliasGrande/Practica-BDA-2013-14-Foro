
DROP TABLE entrada;
DROP TABLE hilo;
DROP TABLE foro;
DROP TABLE usuario;

CREATE TABLE usuario (
	id NUMBER(10) NOT NULL CONSTRAINT PK_USUARIO PRIMARY KEY,
	nick VARCHAR(20) NOT NULL,
	pass VARCHAR(32) NOT NULL,
	email VARCHAR(45) NOT NULL,
	fecharegistro VARCHAR(45) NOT NULL,
	esadmin CHAR(1) DEFAULT 'N' NOT NULL CHECK (esadmin IN ('S', 'N')),
	UNIQUE (nick, email)
);

CREATE TABLE foro (
	id NUMBER(10) NOT NULL CONSTRAINT PK_FORO PRIMARY KEY,
	fechacreacion DATE NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	idusuario NUMBER(10) NOT NULL CONSTRAINT FK_FORO REFERENCES usuario ON DELETE SET NULL
);

CREATE TABLE hilo (
	id NUMBER(10) NOT NULL CONSTRAINT PK_HILO PRIMARY KEY,
	fechacreacion DATE,
	titulo VARCHAR(45),
	idusuario NUMBER(10) NOT NULL CONSTRAINT FK_HILO_U REFERENCES usuario ON DELETE SET NULL,
	idforo NUMBER(10) NOT NULL CONSTRAINT FK_HILO_F REFERENCES foro	ON DELETE CASCADE
);

CREATE TABLE entrada (
	id NUMBER(10) NOT NULL CONSTRAINT PK_ENTRADA PRIMARY KEY,
	fechacreacion DATE NOT NULL,
	titulo VARCHAR(45) NOT NULL,
	texto VARCHAR(1000) NOT NULL,
	fechaedicion DATE,
	numedicion VARCHAR(45) DEFAULT 0 NOT NULL,
	idusuario NUMBER(10) NOT NULL CONSTRAINT FK_ENTRADA_U REFERENCES usuario ON DELETE SET NULL,
	idhilo NUMBER(10) NOT NULL CONSTRAINT FK_ENTRADA_H REFERENCES hilo ON DELETE CASCADE
);

DROP SEQUENCE usuario_seq;
DROP SEQUENCE foro_seq;
DROP SEQUENCE hilo_seq;
DROP SEQUENCE entrada_seq;

CREATE SEQUENCE usuario_seq;
CREATE SEQUENCE foro_seq;
CREATE SEQUENCE hilo_seq;
CREATE SEQUENCE entrada_seq;

INSERT INTO usuario (id, nick, pass, email, fecharegistro, esAdmin)
VALUES (
	usuario_seq.NEXTVAL,
	'admin',
	'admin',
	'admin@example.com',
	(SELECT sysdate FROM dual),
	'S'
);

INSERT INTO foro (id, fechacreacion, nombre, idusuario)
VALUES (
	foro_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Foro bases de datos avanzadas', 1
);

INSERT INTO foro (id, fechacreacion, nombre, idusuario)
VALUES (
	foro_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Foro ferramentas de desarrollo', 1
);

INSERT INTO foro (id, fechacreacion, nombre, idusuario)
VALUES (
	foro_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Foro proyectos de desarrollo software', 1
);

INSERT INTO foro (id, fechacreacion, nombre, idusuario)
VALUES (
	foro_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Foro aseguramiento de la calidad', 1
);

INSERT INTO foro (id, fechacreacion, nombre, idusuario)
VALUES (
	foro_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Foro sistemas de información empresarial', 1
);

-- ------------------------

INSERT INTO hilo (id, fechacreacion, titulo, idusuario, idforo)
VALUES (
	hilo_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Hilo primer examen de practicas', 1, 1
);

INSERT INTO hilo (id, fechacreacion, titulo, idusuario, idforo)
VALUES (
	hilo_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Hilo segundo examen de practicas', 1, 1
);

INSERT INTO hilo (id, fechacreacion, titulo, idusuario, idforo)
VALUES (
	hilo_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Hilo examen final', 1, 1
);

INSERT INTO hilo (id, fechacreacion, titulo, idusuario, idforo)
VALUES (
	hilo_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Hilo primera iteracion', 1, 2
);

INSERT INTO hilo (id, fechacreacion, titulo, idusuario, idforo)
VALUES (
	hilo_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Hilo trabajo final', 1, 3
);

INSERT INTO hilo (id, fechacreacion, titulo, idusuario, idforo)
VALUES (
	hilo_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Hilo primera iteracion', 1, 2
);

INSERT INTO hilo (id, fechacreacion, titulo, idusuario, idforo)
VALUES (
	hilo_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Hilo dudas frecuentes', 1, 2
);

INSERT INTO hilo (id, fechacreacion, titulo, idusuario, idforo)
VALUES (
	hilo_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Hilo entrega inicial', 1, 4
);

INSERT INTO hilo (id, fechacreacion, titulo, idusuario, idforo)
VALUES (
	hilo_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Hilo novedades', 1, 2
);

INSERT INTO hilo (id, fechacreacion, titulo, idusuario, idforo)
VALUES (
	hilo_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Hilo trabajo tutelado', 1, 5
);

-- ------------------------

INSERT INTO entrada (id, fechacreacion, titulo, texto, idusuario, idhilo) 
VALUES (
	entrada_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Duda puntuacion practica', 'Queria saber que cuanto cuenta la practica.', 1, 1
);

INSERT INTO entrada (id, fechacreacion, titulo, texto, idusuario, idhilo) 
VALUES (
	entrada_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Duda trigger', 'Como funcionan los triggers?', 1, 1
);

INSERT INTO entrada (id, fechacreacion, titulo, texto, idusuario, idhilo) 
VALUES (
	entrada_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Examen Bases de datos avanzadas', 'Queria saber en que fecha es el examen.', 1, 1
);

INSERT INTO entrada (id, fechacreacion, titulo, texto, idusuario, idhilo) 
VALUES (
	entrada_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Entrega practica', 'Queria saber que dia se entrega la practica.', 1, 1
);

INSERT INTO entrada (id, fechacreacion, titulo, texto, idusuario, idhilo) 
VALUES (
	entrada_seq.NEXTVAL, (SELECT sysdate FROM dual), 'Duda puntuacion practica', 'La puntuacion de la practica como va a ser?.', 1, 1
);



















