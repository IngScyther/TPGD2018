




/*Ver tabla maestra*/
select * from gd_esquema.Maestra
Go

/* Migrar tabla Hotel */
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














/*Migrar Reserva*/
INSERT INTO ASPIRE_GDD.Reserva 
( id_codigo_viejo , fecha_inicio,cantidad_noches, id_hotel, id_cliente,id_regimen)
SELECT distinct Reserva_Codigo, Reserva_Fecha_Inicio,  Reserva_Cant_Noches, 
	/*Id_Hotel*/(select distinct h.id_hotel
	from gd_esquema.Maestra m
	join ASPIRE_GDD.Hotel h on (m.Hotel_Ciudad = h.ciudad and m.Hotel_Calle = h.calle)
	where m.Hotel_Ciudad = M1.Hotel_Ciudad and m.Hotel_Calle = M1.Hotel_Calle) a,
null, null -- Agregar regimen y cliente
FROM gd_esquema.Maestra M1
Go


/* ver tabla hotel */
select * from ASPIRE_GDD.Reserva
Go

/*  Migrar tabla cliente */

INSERT INTO ASPIRE_GDD.cliente 
( mail,pasaporte_numero, apellido, nombre, fecha_nacimiento,  domicilio_calle, nro_calle, piso, dto, nacionalidad, habilitado, estadisticasPuntos)
SELECT  distinct Cliente_Mail, Cliente_Pasaporte_Nro, Cliente_Apellido, Cliente_Nombre, Cliente_Fecha_Nac, Cliente_Dom_Calle, Cliente_Nro_Calle, Cliente_Piso, Cliente_Depto, Cliente_Nacionalidad, 1, 0
--1 es habilitado y 0 desha  admas inicia con 0 PUNTOS
FROM gd_esquema.Maestra
GROUP BY Cliente_Pasaporte_Nro, Cliente_Apellido, Cliente_Nombre, Cliente_Fecha_Nac, Cliente_Mail, Cliente_Dom_Calle,  Cliente_Nro_Calle, Cliente_Piso, Cliente_Depto, Cliente_Nacionalidad
order by  Cliente_Apellido, Cliente_Nombre, Cliente_Fecha_Nac
Go

/* Ver tabla clientes */

select * from ASPIRE_GDD.cliente
Go

/*  Migrar tabla Tipo_Habitacion */
INSERT INTO  ASPIRE_GDD.tipoHabitacion(tipo_codigo,  --OJO CON tipoCodigo SIN GUIONBAJO
	descripcion, tipo_porcentual)
SELECT DISTINCT Habitacion_Tipo_Codigo,Habitacion_Tipo_Descripcion, Habitacion_Tipo_Porcentual
FROM gd_esquema.Maestra

/* Ver tabla Tipo_HAbitacion */ 
select * from ASPIRE_GDD.tipoHabitacion
GO


/*  Migrar tabla Habitacion */
delete ASPIRE_GDD.habitacion
INSERT INTO ASPIRE_GDD.habitacion(
	nro, piso, habitacion_frente, estado, estadistica_de_dias, id_hotel)
SELECT DISTINCT Habitacion_Numero, Habitacion_Piso,habitacion_frente , 1, 'EstadisticaDeDias',
	( select id_hotel from ASPIRE_GDD.Hotel H where H.ciudad = gd.Hotel_Ciudad and h.calle = gd.Hotel_Calle and h.nro_calle = gd.Hotel_Nro_Calle)
FROM gd_esquema.Maestra gd
--JOIN TIPO_HABITEACION FK
--JOIN HOTELES FK
GROUP BY Hotel_Ciudad, Hotel_Calle, Hotel_Nro_Calle, Hotel_CantEstrella, Hotel_Recarga_Estrella, 
Habitacion_Numero, Habitacion_Piso, Habitacion_Tipo_Codigo, Habitacion_Tipo_Descripcion, Habitacion_Tipo_Porcentual, Habitacion_Frente

/* Ver tabla Tipo_HAbitacion */
select * from ASPIRE_GDD.Habitacion
GO