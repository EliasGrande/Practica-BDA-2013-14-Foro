
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
	esAdmin CHAR(1) NOT NULL	
);

CREATE TABLE foro (
	id NUMBER(10) NOT NULL CONSTRAINT PK_FORO PRIMARY KEY,
	fechacreacion DATE NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	idusuario NUMBER(10) NOT NULL CONSTRAINT FK_FORO REFERENCES usuario
);

CREATE TABLE hilo (
	id NUMBER(10) NOT NULL CONSTRAINT PK_HILO PRIMARY KEY,
	fechacreacion DATE,
	titulo VARCHAR(45),
	idusuario NUMBER(10) NOT NULL CONSTRAINT FK_HILO_U REFERENCES usuario,
	idforo NUMBER(10) NOT NULL CONSTRAINT FK_HILO_F REFERENCES foro	
);

CREATE TABLE entrada (
	id NUMBER(10) NOT NULL CONSTRAINT PK_ENTRADA PRIMARY KEY,
	fechacreacion DATE NOT NULL,
	titulo VARCHAR(45) NOT NULL,
	texto VARCHAR(1000) NOT NULL,
	fechaedicion DATE,
	numedicion VARCHAR(45) NOT NULL,
	idusuario NUMBER(10) NOT NULL CONSTRAINT FK_ENTRADA_U REFERENCES usuario,
	idhilo NUMBER(10) NOT NULL CONSTRAINT FK_ENTRADA_H REFERENCES hilo
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
	'21232f297a57a5a743894a0e4a801fc3', -- md5('admin')
	'admin@example.com',
	(SELECT sysdate FROM dual),
	'S'
);

