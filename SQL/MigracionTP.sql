


use GD1c2018

/*Ver tabla maestra*/
select * from gd_esquema.Maestra
Go
--1
/* Migrar tabla Hotel */ --OK
INSERT INTO ASPIRE_GDD.Hotel 
(ciudad, calle,nro_calle, cantidad_de_estrellas, recarga_estrellas,pais,fecha_de_creacion)
SELECT Hotel_Ciudad ,Hotel_Calle, Hotel_Nro_Calle, Hotel_CantEstrella, Hotel_Recarga_Estrella, 'Argentina',GETDATE()
FROM gd_esquema.Maestra
GROUP BY Hotel_Ciudad, Hotel_Calle, Hotel_Nro_Calle,Hotel_CantEstrella,Hotel_Recarga_Estrella
Go
/* ver tabla hotel */
select * from ASPIRE_GDD.Hotel
order by ciudad,calle
Go
--3
/* Migrar tabla Regimen */ --OK
insert into ASPIRE_GDD.regimen (descripcion, precio)
select regimen_descripcion, regimen_precio
from gd_esquema.Maestra
group by Regimen_Descripcion, Regimen_Precio
Go
/* ver tabla Regimen */
select * from ASPIRE_GDD.regimen
Go
--10
/*  Migrar tabla Tipo_Habitacion */ --OK
INSERT INTO  ASPIRE_GDD.tipoHabitacion(tipo_codigo,  --OJO CON tipoCodigo SIN GUIONBAJO
	descripcion, tipo_porcentual)
SELECT DISTINCT Habitacion_Tipo_Codigo,Habitacion_Tipo_Descripcion, Habitacion_Tipo_Porcentual
FROM gd_esquema.Maestra
GO
	/* Ver tabla Tipo_HAbitacion */ 
select * from ASPIRE_GDD.tipoHabitacion
GO
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
select * from ASPIRE_GDD.cliente
Go
--12
/*  Migrar tabla Consumible */ --OK
INSERT INTO  ASPIRE_GDD.consumible(id_codigo,descripcion,precio)
select consumible_codigo, consumible_descripcion, consumible_precio
from gd_esquema.Maestra
where Consumible_Codigo is not null
group by consumible_codigo, consumible_descripcion, consumible_precio
	/* Ver tabla Consumible */
select * from ASPIRE_GDD.consumible
Go

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
select * from ASPIRE_GDD.Habitacion
GO
--14
/*  Migrar tabla Estadia */ --Falta ID Consumible
INSERT INTO ASPIRE_GDD.estadia(
	fecha_inicio, fecha_egreso, cantidad_noches, id_habitacion)
SELECT Estadia_Fecha_Inicio, Estadia_Fecha_Inicio + Estadia_Cant_Noches , Estadia_Cant_Noches,
	(select id_habitacion from ASPIRE_GDD.habitacion ha join ASPIRE_GDD.Hotel Ho on (ha.id_hotel = ho.id_hotel)
	where gd.Hotel_Ciudad = ho.ciudad and gd.Hotel_Calle = ho.calle and gd.Hotel_Nro_Calle = Ho.nro_calle and
	 gd.Hotel_CantEstrella = ho.cantidad_de_estrellas and gd.Hotel_Recarga_Estrella = Hotel_Recarga_Estrella and 
	 gd.Habitacion_Numero = ha.nro and gd.Habitacion_Piso= ha.piso and gd.Habitacion_Frente = ha.habitacion_frente)
FROM gd_esquema.Maestra gd
where Estadia_Fecha_Inicio is  not null
Go
/* Ver tabla Estadia */
--delete ASPIRE_GDD.estadia
select * from ASPIRE_GDD.estadia
Go
--15
/*Migrar Reserva*/ -- Cliente %% id_regimen %% Estado %% Precio
INSERT INTO ASPIRE_GDD.Reserva 
( id_codigo_viejo , fecha_inicio,cantidad_noches, id_hotel, id_cliente,id_regimen)
SELECT distinct Reserva_Codigo, Reserva_Fecha_Inicio,  Reserva_Cant_Noches, 
	/*Id_Hotel*/(select distinct h.id_hotel
	from gd_esquema.Maestra m
	join ASPIRE_GDD.Hotel h on (m.Hotel_Ciudad = h.ciudad and m.Hotel_Calle = h.calle)
	where m.Hotel_Ciudad = M1.Hotel_Ciudad and m.Hotel_Calle = M1.Hotel_Calle) a,
	/*Cliente*/null, 
	/*Regimen*/(--select distinct id_regimen from ASPIRE_GDD.regimen r
	--where M1.Regimen_Precio = r.precio and M1.Regimen_Descripcion = r.descripcion
	(select distinct r.id_regimen
	from gd_esquema.Maestra m
	join ASPIRE_GDD.regimen r on (m.Regimen_Descripcion = r.descripcion and m.Regimen_Precio = r.precio)
	where r.descripcion = M1.Regimen_Descripcion and r.precio = M1.Regimen_Precio)
	)	
FROM gd_esquema.Maestra M1
Go	/* ver tabla Reserva */
	delete ASPIRE_GDD.Reserva
	select * from ASPIRE_GDD.Reserva	
	Go
--18
/*  Migrar tabla Factura */ --Falta armar
INSERT INTO ASPIRE_GDD.factura 
(fecha,total,id_cliente)
select gd1.Factura_Fecha,gd1.Factura_Total,id_usuario_cliente from ASPIRE_GDD.cliente c, gd_esquema.Maestra gd1  	
where gd1.Cliente_Mail = c.mail and gd1.Factura_Fecha is not null and gd1.Factura_Total is not null
group by id_usuario_cliente,gd1.Factura_Fecha,gd1.Factura_Total
/* ver tabla Factura */
select * from ASPIRE_GDD.factura	
Go
--19 --Falta armar
/*  Migrar tabla item  */ --Falta ID Consumible
INSERT INTO ASPIRE_GDD.item
select Item_Factura_Cantidad, Item_Factura_Monto
from gd_esquema.Maestra , Factura, Consumible
where Factura_Nro = id_factura
and consumible_codigo = id_codigo
/* ver tabla Reserva */
