drop database if exists ERM1;
create database ERM1;
use ERM1;

drop table if exists tiporiesgoseveridad;
create table tiporiesgoseveridad (
    TipRsgSevId int primary key auto_increment,
    TipRsgSevDescription varchar(100),
    TipRsgSevCodigo varchar(20),
    TipRsgSevCodInterno varchar(20),
    TipRsgSevEstatus tinyint constraint check (TipRsgSevEstatus = 1 or TipRsgSevEstatus = 2),
    TipRsgSevFecCrea date,
    TipRsgSevFecHorCrea datetime
);

drop table if exists tipoente;
create table tipoente (
    TipEntId int primary key auto_increment,
    TipEntDescripcion varchar(100) constraint check (TipEntDescripcion = 'Accion' or TipEntDescripcion = 'Fuente de riesgo'),
    TipEntCodInterno varchar(50),
    TipEntFecCrea date,
    TipEntFecHorCrea datetime
);

drop table if exists tipodefensa;
create table tipodefensa (
    TipDefId int primary key auto_increment,
    TipDefDescripcion varchar(50),
    TipDefCodInterno varchar(20)
);

drop table if exists subcategoriausuario;
create table subcategoriausuario (
    ScaUsrFecHorCrea date,
    ScaUsrFechHorCrea datetime,
    ScaUsrSegUsrKeyCrea int
);

drop table if exists subcategoriapeligrogenerico;
create table subcategoriapeligrogenerico (
    ScaPlgGenId int primary key auto_increment,
    ScaPlgGenDescription varchar(120),
    ScaPlgGenCodigo varchar(20),
    ScaPlgGenCodInterno varchar(20),
    ScaPlgGenEstatus tinyint constraint check (ScaPlgGenEstatus = 1 or ScaPlgGenEstatus = 2),
    ScaPlgGenFecCrea datetime,
    ScaPlgGenSegUsrKeyCrea int,
    ScaPlgGenFecModi date,
    ScaPlgGenFecHorModi datetime,
    ScaPlgGenSegUsrKeyModi int
);

drop table if exists subcategoriadefensa;
create table subcategoriadefensa (
    ScaPlgGenId foreign key references subcategoriapeligrogenerico(ScaPlgGenId),
    DefId int foreign key references defensa(DefId),
    ScaDefFecCrea date,
    ScaDefFecHorCrea datetime,
    ScaDefSegUsrKeyCrea int
);

drop table if exists subcategoriaconsecuencia;
create table subcategoriaconsecuencia (
    ScaPlgGenId int foreign key references subcategoriapeligrogenerico(ScaPlgGenId),
    CnsId int foreign key refences consecuencia(CnsId),
    ScaCnsFecCrea date,
    ScaCnsFecHorCrea datetime,
    ScaCnsSegUsrKeyCrea int
);

drop table if exists subcategoriaaccion;
create table subcategoriaaccion (
    ScaPlgGenId int foreign key references subcategoriapeligrogenerico(ScaPlgGenId),
    AccId int foreign key references accion(AccId)
);

drop table if exists spDeleteCmp;
create table spDeleteCmp ();

drop table if exists spDeletePlgGen;
create table spDeletePlgGen ();

drop table if exists significadoriesgoseveridad;
create table significadoriesgoseveridad (
    SigRsgSevId int primary key auto_increment,
    TipRsgSevId int foreign key tiporiesgoseveridad(TipRsgSevId),
    RsgSevId int foreign key riesgoseveridad(RsgSevId),
    SigRsgSevDescripcion varchar(1000),
    SigRsgSevEstatus tinyint constraint check (SigRsgSevEstatus = 1 or SigRsgSevEstatus = 2),
    SigRsgSevFecCrea date,
    SigRsgSevFecHorCrea datetime
);

drop table if exists segusuariorol;
create table segusuariorol (
    SegUsrKey int primary key,
    SegRolKey int primary key
);

drop table if exists segusuario;
create table segusuario (
    SegUsrKey int primary key auto_increment,
    SegUsrUsuario varchar(25) unique,
    SegUsrNombre varchar(100),
    SegUsrApellido varchar(100),
    SegUsrPassword varchar(100),
    SegUsrPassword varchar(256),
    SegUsrEstatus tinyint constraint check (SegUsrEstatus = 1 or SegUsrEstatus = 2),
    SegUsrCodigo varchar(50),
    SegUsrCambiarPassword tinyint constraint check (SegUsrCambiarPassword = 1 or SegUsrCambiarPassword = 2),
    SegUsrEmail varchar(100)
);

drop table if exists segrolfunction;
create table segrolfunction (
    SegRolKey int primary key,
    SegFncKey int primary key
);

drop table if exists segrol;
create table if exists segrol (
    SegRolKey int primary key auto_increment,
    SegRolNombre varchar(50),
    SegRolCodInterno varchar(20)
);

drop table if exists segprograma;
create table segprograma (
    SegPrgKey int primary key auto_increment,
    SegPrgNombre varchar(100),
    SegPrgDescripcion varchar(200)
);

drop table if exists segmenu;
create table segmenu (
    SegMenuId int primary key auto_increment,
    SegMenuNombre varchar(50),
    SegMenuDescription varchar(100),
    SegMenuIcono varchar(40),
    SegMenuURL varchar(200),
    SegMenuOrden int,
    SegMenuRaizId int, 
    SegMenuActivo tinyint constraint check (SegMenuActivo = 1 or SegMenuActivo = 2)
);

drop table if exists seglog;
create table seglog (
    SegLogKey int primary key auto_increment,
    SegLogFecha date,
    SegLogHora time,
    SegUsrKey int,
    SegUsrUsuario varchar(25),
    SegLogDetalle mediumtext,
    SegLogLlave int
);

drop table if exists segfuncion;
create table segfuncion (
    SegFncKey int primary key auto_increment,
    SegFncNombre varchar(200),
    SegPrgKey int foreign key references segprograma(SegPrgKey) -- Chequear otra vez
);

drop table if exists accion;
create table accion (
    AccId int primary key auto_increment, -- precision 10
    TipDefId int foreign key references tipodefensa(TipDefId),
    AccDescripcion varchar(500),
    AccFecLimite date,
    SegUsrKey int foreign key references usuarioresponsable
    AccEstId int foreign key references estatus
    AccFecEstatus date,
    AccActRealizadas text,
    AccFecCrea date,
    AccFecHorCrea datetime,
    AccSegUsrKeyCrea int,
    AccFecModi date,
    AccFechHorModi datetime,
    AccSegUsrKeyModi int
);