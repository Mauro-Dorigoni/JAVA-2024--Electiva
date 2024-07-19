USE biblioteca_java;

insert into categoria_libro (nombre_categoria, descripcion_ampliada) values ('Fantasía','La fantasía.');

insert into libro (titulo, autor, ISBN, sumario, idCategoria) values ('Harry Potter y la Piedra Filosofal','J.K. Rowling','950-04-1957-2','Harry Potter tiene diez años', 1);

insert into ejemplar (idLibro, nroEdicion, fechaEdicion, cantPaginas, editorial) values (1, 10, '2000-05-01', 254, 'emece');


select * from ejemplar;
