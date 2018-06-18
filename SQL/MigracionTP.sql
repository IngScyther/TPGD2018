


use GD1c2018

/*Ver tabla maestra*/
--select * from gd_esquema.Maestra
--Go
--1
/* Migrar tabla Hotel */ --OK
INSERT INTO ASPIRE_GDD.Hotel 
(ciudad, calle,nro_calle, cantidad_de_estrellas, recarga_estrellas,pais,fecha_de_creacion)
SELECT Hotel_Ciudad ,Hotel_Calle, Hotel_Nro_Calle, Hotel_CantEstrella, Hotel_Recarga_Estrella, 'Argentina',GETDATE()
FROM gd_esquema.Maestra
GROUP BY Hotel_Ciudad, Hotel_Calle, Hotel_Nro_Calle,Hotel_CantEstrella,Hotel_Recarga_Estrella
Go
/* ver tabla hotel */
--select * from ASPIRE_GDD.Hotel
--order by ciudad,calle
--Go
--3
/* Migrar tabla Regimen */ --OK
insert into ASPIRE_GDD.regimen (descripcion, precio)
select regimen_descripcion, regimen_precio
from gd_esquema.Maestra
group by Regimen_Descripcion, Regimen_Precio
Go
/* ver tabla Regimen */
--select * from ASPIRE_GDD.regimen
--Go
--10
/*  Migrar tabla Tipo_Habitacion */ --OK
INSERT INTO  ASPIRE_GDD.tipoHabitacion(tipo_codigo,  --OJO CON tipoCodigo SIN GUIONBAJO
	descripcion, tipo_porcentual)
SELECT DISTINCT Habitacion_Tipo_Codigo,Habitacion_Tipo_Descripcion, Habitacion_Tipo_Porcentual
FROM gd_esquema.Maestra
GO
	/* Ver tabla Tipo_HAbitacion */ 
--select * from ASPIRE_GDD.tipoHabitacion
--GO
--11
/*  Migrar tabla cliente */ --OK
INSERT INTO ASPIRE_GDD.cliente 
( mail,pasaporte_numero, apellido, nombre, fecha_nacimiento,  domicilio_calle, nro_calle, piso, dto, nacionalidad, habilitado, estadisticasPuntos)
SELECT  Cliente_Mail, Cliente_Pasaporte_Nro, Cliente_Apellido, Cliente_Nombre, Cliente_Fecha_Nac, Cliente_Dom_Calle, Cliente_Nro_Calle, Cliente_Piso, Cliente_Depto, Cliente_Nacionalidad, 1, 0
--1 es habilitado y 0 desha  admas inicia con 0 PUNTOS
FROM gd_esquema.Maestra
GROUP BY Cliente_Pasaporte_Nro, Cliente_Apellido, Cliente_Nombre, Cliente_Fecha_Nac, Cliente_Mail, Cliente_Dom_Calle,  Cliente_Nro_Calle, Cliente_Piso, Cliente_Depto, Cliente_Nacionalidad
order by  Cliente_Apellido, Cliente_Nombre, Cliente_Fecha_Nac
Go
	/* Ver tabla clientes */
--select * from ASPIRE_GDD.cliente
--Go
--12
/*  Migrar tabla Consumible */ --OK
INSERT INTO  ASPIRE_GDD.consumible(id_codigo,descripcion,precio)
select consumible_codigo, consumible_descripcion, consumible_precio
from gd_esquema.Maestra
where Consumible_Codigo is not null
group by consumible_codigo, consumible_descripcion, consumible_precio
	/* Ver tabla Consumible */
--select * from ASPIRE_GDD.consumible
--Go

--13
/*  Migrar tabla Habitacion */ --OK
INSERT INTO ASPIRE_GDD.habitacion(
	nro, piso, habitacion_frente, estado, estadistica_de_dias, id_hotel,tipo_codigo)
SELECT DISTINCT Habitacion_Numero, Habitacion_Piso,habitacion_frente , 1, 'EstadisticaDeDias',
	(select id_hotel from ASPIRE_GDD.Hotel H where H.ciudad = gd.Hotel_Ciudad and h.calle = gd.Hotel_Calle and h.nro_calle = gd.Hotel_Nro_Calle and h.cantidad_de_estrellas=gd.Hotel_CantEstrella and h.recarga_estrellas = gd.Hotel_Recarga_Estrella),
	Habitacion_Tipo_Codigo
FROM gd_esquema.Maestra gd
GROUP BY Hotel_Ciudad, Hotel_Calle, Hotel_Nro_Calle, Hotel_CantEstrella, Hotel_Recarga_Estrella, 
Habitacion_Numero, Habitacion_Piso, Habitacion_Tipo_Codigo, Habitacion_Tipo_Descripcion, Habitacion_Tipo_Porcentual, Habitacion_Frente
Go
	/* Ver tabla Habitacion */
--select * from ASPIRE_GDD.Habitacion
--GO


--18
/*  Migracion de datos a tabla Factura */ --Terminada
INSERT INTO ASPIRE_GDD.factura 
(id_nro, fecha, total, id_cliente)

select gd1.Factura_Nro, gd1.Factura_Fecha, gd1.Factura_Total,  c.id_usuario_cliente 
from ASPIRE_GDD.cliente c,
	gd_esquema.Maestra gd1 
where c.pasaporte_numero = gd1.Cliente_Pasaporte_Nro
	and c.apellido = gd1.Cliente_Apellido
	and c.nombre = gd1.Cliente_Nombre
	and c.fecha_nacimiento = gd1.Cliente_Fecha_Nac
	and c.mail = gd1.Cliente_Mail
	and c.domicilio_calle = gd1.Cliente_Dom_Calle
	and c.nro_calle = gd1.Cliente_Nro_Calle
	and c.piso = gd1.Cliente_Piso
	and c.dto = gd1.Cliente_Depto
	and gd1.Factura_Nro is not null

group by gd1.Factura_Nro, c.id_usuario_cliente, gd1.Factura_Fecha, gd1.Factura_Total
order by gd1.Factura_Nro, c.id_usuario_cliente, gd1.Factura_Fecha, gd1.Factura_Total

/* ver tabla Factura */
--select * from ASPIRE_GDD.factura	
--Go


--14
/*  Migrar tabla Estadia */ -- Terminada
INSERT INTO ASPIRE_GDD.estadia
(fecha_inicio, fecha_egreso, cantidad_noches, id_regimen, id_nro)

select gd1.Estadia_Fecha_Inicio,
	Estadia_Fecha_Inicio + Estadia_Cant_Noches fecha_de_egreso,
	Estadia_Cant_Noches, 
	id_regimen,
	id_nro
from gd_esquema.Maestra gd1, 
		ASPIRE_GDD.cliente c,
		ASPIRE_GDD.factura f,
		ASPIRE_GDD.regimen r
where c.pasaporte_numero = gd1.Cliente_Pasaporte_Nro
	and c.apellido = gd1.Cliente_Apellido
	and c.nombre = gd1.Cliente_Nombre
	and c.fecha_nacimiento = gd1.Cliente_Fecha_Nac
	and c.mail = gd1.Cliente_Mail
	and c.domicilio_calle = gd1.Cliente_Dom_Calle
	and c.nro_calle = gd1.Cliente_Nro_Calle
	and c.piso = gd1.Cliente_Piso
	and c.dto = gd1.Cliente_Depto
	and gd1.Factura_Nro is not null

	and c.id_usuario_cliente = f.id_cliente

	and gd1.Regimen_Descripcion = r.descripcion
	and gd1.Regimen_Precio = r.precio

group by gd1.Estadia_Fecha_Inicio, Estadia_Fecha_Inicio + Estadia_Cant_Noches, Estadia_Cant_Noches, id_regimen, id_nro

Go
/* Ver tabla Estadia */

--select * from ASPIRE_GDD.estadia
--Go
--15
/*Migrar Reserva*/ -- Cliente %% id_regimen %% Estado %% Precio  --Revisar campos y relaciones con las demas tablas (pendiente)
INSERT INTO ASPIRE_GDD.Reserva 
( id_codigo_viejo , fecha_inicio,cantidad_noches, id_hotel, id_clienteOrigen,id_regimen,id_estadia)
SELECT distinct Reserva_Codigo, Reserva_Fecha_Inicio,  Reserva_Cant_Noches, 
	/*Id_Hotel*/(select distinct h.id_hotel
	from gd_esquema.Maestra m
	join ASPIRE_GDD.Hotel h on (m.Hotel_Ciudad = h.ciudad and m.Hotel_Calle = h.calle)
	where m.Hotel_Ciudad = M1.Hotel_Ciudad and m.Hotel_Calle = M1.Hotel_Calle) a,
	/*Cliente*/(
	select distinct c.id_usuario_cliente
	from gd_esquema.Maestra m
	join ASPIRE_GDD.cliente c on (m.Cliente_Pasaporte_Nro = c.pasaporte_numero and
	m.Cliente_Mail = c.mail and m.Cliente_Apellido = c.apellido and m.Cliente_Nombre = c.nombre
	and m.Cliente_Fecha_Nac = c.fecha_nacimiento and m.Cliente_Dom_Calle=c.domicilio_calle and
	m.Cliente_Nro_Calle = c.nro_calle and m.Cliente_Piso = c.piso and m.Cliente_Depto = c.dto
	and m.Cliente_Nacionalidad = c.nacionalidad  )
	where M1.Cliente_Pasaporte_Nro = c.pasaporte_numero and
	M1.Cliente_Mail = c.mail and M1.Cliente_Apellido = c.apellido and M1.Cliente_Nombre = c.nombre
	and M1.Cliente_Fecha_Nac = c.fecha_nacimiento and M1.Cliente_Dom_Calle=c.domicilio_calle and
	M1.Cliente_Nro_Calle = c.nro_calle and M1.Cliente_Piso = c.piso and M1.Cliente_Depto = c.dto
	and M1.Cliente_Nacionalidad = c.nacionalidad
	), 
	
	/*Regimen*/
	(select distinct r.id_regimen
	from gd_esquema.Maestra m
	join ASPIRE_GDD.regimen r on (m.Regimen_Descripcion = r.descripcion and m.Regimen_Precio = r.precio)
	where r.descripcion = M1.Regimen_Descripcion and r.precio = M1.Regimen_Precio
	),
	/*Estadia*/
	( select top 1 e.id_estadia
	from gd_esquema.Maestra m
	left join ASPIRE_GDD.estadia e on (m.Estadia_Fecha_Inicio = e.fecha_inicio and m.Estadia_Cant_Noches = e.cantidad_noches)
	where m.Reserva_Codigo = M1.Reserva_Codigo and m.Estadia_Cant_Noches = M1.Estadia_Cant_Noches and m.Estadia_Fecha_Inicio = M1.Estadia_Fecha_Inicio
	--and m.Cliente_Mail = M1.Cliente_Mail and m.Cliente_Nro_Calle=M1.Cliente_Nro_Calle and m.Hotel_Calle = M1.Hotel_Calle and m.Cliente_Dom_Calle =M1.Cliente_Dom_Calle
	and e.id_estadia is not null
	  )	
FROM gd_esquema.Maestra M1
Go
	/* ver tabla Reserva */
--	delete ASPIRE_GDD.Reserva
--	select * from ASPIRE_GDD.Reserva
--	order by id_estadia	
--	Go
	


--16
insert into ASPIRE_GDD.Regimen_x_Hotel
(id_regimen, id_hotel)
select id_regimen,id_hotel from gd_esquema.Maestra M1, ASPIRE_GDD.Hotel h, ASPIRE_GDD.regimen r 
where M1.Hotel_Ciudad=h.ciudad and M1.Hotel_Calle = h.calle and M1.Hotel_Nro_Calle=h.nro_calle and M1.Hotel_CantEstrella = h.cantidad_de_estrellas 
and M1.Regimen_Descripcion=r.descripcion and M1.Regimen_Precio = r.precio
group by id_hotel,id_regimen 
Go 

--select * from ASPIRE_GDD.Regimen_x_Hotel	
--17
insert into ASPIRE_GDD.estadiaXCliente
(id_estadia,id_usuario_cliente)
select id_estadia, id_cliente  from ASPIRE_GDD.estadia e , ASPIRE_GDD.factura f
		where e.id_nro = f.id_nro
		order by id_estadia 
		
Go




--19 --
/*  Migracion de datos a tabla item  */ --Terminada
INSERT INTO ASPIRE_GDD.item
(id_codigo, --Es el id de consumible
id_nro, --es el id de factura
factura_cantidad, 
factura_monto)

select c.id_codigo, f.id_nro, gdm.Item_Factura_Cantidad, gdm.Item_Factura_Monto
from gd_esquema.Maestra gdm, 
	ASPIRE_GDD.Factura f, 
	ASPIRE_GDD.Consumible c
where gdm.Factura_Nro = f.id_nro
	and consumible_codigo = c.id_codigo


/* Cargar tablas manuales */

--1
insert ASPIRE_GDD.id_Funcion values ('ABM de ROL',1)
--2
insert ASPIRE_GDD.id_Funcion values ('ABM de Usuario',1)
--3
insert ASPIRE_GDD.id_Funcion values ('ABM de Cliente',1)
--4
insert ASPIRE_GDD.id_Funcion values ('ABM de Hotel',1)
--5
insert ASPIRE_GDD.id_Funcion values ('ABM de Habitacion',1)
--6
insert ASPIRE_GDD.id_Funcion values ('ABM de Regimen de Estadia',1)
--7
insert ASPIRE_GDD.id_Funcion values ('Generar o Modificar Reserva',1)
--8
insert ASPIRE_GDD.id_Funcion values ('Cancelar reserva',1)
--9
insert ASPIRE_GDD.id_Funcion values ('Registrar estadia',1)
--10
insert ASPIRE_GDD.id_Funcion values ('Registrar consumibles',1)
--11
insert ASPIRE_GDD.id_Funcion values ('Listado estadistico',1)

/* Cargar roles. */
--1
insert ASPIRE_GDD.rol values ('Administrador',1)
--2
insert ASPIRE_GDD.rol values ('Guest',1)
--3
insert ASPIRE_GDD.rol values ('Recepcionista',1)

/* Agregar funcionalidades */
/*admin*/
insert ASPIRE_GDD.funcionesX_Rol values (1,1) 
insert ASPIRE_GDD.funcionesX_Rol values (1,2)
insert ASPIRE_GDD.funcionesX_Rol values (1,3)
insert ASPIRE_GDD.funcionesX_Rol values (1,4)
insert ASPIRE_GDD.funcionesX_Rol values (1,5)
insert ASPIRE_GDD.funcionesX_Rol values (1,6)
insert ASPIRE_GDD.funcionesX_Rol values (1,7)
insert ASPIRE_GDD.funcionesX_Rol values (1,8)
insert ASPIRE_GDD.funcionesX_Rol values (1,9)
insert ASPIRE_GDD.funcionesX_Rol values (1,10)
insert ASPIRE_GDD.funcionesX_Rol values (1,11)
insert ASPIRE_GDD.funcionesX_Rol values (1,12)
/*guest*/
insert ASPIRE_GDD.funcionesX_Rol values (2,7)
insert ASPIRE_GDD.funcionesX_Rol values (2,8)
/*recepcionista*/
insert ASPIRE_GDD.funcionesX_Rol values (3,6)
insert ASPIRE_GDD.funcionesX_Rol values (3,7)
insert ASPIRE_GDD.funcionesX_Rol values (3,8)
insert ASPIRE_GDD.funcionesX_Rol values (3,9)

/* crear el user */
insert ASPIRE_GDD.usuarioBase values ('admin','w23e',1,null,12345678,'Flavio@Hotel.org',4444444,'Zapata',getdate())

/* Agregar hotel */
insert ASPIRE_GDD.HotelxEmpleado values (1,1)
insert ASPIRE_GDD.HotelxEmpleado values (2,1)
insert ASPIRE_GDD.HotelxEmpleado values (3,1)
insert ASPIRE_GDD.HotelxEmpleado values (4,1)
insert ASPIRE_GDD.HotelxEmpleado values (5,1)
insert ASPIRE_GDD.HotelxEmpleado values (6,1)
insert ASPIRE_GDD.HotelxEmpleado values (7,1)
insert ASPIRE_GDD.HotelxEmpleado values (8,1)
insert ASPIRE_GDD.HotelxEmpleado values (9,1)
insert ASPIRE_GDD.HotelxEmpleado values (10,1)
insert ASPIRE_GDD.HotelxEmpleado values (11,1)
insert ASPIRE_GDD.HotelxEmpleado values (12,1)
insert ASPIRE_GDD.HotelxEmpleado values (13,1)
insert ASPIRE_GDD.HotelxEmpleado values (14,1)
insert ASPIRE_GDD.HotelxEmpleado values (15,1)

