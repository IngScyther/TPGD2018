




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
