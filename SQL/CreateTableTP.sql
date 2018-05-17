
/*Crear tablas de TP */
use GD1C2018
--01
create table ASPIRE_GDD.Hotel 
(
	id_hotel int identity (1,1) not null primary key,
	ciudad varchar(50) not null,
	calle varchar(50) not null,
	nro_calle int not null, 
	cantidad_de_estrellas int not null,
	recarga_estrellas int not null,
	telefono bigint not null,-- confirmar
	mail varchar(50) not null,
	id_regimen int not null,
	fecha_de_creacion date not null, 
	direccion varchar(50) not null,
	pais varchar(50) not null,
);
--02
create table ASPIRE_GDD.Hotel_Cerrado 
(
	id_hotel_cerrado int not null primary key, --Consultar esta clave primaria
	id_hotel int not null REFERENCES ASPIRE_GDD.Hotel,
	fecha date not null,
	fecha_inicio date not null, --tipofecha
	fecha_fin date not null,
	motivo varchar(160),
);
--03
create table ASPIRE_GDD.regimen ---En la tabla regimen x Hotel nos faltó el id del hotel.
(id_regimen int primary key,
descripcion varchar(100),
precio decimal)
--04
create table ASPIRE_GDD.id_Funcion
(id_funcion int primary key,
descripcion_func varchar(100),
estado char(1))
--05
create table ASPIRE_GDD.rol
(id_rol int primary key,
descripcion varchar(50),
estado bit) --- leí en el grupo de la materia que tambien se puede usar el tipo de dato BIT
--06
create table ASPIRE_GDD.funcionesX_Rol
(id_rol int REFERENCES ASPIRE_GDD.rol NOT NULL,
id_funcion int REFERENCES ASPIRE_GDD.id_Funcion NOT NULL,
primary key(id_rol,id_funcion))
--07
create table ASPIRE_GDD.usuarioBase
(id_usuario int primary key,
username varchar(20),
pass varchar(30),
baja bit) --S o N
--08
create table ASPIRE_GDD.rolX_Usuario
(id_usuario int REFERENCES ASPIRE_GDD.usuarioBase NOT NULL,
id_rol int REFERENCES ASPIRE_GDD.rol NOT NULL,
primary key(id_usuario, id_rol))
--09
CREATE TABLE ASPIRE_GDD.empleado(   -- ojo doble nombre PK idusuempleado Y idusuario
	id_usuario_empleado int IDENTITY(1,1) PRIMARY KEY REFERENCES ASPIRE_GDD.usuarioBase(id_usuario),
	datos_identificatorios varchar(255), 
	dni numeric(18,0) NOT NULL,
	mail varchar(255) NOT NULL,
	telefono numeric(18,0) NOT NULL,
	direccion varchar(255) NOT NULL,
	fecha_nacimiento datetime NOT NULL,
	hotel_dd_se_desempeña int REFERENCES ASPIRE_GDD.hotel(id_hotel) NOT NULL,
);
--10
CREATE TABLE ASPIRE_GDD.tipoHabitacion(
	tipo_codigo int IDENTITY(1,1) PRIMARY KEY,
	descripcion varchar(255),
	tipo_porcentual numeric (18,0) NOT NULL,
	
);
--11
CREATE TABLE ASPIRE_GDD.cliente ( 
 
	id_usuario_cliente int IDENTITY(1,1) PRIMARY KEY,
	--id_codigo_reserva numeric(18,0) REFERENCES ASPIRE_GDD.reserva(id_codigo_reserva) NOT NULL, -- verificar nom dif en Cl y reser
	pasaporte_numero numeric(18,0),-- UNIQUE NOT NULL,
	apellido varchar(255) NOT NULL,
	nombre varchar(255) NOT NULL,
	fecha_nacimiento datetime NOT NULL,
	mail varchar(255) NOT NULL,
	domicilio_calle varchar(255) NOT NULL,
	nro_calle numeric(18,0),
	piso integer,
	dto varchar(5),
	nacionalidad varchar(50),
	habilitado bit NOT NULL,
	estadisticasPuntos bigint NOT NULL

);
--12
create table ASPIRE_GDD.consumible
(id_codigo int primary key,
descripcion varchar(50),
precio decimal)
--13
CREATE TABLE ASPIRE_GDD.estadia(
	id_estadia int IDENTITY(1,1) PRIMARY KEY,
	fecha_inicio datetime, -- hay campos nulos en maestra, no corresp el NOT NULL
	fecha_egreso datetime,  -- FORMATO PARA PRUEBAS; datetime NOT NULL ,
	cantidad_noches numeric(18,0), -- no corresp el NOT NULL,
	id_consumible int REFERENCES ASPIRE_GDD.consumible(id_codigo) NOT NULL,
	id_regimen int REFERENCES ASPIRE_GDD.regimen(id_regimen) NOT NULL
)
--14
create table ASPIRE_GDD.Reserva 
(
	fecha_inicio date not null,
	id_codigo_reserva int identity (1,1) not null primary key,
	cantidad_noches int not null,
	fecha_fin date not null,
	id_cliente int not null REFERENCES ASPIRE_GDD.Cliente,
	id_hotel int not null REFERENCES ASPIRE_GDD.Hotel,
	id_estadia int not null REFERENCES ASPIRE_GDD.Estadia,
	id_regimen int not null REFERENCES ASPIRE_GDD.regimen,
	id_clienteOrigen int not null,
	estado varchar(50),--confirmar
	precio int
	--constraint pk_cc  primary key(id_Codigo)
	--constraint fk_fc1 foreign key(id) references otratabla (id2)
);
--15
CREATE TABLE ASPIRE_GDD.habitacion(
	id_habitacion int IDENTITY(1,1) PRIMARY KEY,
	nro numeric(18,0) NOT NULL,
	piso integer,
	id_codigo_reserva int REFERENCES ASPIRE_GDD.reserva(id_codigo_reserva) NOT NULL, -- verificar nom dif en Cliente, hab y reser
	tipo_codigo int REFERENCES ASPIRE_GDD.tipoHabitacion NOT NULL,
	id_hotel int REFERENCES ASPIRE_GDD.hotel(id_hotel) NOT NULL,
	tipo_descripcion varchar(255) NOT NULL,
	habitacion_frente char NOT NULL,
	estado bit NOT NULL,
	estadistica_de_dias varchar(255) NOT NULL
);
--16
create table ASPIRE_GDD.Regimen_x_Hotel 
(
	id_regimen int not null REFERENCES ASPIRE_GDD.Regimen,
	id_hotel int not null REFERENCES ASPIRE_GDD.Hotel,
	precio int not null,
	descripcion varchar(160) not null,
);
--17
CREATE TABLE ASPIRE_GDD.estadiaXCliente(
	id_usuario_cliente int REFERENCES ASPIRE_GDD.cliente(id_usuario_cliente) NOT NULL,
	id_estadia int  REFERENCES ASPIRE_GDD.estadia(id_estadia),
	PRIMARY KEY (id_usuario_cliente, id_estadia)
);
--18
create table ASPIRE_GDD.factura
(id_nro int primary key,
fecha date,
total decimal,
forma_de_pago varchar(10),
id_cliente int REFERENCES ASPIRE_GDD.cliente(id_usuario_cliente) NOT NULL 
 )
--19
create table ASPIRE_GDD.item
(
id_item int primary key,
id_codigo int,
id_nro int REFERENCES ASPIRE_GDD.factura NOT NULL , --id_nro es FK de factura. A esta tabla le falta el id_factura y el id_consumible
factura_cantidad int,
factura_monto decimal
)
--20
create table ASPIRE_GDD.HotelxEmpleado 
(
	id_Hotel int REFERENCES ASPIRE_GDD.Hotel,
	id_usuario_empleado int REFERENCES ASPIRE_GDD.Empleado,
	primary key (id_Hotel,id_usuario_empleado)
);
--21
CREATE TABLE ASPIRE_GDD.historicoConsumiblePorEstadia
(
id_estadia int references ASPIRE_GDD.estadia, 
id_consumible int references ASPIRE_GDD.consumible(id_codigo),
primary key (id_estadia,id_consumible)
)