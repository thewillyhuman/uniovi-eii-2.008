CREATE TABLE CINE
(
   CODCINE varchar(4),
   LOCALIDAD varchar(20),   
   CONSTRAINT PK_CINE PRIMARY KEY (CODCINE)
);

CREATE TABLE CINE3D
(
   CODCINE varchar(4),
   NUMSALAS decimal(1,0),   
   CONSTRAINT PK_CINE3D PRIMARY KEY (CODCINE),
   CONSTRAINT FK_CINE3D_CINE FOREIGN KEY (CODCINE) REFERENCES CINE (CODCINE)
);

CREATE TABLE SALA
(
   CODSALA varchar(4),
   AFORO decimal(3,0),   
   CODCINE varchar(4) NOT NULL,
   CONSTRAINT PK_SALA PRIMARY KEY (CODSALA),
   CONSTRAINT FK_SALA_CINE FOREIGN KEY (CODCINE) REFERENCES CINE (CODCINE)
);

CREATE TABLE PELICULA
(
   CODPELICULA varchar(4),
   TITULO varchar(20), 
   DURACION decimal(2,0),   
   TIPO varchar(20) NOT NULL, 
   CODPELICULA_ORIGINAL varchar(4),
   CONSTRAINT PK_PELICULA PRIMARY KEY (CODPELICULA),
   CONSTRAINT FK_PELICULA_PELICULA_ORIGINAL FOREIGN KEY (CODPELICULA_ORIGINAL) REFERENCES PELICULA (CODPELICULA),
   CONSTRAINT UQ_PELICULA_TITULO UNIQUE (TITULO),
   CONSTRAINT CK_PELICULA_TIPO CHECK (TIPO IN ('ficcion','aventuras','terror')) 
);

CREATE TABLE PROYECTA
(
   CODPELICULA varchar(4),
   CODSALA varchar(4),
   SESION decimal(2,0),
   FECHA date,
   ENTRADAS_VENDIDAS decimal(3,0),
   CONSTRAINT PK_PROYECTA PRIMARY KEY (CODPELICULA,CODSALA,SESION,FECHA),
   CONSTRAINT FK_PROYECTA_PELICULA FOREIGN KEY (CODPELICULA) REFERENCES PELICULA (CODPELICULA),
   CONSTRAINT FK_PROYECTA_SALA FOREIGN KEY (CODSALA) REFERENCES SALA (CODSALA),
   CONSTRAINT CK_PROYECTA_SESION CHECK (SESION IN (5,7,10))      
);

CREATE TABLE ENTRADA
(
   CODENTRADA varchar(4),
   PRECIO decimal(3,0),   
   CODPELICULA varchar(4) NOT NULL,
   CODSALA varchar(4) NOT NULL,
   SESION decimal(2,0) NOT NULL,
   FECHA date NOT NULL,  
   CONSTRAINT PK_ENTRADA PRIMARY KEY (CODENTRADA),
   CONSTRAINT FK_ENTRADA_PROYECTA FOREIGN KEY (CODPELICULA,CODSALA,SESION,FECHA) REFERENCES PROYECTA (CODPELICULA,CODSALA,SESION,FECHA)
);