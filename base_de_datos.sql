drop database if exists RWA;
create database RWA;
use RWA;

drop table if exists usuario;
create table usuario (
    usuarioid int primary key auto_increment,
    usuario varchar(25),
    usuarionombre varchar(120),
    usuariopass varchar(255), -- encriptada
    usuarioestatus tinyint(1) constraint check (usuarioestatus = 1 or usuarioestatus = 2) default 1,
    usuariocambiapass tinyint(1) constraint check (usuariocambiapass = 0 or usuariocambiapass = 1) default 0,
    usuariocorreo varchar(120)
);

drop table if exists rol;
create table rol (
    rolid int(10) primary key auto_increment,
    roldescripcion varchar(120)
);

drop table if exists funcion;
create table funcion (
    funcionid int primary key auto_increment,
    funciondescripcion varchar(120)
);

drop table if exists rolfuncion;
create table rolfuncion (
    rolid int,
    functionid int
);

drop table if exists parametro;
create table parametro (
    parcodigo char(50) primary key,
    pardescripcion varchar(120),
    parexplicacion text,
    partipo tinyint(1) constraint check (partipo = 1 or partipo = 2 or partipo = 3 or partipo = 4),
    parvalor varchar(250) 
);