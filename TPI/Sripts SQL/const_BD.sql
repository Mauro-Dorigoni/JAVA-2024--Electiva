CREATE DATABASE IF NOT EXISTS biblioteca_java;

USE biblioteca_java;

CREATE TABLE IF NOT EXISTS categoria_libro (
	idCategoria int unsigned not null auto_increment,
    nombre_categoria varchar(255),
    descripcion_ampliada varchar(255),
    PRIMARY KEY (idCategoria)
);

CREATE TABLE IF NOT EXISTS libro (
	idLibro int unsigned not null auto_increment,
    titulo text,
    autor varchar(255),
    ISBN varchar(255),
    sumario text,
    idCategoria int unsigned not null,
    primary key(idLibro),
    foreign key (idCategoria) references categoria_libro (idCategoria) on update cascade
);

CREATE TABLE IF NOT EXISTS ejemplar (
	idEjemplar int unsigned not null auto_increment,
    idLibro int unsigned not null,
    nroEdicion int unsigned,
    fechaEdicion date,
    cantPaginas int unsigned,
    editorial varchar(255),
    primary key (idEjemplar, idLibro),
    foreign key (idLibro) references libro (idLibro) on update cascade
);

CREATE TABLE IF NOT EXISTS cliente (
	idCliente int unsigned not null auto_increment,
    nombre varchar(255),
    apellido varchar(255),
    mail varchar(255),
    dni varchar(8),
    contra varchar(255),
    fechaUltimoPago date,
    primary key (idCliente)
);

CREATE TABLE IF NOT EXISTS prestamo (
	fechaRealizacion date not null,
    estado varchar(255),
    idCliente int unsigned not null,
    idEjemplar int unsigned not null,
    idLibro int unsigned not null,
    primary key (fechaRealizacion, idCliente, idEjemplar, idLibro),
    foreign key (idCliente) references cliente (idCliente) on update cascade,
    foreign key (idEjemplar, idLibro) references ejemplar (idEjemplar, idLibro) on update cascade
);

CREATE TABLE IF NOT EXISTS administrativo (
	idAdministrativo int unsigned not null auto_increment,
    legajo varchar(255),
    contra varchar(255),
    nombre varchar(255),
    apellido varchar(255),
    primary key (idAdministrativo) 
);

CREATE TABLE IF NOT exists review (
	idReview int unsigned not null auto_increment,
    fechaReview date,
    puntaje int unsigned,
    descripcion text,
    estado boolean,
	fechaRealizacion date not null,
	idCliente int unsigned not null,
    idEjemplar int unsigned not null,
    idLibro int unsigned not null,
    primary key (idReview, fechaRealizacion, idCliente, idEjemplar, idLibro),
    foreign key (fechaRealizacion, idCliente, idEjemplar, idLibro) references prestamo (fechaRealizacion, idCliente, idEjemplar, idLibro) on update cascade
);

