BEGIN;
CREATE SCHEMA IF NOT EXISTS pl2;
CREATE TABLE IF NOT EXISTS pl2.Personal(
    Nombre TEXT NOT NULL,
    Anno_Nacimiento INT,
    Anno_Muerte INT,
    CONSTRAINT Personal_PK PRIMARY KEY (Nombre)
);

CREATE TABLE IF NOT EXISTS pl2.Guionistas(
    Nombre TEXT NOT NULL,
    Anno_Nacimiento INT,
    Anno_Muerte INT,
    CONSTRAINT Guionistas_PK PRIMARY KEY (Nombre),
    CONSTRAINT Guionistas_FK FOREIGN KEY (Nombre) REFERENCES pl2.Personal (Nombre) MATCH FULL
    ON DELETE NO ACTION ON UPDATE RESTRICT

);
CREATE TABLE IF NOT EXISTS pl2.Actores(
    Nombre TEXT NOT NULL,
    Anno_Nacimiento INT,
    Anno_Muerte INT,
    CONSTRAINT Actores_PK PRIMARY KEY (Nombre),
    CONSTRAINT Actores_FK FOREIGN KEY (Nombre) REFERENCES pl2.Personal (Nombre) MATCH FULL
    ON DELETE NO ACTION ON UPDATE RESTRICT
);



CREATE TABLE IF NOT EXISTS pl2.Pagina_Web(
    PW_URL TEXT UNIQUE,
    Tipo TEXT UNIQUE,
    CONSTRAINT Pagina_Web_PK PRIMARY KEY (PW_URL)
);
CREATE TABLE IF NOT EXISTS pl2.Directores(
    Nombre TEXT NOT NULL,
    Anno_Nacimiento INT,
    Anno_Muerte INT,
    CONSTRAINT Directores_PK PRIMARY KEY (Nombre),
    CONSTRAINT Directores_FK FOREIGN KEY (Nombre) REFERENCES pl2.Personal (Nombre) MATCH FULL
    ON DELETE NO ACTION ON UPDATE RESTRICT
);
CREATE TABLE IF NOT EXISTS pl2.Pelicula (
    Titulo TEXT NOT NULL,
    Duracion INT,
    Anno INT,
    Calificacion_MPA REAL,
    Idioma CHAR[2],
    Generos TEXT,
    Director_Nombre TEXT,
    CONSTRAINT Pelicula_PK PRIMARY KEY (titulo),
    CONSTRAINT Directores_FK FOREIGN KEY (Director_Nombre) REFERENCES pl2.Directores (Nombre) MATCH FULL
    ON DELETE NO ACTION ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS pl2.Criticas(
    Critico TEXT NOT NULL,
    Puntuacion REAL,
    Texto TEXT,
    Pelicula_Titulo TEXT NOT NULL,
    Pagina_Web_URL TEXT NOT NULL,
    CONSTRAINT Pelicula_FK FOREIGN KEY (Pelicula_Titulo) REFERENCES pl2.Pelicula (Titulo) MATCH FULL
    ON DELETE NO ACTION ON UPDATE RESTRICT,
    CONSTRAINT Pagina_Web_FK FOREIGN KEY (Pagina_Web_URL) REFERENCES pl2.Pagina_Web (PW_URL) MATCH FULL
    ON DELETE NO ACTION ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS pl2.Caratulas(
    Tamaño REAL,
    Nombre TEXT NOT NULL,
    Pagina_Web_URL TEXT,
    Pelicula_Titulo TEXT,
    CONSTRAINT Caratulas_PK PRIMARY KEY (Nombre),
    CONSTRAINT Pagina_Web_FK FOREIGN KEY (Pagina_Web_URL) REFERENCES pl2.Pagina_Web (PW_URL) MATCH FULL
    ON DELETE NO ACTION ON UPDATE RESTRICT,
    CONSTRAINT Pelicula_FK FOREIGN KEY (Pelicula_Titulo) REFERENCES pl2.Pelicula (Titulo) MATCH FULL
    ON DELETE NO ACTION ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS pl2.Actua(
    Personaje TEXT UNIQUE,
    Pelicula_Titulo TEXT NOT NULL,
    Actor_Nombre TEXT NOT NULL,
    CONSTRAINT Pelicula_FK FOREIGN KEY (Pelicula_Titulo) REFERENCES pl2.Pelicula (Titulo) MATCH FULL
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT Actores_FK FOREIGN KEY (Actor_Nombre) REFERENCES pl2.Actores (Nombre) MATCH FULL
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS pl2.Escribe(
    Pelicula_Titulo TEXT NOT NULL,
    Guionista_Nombre TEXT NOT NULL,
    CONSTRAINT Pelicula_FK FOREIGN KEY (Pelicula_Titulo) REFERENCES pl2.Pelicula (Titulo) MATCH FULL
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT Guionistas_FK FOREIGN KEY (Guionista_Nombre) REFERENCES pl2.Guionistas (Nombre) MATCH FULL
    ON DELETE CASCADE ON UPDATE CASCADE
);
ROLLBACK;