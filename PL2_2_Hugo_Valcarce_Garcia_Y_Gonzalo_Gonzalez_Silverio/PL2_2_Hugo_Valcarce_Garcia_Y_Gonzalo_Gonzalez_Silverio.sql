BEGIN;

CREATE SCHEMA IF NOT EXISTS pl2_Fin;


CREATE TABLE IF NOT EXISTS pl2_Fin.Personal(
    Nombre TEXT NOT NULL,
    Anno_Nacimiento INT,
    Anno_Muerte INT,
    CONSTRAINT Personal_PK PRIMARY KEY (Nombre)
);

CREATE TABLE IF NOT EXISTS pl2_Fin.Guionistas(
    Nombre TEXT NOT NULL,
    CONSTRAINT Guionistas_PK PRIMARY KEY (Nombre),
    CONSTRAINT Personal_Guionistas_FK FOREIGN KEY (Nombre) REFERENCES pl2_Fin.Personal (Nombre) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE

);

CREATE TABLE IF NOT EXISTS pl2_Fin.Directores(
    Nombre TEXT NOT NULL,
    CONSTRAINT Directores_PK PRIMARY KEY (Nombre),
    CONSTRAINT Personal_directores_FK FOREIGN KEY (Nombre) REFERENCES pl2_Fin.Personal (Nombre) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS pl2_Fin.Actores(
    Nombre TEXT NOT NULL,
    CONSTRAINT Actores_PK PRIMARY KEY (Nombre),
    CONSTRAINT Personal_Actores_FK FOREIGN KEY (Nombre) REFERENCES pl2_Fin.Personal (Nombre) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS pl2_Fin.Pelicula (
    Anno INT NOT NULL,
    Titulo TEXT NOT NULL,
    Idioma CHAR(2),
    Duracion INT,
    Calificacion_MPA TEXT,
    Director_Nombre TEXT,
    CONSTRAINT Pelicula_PK PRIMARY KEY (Titulo, Anno),
    CONSTRAINT Directores_Pelicula_FK FOREIGN KEY (Director_Nombre) REFERENCES pl2_Fin.Directores (Nombre) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS pl2_Fin.Actuan(
    Papel TEXT,
    Pelicula_Titulo TEXT NOT NULL,
    Pelicula_Anno INT,
    Actor_Nombre TEXT NOT NULL,
    CONSTRAINT Actores_Peliculas_PK PRIMARY KEY (Pelicula_Anno, Pelicula_Titulo, Actor_Nombre),
    CONSTRAINT Pelicula_Actuan_FK FOREIGN KEY (Pelicula_Titulo, Pelicula_Anno) REFERENCES pl2_Fin.Pelicula (Titulo, Anno) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT Actores_Actuan_FK FOREIGN KEY (Actor_Nombre) REFERENCES pl2_Fin.Actores (Nombre) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS pl2_Fin.Generos (
    Genero TEXT NOT NULL,
    Pelicula_Anno INT NOT NULL ,
    Pelicula_Titulo TEXT NOT NULL ,
    CONSTRAINT Generos_PK PRIMARY KEY (Genero,Pelicula_Anno,Pelicula_Titulo),
    CONSTRAINT Pelicula_Genero_FK FOREIGN KEY (Pelicula_Titulo, Pelicula_Anno) REFERENCES pl2_Fin.Pelicula (Titulo, Anno) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS pl2_Fin.Guionizan(
    Pelicula_Titulo TEXT NOT NULL,
    Pelicula_Anno INT NOT NULL ,
    Guionista_Nombre TEXT NOT NULL,
    CONSTRAINT Guionistas_Peliculas_PK PRIMARY KEY (Pelicula_Anno,Pelicula_Titulo,Guionista_Nombre),
    CONSTRAINT Pelicula_Guioniza_FK FOREIGN KEY (Pelicula_Titulo, Pelicula_Anno) REFERENCES pl2_Fin.Pelicula (Titulo, Anno) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT Guionistas_Guionizan_FK FOREIGN KEY (Guionista_Nombre) REFERENCES pl2_Fin.Guionistas (Nombre) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS pl2_Fin.Pagina_Web(
    PW_URL TEXT NOT NULL,
    CONSTRAINT Pagina_Web_PK PRIMARY KEY (PW_URL)
);


CREATE TABLE IF NOT EXISTS pl2_Fin.Caratulas(
    Tamaño TEXT,
    Nombre TEXT NOT NULL,
    Pelicula_Titulo TEXT,
    Pelicula_Anno INT,
    CONSTRAINT Caratulas_PK PRIMARY KEY (Pelicula_Titulo, Pelicula_Anno, Nombre),
    CONSTRAINT Pelicula_Caratula_FK FOREIGN KEY (Pelicula_Titulo, Pelicula_Anno) REFERENCES pl2_Fin.Pelicula (Titulo, Anno) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS pl2_Fin.Criticas(
    Pelicula_Anno INT NOT NULL ,
    Pelicula_Titulo TEXT NOT NULL,
    Critico TEXT NOT NULL,
    Puntuacion numeric(2,1),
    Texto TEXT,
    Pagina_Web_URL TEXT NOT NULL,
    CONSTRAINT Criticas_PK PRIMARY KEY (Critico, Pelicula_Titulo, Pelicula_Anno),
    CONSTRAINT Pelicula_Critica_FK FOREIGN KEY (Pelicula_Titulo, Pelicula_Anno) REFERENCES pl2_Fin.Pelicula (Titulo, Anno) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT Pagina_Web_Criticas_FK FOREIGN KEY (Pagina_Web_URL) REFERENCES pl2_Fin.Pagina_Web (PW_URL) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS pl2_Fin.alojadas(
    Fecha TIMESTAMP,
    Peliculas_Anno_Caratulas INT,
    Pelicula_Titulo_Caratulas TEXT,
    PaginaWeb_URL TEXT,
    Nombre_Caratula TEXT,
    CONSTRAINT alojadas_PK PRIMARY KEY (Pelicula_Titulo_Caratulas,Peliculas_Anno_Caratulas,PaginaWeb_URL, Nombre_Caratula),
    CONSTRAINT Caratulas_alojadas_FK FOREIGN KEY (Peliculas_Anno_Caratulas,Pelicula_Titulo_Caratulas, Nombre_Caratula) REFERENCES pl2_Fin.Caratulas (Pelicula_Anno,Pelicula_Titulo, Nombre) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT PaginaWeb_alojadas_FK FOREIGN KEY (PaginaWeb_URL) REFERENCES pl2_Fin.Pagina_Web (PW_URL) MATCH FULL
    ON DELETE RESTRICT ON UPDATE CASCADE
);




CREATE SCHEMA IF NOT EXISTS pl2_Temp;

CREATE TABLE IF NOT EXISTS pl2_Temp.Actuan(
    Pelicula_Anno TEXT,
    Pelicula_Titulo TEXT ,
    Actor_Nombre TEXT,
    Fecha_nac TEXT,
    Fecha_muer TEXT,
    Papel TEXT
);

CREATE TABLE IF NOT EXISTS pl2_Temp.Directores(
    Pelicula_Anno TEXT,
    Pelicula_Titulo TEXT,
    Director_Nombre TEXT,
    Fecha_nac TEXT,
    Fecha_muer TEXT
);

CREATE TABLE IF NOT EXISTS pl2_Temp.Guionizan(
    Pelicula_Anno TEXT,
    Pelicula_Titulo TEXT,
    Guionista_Nombre TEXT ,
    Fecha_nac TEXT,
    Fecha_muer TEXT
);

CREATE TABLE IF NOT EXISTS pl2_Temp.Criticas(
    Pelicula_Anno TEXT,
    Pelicula_Titulo TEXT ,
    Critico TEXT NOT NULL,
    Puntuacion TEXT,
    Texto TEXT,
    Pagina_Web_URL TEXT
);

CREATE TABLE IF NOT EXISTS pl2_Temp.Caratulas(
    Pelicula_Anno TEXT,
    Pelicula_Titulo TEXT,
    Nombre TEXT,
    Fecha_Aloj TEXT,
    Pagina_Web_URL TEXT,
    Tamaño TEXT
);

CREATE TABLE IF NOT EXISTS pl2_Temp.Pelicula (
    Anno TEXT,
    Titulo TEXT,
    Generos TEXT,
    Idioma TEXT,
    Duracion TEXT,
    Calificacion_MPA TEXT
);

\copy pl2_Temp.Directores from 'c:/PL2_files/directores.csv' with (format csv, delimiter E'\t', NULL '\N', encoding 'UTF8')
\copy pl2_Temp.Actuan from 'c:/PL2_files/actuan.csv' with (format csv, delimiter E'\t', NULL '\N', encoding 'UTF8')
\copy pl2_Temp.Guionizan from 'c:/PL2_files/guionizan.csv' with (format csv, delimiter E'\t', NULL '\N', encoding 'UTF8')
\copy pl2_Temp.Pelicula from 'c:/PL2_files/peliculas.csv' with (format csv, delimiter E'\t', NULL 'NULL', encoding 'UTF8')
\copy pl2_Temp.Criticas from 'c:/PL2_files/criticas.csv' with (format csv, delimiter E'\t', NULL '\N', encoding 'UTF8')
\copy pl2_Temp.Caratulas from 'c:/PL2_files/caratulas.csv' with (format csv, delimiter E'\t', NULL '\N', encoding 'UTF8')

INSERT INTO pl2_Fin.Personal (Nombre, Anno_Nacimiento, Anno_Muerte)
SELECT
    distinct Actor_Nombre, Fecha_nac::INT , Fecha_muer::INT
FROM
    pl2_Temp.Actuan
WHERE Actor_Nombre NOT IN (SELECT Nombre FROM pl2_Fin.Personal);

INSERT INTO pl2_Fin.Personal (Nombre, Anno_Nacimiento, Anno_Muerte)
SELECT
    distinct Guionista_Nombre, Fecha_nac::INT ,Fecha_muer ::INT
FROM
    pl2_Temp.Guionizan
WHERE Guionista_Nombre NOT IN (SELECT Nombre FROM pl2_Fin.Personal);



INSERT INTO pl2_Fin.Personal (Nombre, Anno_Nacimiento, Anno_Muerte)
SELECT
    distinct Director_Nombre, Fecha_nac::INT , Fecha_muer:: INT
FROM
    pl2_Temp.Directores
WHERE Director_Nombre NOT IN (SELECT Nombre FROM pl2_Fin.Personal);


INSERT INTO pl2_Fin.Actores (Nombre)
SELECT
    distinct (Actor_Nombre)
FROM
    pl2_Temp.Actuan;

INSERT INTO pl2_Fin.Guionistas (Nombre)
SELECT
    distinct (Guionista_Nombre)
FROM
    pl2_Temp.Guionizan;

INSERT INTO pl2_Fin.Directores (Nombre)
SELECT
    distinct Director_Nombre
FROM
    pl2_Temp.Directores;

INSERT INTO pl2_Fin.Pelicula (Anno, Titulo, Idioma,Duracion,Calificacion_MPA,Director_Nombre)
SELECT
    distinct ON (p.Anno::int, p.Titulo)
    p.Anno::int,
    p.Titulo,
    p.Idioma::char(2),
    LEFT (Duracion, length(Duracion)-5)::int,
    p.Calificacion_MPA,
    d.Director_Nombre
FROM
    pl2_Temp.Pelicula p
LEFT JOIN pl2_Temp.Directores d ON (p.Anno=d.Pelicula_Anno) AND (p.Titulo=d.Pelicula_Titulo);

INSERT INTO pl2_Fin.Actuan (Papel, Pelicula_Titulo, Pelicula_Anno, Actor_Nombre)
SELECT
    Papel,
    Pelicula_Titulo,
    Pelicula_Anno::int,
    Actor_Nombre
FROM
    pl2_Temp.Actuan;

INSERT INTO pl2_Fin.Guionizan (Pelicula_Titulo, Pelicula_Anno, Guionista_Nombre)
SELECT
    Pelicula_Titulo,
    Pelicula_Anno::int,
    Guionista_Nombre
FROM
    pl2_Temp.Guionizan;

INSERT INTO pl2_Fin.Caratulas (Tamaño, Nombre, Pelicula_Titulo, Pelicula_Anno)
SELECT
    DISTINCT ON (Pelicula_Titulo,Pelicula_Anno,Nombre)
    Tamaño,
    Nombre,
    Pelicula_Titulo,
    Pelicula_Anno::int
FROM
    pl2_Temp.Caratulas;


INSERT INTO pl2_Fin.Generos (Genero, Pelicula_Anno, Pelicula_Titulo)
SELECT
    distinct
    regexp_split_to_table(Generos, ',+'),
    Anno::int,
    Titulo
FROM
    pl2_Temp.Pelicula;

INSERT INTO pl2_Fin.Pagina_Web (PW_URL)
SELECT
    DISTINCT split_part(Pagina_Web_URL,'/',1) || '//' || split_part (Pagina_Web_URL,'/',3)
FROM
    pl2_Temp.Criticas
WHERE split_part(Pagina_Web_URL,'/',1) || '//' || split_part (Pagina_Web_URL,'/',3) NOT IN (SELECT PW_URL FROM pl2_Fin.Pagina_Web); 

INSERT INTO pl2_Fin.Pagina_Web (PW_URL)
SELECT
    distinct split_part(Pagina_Web_URL,'/',1) || '//' || split_part (Pagina_Web_URL,'/',3)
FROM
    pl2_Temp.Caratulas
WHERE split_part(Pagina_Web_URL,'/',1) || '//' || split_part (Pagina_Web_URL,'/',3) NOT IN (SELECT PW_URL FROM pl2_Fin.Pagina_Web);

INSERT INTO pl2_Fin.alojadas(Fecha, Peliculas_Anno_Caratulas, Pelicula_Titulo_Caratulas, PaginaWeb_URL, Nombre_Caratula)
SELECT
    DISTINCT ON(Pelicula_Titulo, Pelicula_Anno, Pagina_Web_URL, Nombre)
    Fecha_Aloj::TIMESTAMP,
    Pelicula_Anno::int,
    Pelicula_Titulo,
    split_part(Pagina_Web_URL,'/',1) || '//' || split_part (Pagina_Web_URL,'/',3),
    Nombre
FROM
    pl2_Temp.Caratulas;


INSERT INTO pl2_Fin.Criticas (Pelicula_Anno, Pelicula_Titulo, Critico, Puntuacion, Texto, Pagina_Web_URL)
SELECT
    DISTINCT ON (Critico,Pelicula_Titulo,Pelicula_Anno)
    Pelicula_Anno::int,
    Pelicula_Titulo,
    Critico,
    Puntuacion::numeric(2,1),
    Texto,
    split_part(Pagina_Web_URL,'/',1) || '//' || split_part (Pagina_Web_URL,'/',3)
FROM
    pl2_Temp.Criticas;
ROLLBACK;