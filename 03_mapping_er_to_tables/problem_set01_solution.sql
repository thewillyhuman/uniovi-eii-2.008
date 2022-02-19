CREATE TABLE ALUMNO
(
	DNIA varchar(8),
	NOMA varchar(20),
	APELLA varchar(20),
	DOMICILIOA varchar(20),
	F_NACIMIENTO date,
	F_INGRESO date,
	CONSTRAINT PK_ALUMNO PRIMARY KEY (DNIA)
);

CREATE TABLE CARRERA
(
	CODCARR varchar(8),
	NOMBREC varchar(20),
	DURACION decimal(1,0),   
	CONSTRAINT PK_CARRERA PRIMARY KEY (CODCARR)
);

CREATE TABLE PROFESOR
(
	DNIP varchar(8),
	NOMBREP varchar(20),
	APELLIDOP varchar(20),
	DOMICILIOP varchar(20),  
	CONSTRAINT PK_PROFESOR PRIMARY KEY (DNIP)
);

CREATE TABLE ASIGNATURA
(
	CODASIG varchar(8),
	NOMASIG varchar(20),
	CURSO decimal(1,0),
	CREDITOS decimal(2,0),
	TIPO varchar(20) NOT NULL,  
	CODCARR varchar(8) NOT NULL,
	CONSTRAINT PK_ASIGNATURA PRIMARY KEY (CODASIG),
	CONSTRAINT FK_ASIGNATURA_CARRERA FOREIGN KEY (CODCARR) REFERENCES CARRERA (CODCARR),
	CONSTRAINT UQ_ASIGNATURA_NOMASIG UNIQUE (NOMASIG),
	CONSTRAINT CK_ASIGNATURA_TIPO CHECK (TIPO IN ('obligatoria', 'optativa', 'libre configuracion'))
);

CREATE TABLE IMPARTE
(
	CODASIG varchar(8),
	DNIP varchar(8),
	CONSTRAINT PK_IMPARTE PRIMARY KEY (CODASIG,DNIP),
	CONSTRAINT FK_IMPARTE_ASIGNATURA FOREIGN KEY (CODASIG) REFERENCES ASIGNATURA (CODASIG),
	CONSTRAINT FK_IMPARTE_PROFESOR FOREIGN KEY (DNIP) REFERENCES PROFESOR (DNIP)
);

-- MODELO 1
CREATE TABLE CALIFICA_M1
(
	DNIA varchar(8),
	CODASIG varchar(8),
	DNIP varchar(8) NOT NULL,
	NOTA decimal(2,0),
	FECHA_CALIFICACION date,
	CONSTRAINT PK_CALIFICA_M1 PRIMARY KEY (DNIA,CODASIG),
	CONSTRAINT FK_CALIFICA_M1_ALUMNO FOREIGN KEY (DNIA) REFERENCES ALUMNO (DNIA),
	CONSTRAINT FK_CALIFICA_M1_ASIGNATURA FOREIGN KEY (CODASIG) REFERENCES ASIGNATURA (CODASIG),
	CONSTRAINT FK_CALIFICA_M1_PROFESOR FOREIGN KEY (DNIP) REFERENCES PROFESOR (DNIP)
);

--MODELO 2
CREATE TABLE CALIFICA_M2
(
	DNIA varchar(8),
	CODASIG varchar(8),
	DNIP varchar(8),
	NOTA decimal(2,0),
	FECHA_CALIFICACION date,
	CONSTRAINT PK_CALIFICA_M2 PRIMARY KEY (DNIA,CODASIG,DNIP),
	CONSTRAINT FK_CALIFICA_M2_ALUMNO FOREIGN KEY (DNIA) REFERENCES ALUMNO (DNIA),
	CONSTRAINT FK_CALIFICA_M2_IMPARTE FOREIGN KEY (CODASIG,DNIP) REFERENCES IMPARTE (CODASIG,DNIP),
	CONSTRAINT UQ_CALIFICA_M2_ALUMNO_ASIGNAT UNIQUE (DNIA,CODASIG)
);