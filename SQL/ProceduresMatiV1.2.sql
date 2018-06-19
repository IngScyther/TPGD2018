--Procedures


--ejemplo proced modificacion (HECHO EN VM stores7new)
/*
CREATE PROCEDURE customerDireccion @direccion VARCHAR(20)  --CREATE PROC
AS															-- AS 
UPDATE #clientesF SET address2= @direccion					-- INSTRUCCIONES
WHERE address2 LIKE ''									--GO								
GO		
*/
drop procedure customerDireccion
execute customerDireccion 'CalleDeLosF 456'

select * from ASPIRE_GDD.cliente
select * into #clientesHoteles from ASPIRE_GDD.cliente
select * from #clientesHoteles
--ABM de cliente

--alta
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE clienteAlta @pasaporte_numero numeric(18,0), @apellido varchar(255), @nombre varchar(255), @fecha_nacimiento  datetime,
	 @mail varchar(255), @domicilio_calle varchar(255), @nro_calle numeric(18,0), @piso integer, @dto varchar(5),
	@nacionalidad varchar(50), @habilitado bit, @estadisticasPuntos bigint
AS		
/*DECLARE @pasaporte_numero numeric(18,0),
	@apellido varchar(255),
	@nombre varchar(255),
	@fecha_nacimiento datetime,
	@mail varchar(255),
	@domicilio_calle varchar(255),
	@nro_calle numeric(18,0),
	@piso integer,
	@dto varchar(5),
	@nacionalidad varchar(50),
	@habilitado bit,
	@estadisticasPuntos bigint	*/	
											
INSERT INTO #clientesHoteles (pasaporte_numero,apellido,nombre,fecha_nacimiento,mail,domicilio_calle,nro_calle,piso,dto,nacionalidad,habilitado,estadisticasPuntos)
VALUES (@pasaporte_numero, @apellido, @nombre, @fecha_nacimiento, @mail, @domicilio_calle, @nro_calle, @piso, @dto,
							@nacionalidad, @habilitado, @estadisticasPuntos)	
-- ver razonamiento CONVERSION FECHA de abajo...					
GO		

/*CONVERT(DATE,'1928-06-24 00:00:00.000',20)*/ 
drop procedure clienteAlta

DECLARE @fecha DATETIME
SET @fecha=CONVERT(DATE,'1928-06-24 00:00:00.000',20)
execute clienteAlta 55566688, 'Rapostiolfo','JAMES', @fecha, 'arisgarcia@gmail.com','Avenida Raona', '1220', 1, 'A',
							'ARGENTINO', 1, 0
select * from #clientesHoteles

/*drop procedure clienteAlta
DECLARE @fecha DATETIME
SET @fecha=CONVERT(DATE,'1928-06-24 00:00:00.000',20)
execute clienteAlta 55566688, 'Garcia','ARISTOBULO', @fecha, 'arisgarcia@gmail.com','Avenida Paona', '130', 1, 'D',
							'ARGENTINO', 1, 0
select * from #clientesHoteles */ -- sin tocar los campos originales en procedure funciona ASI
-- SINO, TIRA ESTA
/*-- Mens 8114, Nivel 16, Estado 5, Procedimiento clienteAlta, Línea 0
Error al convertir el tipo de datos varchar a datetime.*/

--modificacion
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE clienteModificacion @id_usuario_cliente int, @pasaporte_numero numeric(18,0), @apellido varchar(255), @nombre varchar(255), @fecha_nacimiento  datetime,
	 @mail varchar(255), @domicilio_calle varchar(255), @nro_calle numeric(18,0), @piso integer, @dto varchar(5),
	@nacionalidad varchar(50), @habilitado bit, @estadisticasPuntos bigint
AS		
											
UPDATE #clientesHoteles
SET pasaporte_numero=@pasaporte_numero, apellido=@apellido, nombre=@nombre, fecha_nacimiento=@fecha_nacimiento, mail=@mail, 
	domicilio_calle=@domicilio_calle, nro_calle=@nro_calle, piso=@piso, dto=@dto,
							nacionalidad=@nacionalidad, habilitado=@habilitado, estadisticasPuntos=@estadisticasPuntos	
WHERE id_usuario_cliente=@id_usuario_cliente
-- ver razonamiento CONVERSION FECHA de abajo...	
-- https://social.msdn.microsoft.com/Forums/es-ES/7c3fe8c4-51e7-497f-b80e-f75052bd89bb/error-al-convertir-el-tipo-de-datos-varchar-a-datetime?forum=sqlserveres				
GO		

/*CONVERT(DATE,'1928-06-24 00:00:00.000',20)*/ 
drop procedure clienteModificacion

DECLARE @fecha DATETIME
SET @fecha=CONVERT(DATE,'2000-06-24 00:00:00.000',20)
execute clienteModificacion 96945, 55566688, 'Rapostiolfo','CARLONCHO', @fecha, 'crapostiolfo@gmail.com','Avenida Fierro', '5555', 4, 'B',
							'ARGENTINO', 1, 0
select * from #clientesHoteles order by id_usuario_cliente

--baja
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE clienteBaja @id_usuario_cliente int /*, @pasaporte_numero numeric(18,0), @apellido varchar(255), @nombre varchar(255), @fecha_nacimiento  datetime,
	 @mail varchar(255), @domicilio_calle varchar(255), @nro_calle numeric(18,0), @piso integer, @dto varchar(5),
	@nacionalidad varchar(50), @habilitado bit, @estadisticasPuntos bigint*/
AS		
											
UPDATE #clientesHoteles
SET habilitado=0  
WHERE id_usuario_cliente=@id_usuario_cliente /*, apellido=@apellido, nombre=@nombre, fecha_nacimiento=@fecha_nacimiento, mail=@mail, 
	domicilio_calle=@domicilio_calle, nro_calle=@nro_calle, piso=@piso, dto=@dto,
							nacionalidad=@nacionalidad, habilitado=@habilitado, estadisticasPuntos=@estadisticasPuntos	
WHERE id_usuario_cliente=@id_usuario_cliente*/
-- ver razonamiento CONVERSION FECHA de abajo...					


drop procedure clienteBaja
execute clienteBaja  96945  --OJO,cuando borras, el id borrado al crear NO se reutiliza.
select * from #clientesHoteles

drop procedure clienteBaja
execute clienteBaja (SELECT id_usuario_cliente FROM #clientesHoteles WHERE apellido = 'Rapostiolfo')
select * from #clientesHoteles


--SELECT 1 FROM table WHERE column1 = criterio
/*
Mens 201, Nivel 16, Estado 4, Procedimiento clienteBaja, Línea 0
El procedimiento o la función 'clienteBaja' esperaba el parámetro '@id_usuario_cliente', que no se ha especificado.
Mens. 208, Nivel 16, Estado 0, Línea 1
El nombre de objeto '#clientesHoteles' no es válido.
*/

-- problema declarar fecha?
--parametro en la abm?
--baja encadenada de lo relacionado a un cliente/hotel?

drop table #clientesHoteles

select * from ASPIRE_GDD.Hotel
select * into #hoteles from ASPIRE_GDD.Hotel
select * from #hoteles
drop table #hoteles


--ABM de hotel ( ATENCION: se AGREGO atributo habilitado)

--alta
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE hotelAlta @ciudad varchar(50), @calle varchar(50), @nro_calle int, @cantidad_de_estrellas int,
	 @recarga_estrellas int, @telefono bigint, @mail varchar(50), @pais varchar(50)

AS		
									
INSERT INTO #hoteles (ciudad,calle,nro_calle,cantidad_de_estrellas,recarga_estrellas,telefono,mail,fecha_de_creacion,pais,habilitado)
VALUES (@ciudad,@calle,@nro_calle,@cantidad_de_estrellas,@recarga_estrellas,@telefono,@mail,getdate(),@pais,1)						
GO		

/*CONVERT(DATE,'1928-06-24 00:00:00.000',20)*/ 
drop procedure hotelAlta

execute hotelAlta 'Entre Ríos', 'Urquiza',22222, 3, 10, NULL, NULL, 'Argentina'
			
select * from #hoteles


--modificacion
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE hotelModificacion @id_hotel int, @ciudad varchar(50), @calle varchar(50), @nro_calle int, @cantidad_de_estrellas int,
	 @recarga_estrellas int, @telefono bigint, @mail varchar(50), @pais varchar(50),@habilitado bit
AS		
											
UPDATE #hoteles
SET ciudad=@ciudad, calle=@calle, nro_calle=@nro_calle, cantidad_de_estrellas=@cantidad_de_estrellas, telefono=@telefono, 
	mail=@mail, pais=@pais, habilitado=@habilitado
WHERE id_hotel=@id_hotel
GO

/*CONVERT(DATE,'1928-06-24 00:00:00.000',20)*/ 
drop procedure hotelModificacion


execute hotelModificacion 17, 'La Pampa','Sauce', 33333, 5,10, NULL, NULL, 'Argentina',1
execute hotelModificacion 16, 'Concordia','Urquiza', 22222, 3,10, NULL, NULL, 'Argentina',1
														
select * from #hoteles
--quiero que quede concordia, como hacer?
/*execute hotelModificacion 16, ciudad, calle, 22223, 4,10, NULL, NULL, 'Argentina'  no es manera

*/
--que pasa si quiero dejar algun campo como estaba?
--quiero que quede entre rios.. como hacer?


--baja
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE hotelBaja @id_hotel int
AS		
											
UPDATE #hoteles
SET habilitado=0   
WHERE id_hotel=@id_hotel
			

GO	

drop procedure hotelBaja
execute hotelBaja  1 --OJO,cuando borras, el id borrado al crear NO se reutiliza.
select * from #hoteles





drop table #hoteles
select * from ASPIRE_GDD.habitacion
select * into #habitaciones from ASPIRE_GDD.habitacion
select * from #habitaciones
drop table #habitaciones

--ABM de habitacion
--atencion, dif a cliente y hotel: 
--		id_codigo_reserva int REFERENCES ASPIRE_GDD.reserva(id_codigo_reserva)



--alta
GO  --tipocod,idhotel solucion temporal con un integer NO FK

CREATE PROCEDURE habitacionAlta @nro numeric(18,0), @piso integer, @tipo_codigo int, @id_hotel int,
	 @habitacion_frente char , @estado bit, @estadistica_de_dias varchar(255)
    
AS		
												
INSERT INTO #habitaciones (nro,piso,tipo_codigo,id_hotel,
	 habitacion_frente,estado,estadistica_de_dias)
VALUES (@nro,@piso,@tipo_codigo,@id_hotel,@habitacion_frente,@estado,@estadistica_de_dias)	
					
GO		

drop procedure habitacionAlta

execute habitacionAlta 97, 2, 1004, 6,'S', 1, 'EstadisticaDeDias'
							
select * from #habitaciones


--modificacion
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE habitacionModificacion @id_habitacion int, @nro numeric(18,0), @piso integer, @tipo_codigo int, @id_hotel int,
	 @habitacion_frente char , @estado bit, @estadistica_de_dias varchar(255)
AS		
											
UPDATE #habitaciones
SET nro=@nro, piso=@piso, tipo_codigo=@tipo_codigo , id_hotel=@id_hotel, 
	habitacion_frente=@habitacion_frente, estado=@estado , estadistica_de_dias=@estadistica_de_dias 	
WHERE id_habitacion=@id_habitacion


execute habitacionModificacion 333, 98, 3, 1005, 7, 'S', 1, 'EstadisticaDeDias'

select * from #habitaciones
drop procedure habitacionModificacion

--baja

GO  
CREATE PROCEDURE habitacionBaja @id_habitacion int 
AS		
											
UPDATE #habitaciones
SET estado=0   
WHERE id_habitacion=@id_habitacion

/*  ojo DOBLE ARROBA te borra TODO
DELETE FROM #habitaciones
WHERE @id_habitacion=@id_habitacion	
*/			

drop procedure habitacionBaja
execute habitacionBaja  333 
select * from #habitaciones



--ojo AL BORRAR y luego insertar EL IDBORRADO NO se reutiliza

--revisar 
--parametro del procedure: idea juan  
--fk idhotel: via csharp
--fk tipocodigo: via csharp





select * from ASPIRE_GDD.regimen
select * into #regimen from ASPIRE_GDD.regimen
select * from #regimen

--ABM de regimen
--se agrego campo estado

--alta
GO  
CREATE PROCEDURE regimenAlta @descripcion varchar(100), @precio decimal, @estado bit
AS												
INSERT INTO #regimen (descripcion, precio, estado)
VALUES (@descripcion, @precio, 1)	
					
GO		

drop procedure regimenAlta

execute regimenAlta 'Enter Service', 25, 1
select * from #regimen


--modificacion
GO  
CREATE PROCEDURE regimenModificacion @id_regimen int, @descripcion varchar(100), @precio decimal, @estado bit
AS		
											
UPDATE #regimen
SET descripcion=@descripcion, precio=@precio, estado=@estado 
WHERE id_regimen=@id_regimen		
GO		

drop procedure regimenModificacion

execute regimenModificacion 5, 'Servicio entrada', 20, 1
select * from #regimen



drop procedure reservaBaja
execute reservaBaja  183245 
select * from #reserva








