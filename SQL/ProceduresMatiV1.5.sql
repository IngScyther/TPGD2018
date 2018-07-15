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
--select * into #clientesHoteles from ASPIRE_GDD.cliente
--select * from #clientesHoteles
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
											
INSERT INTO ASPIRE_GDD.cliente (pasaporte_numero,apellido,nombre,fecha_nacimiento,mail,domicilio_calle,nro_calle,piso,dto,nacionalidad,habilitado,estadisticasPuntos)
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
select * from ASPIRE_GDD.cliente

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
											
UPDATE ASPIRE_GDD.cliente
SET pasaporte_numero=@pasaporte_numero, apellido=@apellido, nombre=@nombre, fecha_nacimiento=@fecha_nacimiento, mail=@mail, 
	domicilio_calle=@domicilio_calle, nro_calle=@nro_calle, piso=@piso, dto=@dto,
							nacionalidad=@nacionalidad, habilitado=@habilitado, estadisticasPuntos=@estadisticasPuntos	
WHERE id_usuario_cliente=@id_usuario_cliente
IF @id_usuario_cliente NOT IN (SELECT id_usuario_cliente FROM ASPIRE_GDD.cliente)
	PRINT 'El usuario no existe, inténtelo de nuevo'
	ELSE PRINT 'Modificación exitosa'

 

-- ver razonamiento CONVERSION FECHA de abajo...	
-- https://social.msdn.microsoft.com/Forums/es-ES/7c3fe8c4-51e7-497f-b80e-f75052bd89bb/error-al-convertir-el-tipo-de-datos-varchar-a-datetime?forum=sqlserveres				
/*CONVERT(DATE,'1928-06-24 00:00:00.000',20)*/ 
drop procedure clienteModificacion

DECLARE @fecha DATETIME
SET @fecha=CONVERT(DATE,'2000-06-24 00:00:00.000',20)
execute clienteModificacion 96945, 55566688, 'Rapostiolfo','GERVASIO', @fecha, 'crapostiolfo@gmail.com','Avenida Fierro', '5555', 4, 'B',
							'ARGENTINO', 1, 0
select * from ASPIRE_GDD.cliente order by id_usuario_cliente

--baja
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE clienteBaja @id_usuario_cliente int /*, @pasaporte_numero numeric(18,0), @apellido varchar(255), @nombre varchar(255), @fecha_nacimiento  datetime,
	 @mail varchar(255), @domicilio_calle varchar(255), @nro_calle numeric(18,0), @piso integer, @dto varchar(5),
	@nacionalidad varchar(50), @habilitado bit, @estadisticasPuntos bigint*/
AS		
											
UPDATE ASPIRE_GDD.cliente
SET habilitado=0  
WHERE id_usuario_cliente=@id_usuario_cliente /*, apellido=@apellido, nombre=@nombre, fecha_nacimiento=@fecha_nacimiento, mail=@mail, 
	domicilio_calle=@domicilio_calle, nro_calle=@nro_calle, piso=@piso, dto=@dto,
							nacionalidad=@nacionalidad, habilitado=@habilitado, estadisticasPuntos=@estadisticasPuntos	
WHERE id_usuario_cliente=@id_usuario_cliente*/
-- ver razonamiento CONVERSION FECHA de abajo...					


drop procedure clienteBaja
execute clienteBaja  96945  --OJO,cuando borras, el id borrado al crear NO se reutiliza.
select * from ASPIRE_GDD.cliente

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

--drop table #clientesHoteles

select * from ASPIRE_GDD.Hotel
--select * into #hoteles from ASPIRE_GDD.Hotel
--select * from #hoteles
--drop table #hoteles


--ABM de hotel ( ATENCION: se AGREGO atributo habilitado)

--alta
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE hotelAlta @ciudad varchar(50), @calle varchar(50), @nro_calle int, @cantidad_de_estrellas int,
	 @recarga_estrellas int, @telefono bigint, @mail varchar(50), @pais varchar(50)

AS		
									
INSERT INTO ASPIRE_GDD.Hotel (ciudad,calle,nro_calle,cantidad_de_estrellas,recarga_estrellas,telefono,mail,fecha_de_creacion,pais,habilitado)
VALUES (@ciudad,@calle,@nro_calle,@cantidad_de_estrellas,@recarga_estrellas,@telefono,@mail,getdate(),@pais,1)						
GO		

/*CONVERT(DATE,'1928-06-24 00:00:00.000',20)*/ 
drop procedure hotelAlta

execute hotelAlta 'Entre Ríos', 'Urquiza',22222, 3, 10, NULL, NULL, 'Argentina'
			
select * from ASPIRE_GDD.Hotel


--modificacion
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE hotelModificacion @id_hotel int, @ciudad varchar(50), @calle varchar(50), @nro_calle int, @cantidad_de_estrellas int,
	 @recarga_estrellas int, @telefono bigint, @mail varchar(50), @pais varchar(50),@habilitado bit
AS		
											
UPDATE ASPIRE_GDD.Hotel
SET ciudad=@ciudad, calle=@calle, nro_calle=@nro_calle, cantidad_de_estrellas=@cantidad_de_estrellas, telefono=@telefono, 
	mail=@mail, pais=@pais, habilitado=@habilitado
WHERE id_hotel=@id_hotel
GO

/*CONVERT(DATE,'1928-06-24 00:00:00.000',20)*/ 
drop procedure hotelModificacion


execute hotelModificacion 17, 'La Pampa','Sauce', 33333, 5,10, NULL, NULL, 'Argentina',1
execute hotelModificacion 16, 'Concordia','Urquiza', 22222, 3,10, NULL, NULL, 'Argentina',1
														
select * from ASPIRE_GDD.Hotel

--quiero que quede concordia, como hacer sin pasarle toda la info a mano?
/*execute hotelModificacion 16, ciudad, calle, 22223, 4,10, NULL, NULL, 'Argentina'  no es manera

*/
--que pasa si quiero dejar algun campo como estaba?
--quiero que quede entre rios.. como hacer?


--baja
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE hotelBaja @id_hotel int
AS		
											
UPDATE ASPIRE_GDD.Hotel
SET habilitado=0   
WHERE id_hotel=@id_hotel
			

GO	

drop procedure hotelBaja
execute hotelBaja  16 --OJO,cuando borras, el id borrado al crear NO se reutiliza.
select * from ASPIRE_GDD.Hotel





--drop table #hoteles
select * from ASPIRE_GDD.habitacion
--select * into #habitaciones from ASPIRE_GDD.habitacion
--select * from #habitaciones
--drop table #habitaciones

--ABM de habitacion
--atencion, dif a cliente y hotel: 
--		id_codigo_reserva int REFERENCES ASPIRE_GDD.reserva(id_codigo_reserva)



--alta
GO  --tipocod,idhotel solucion temporal con un integer NO FK

CREATE PROCEDURE habitacionAlta @nro numeric(18,0), @piso integer, @tipo_codigo int, @id_hotel int,
	 @habitacion_frente char , @estado bit, @estadistica_de_dias varchar(255)
    
AS		
												
INSERT INTO ASPIRE_GDD.habitacion (nro,piso,tipo_codigo,id_hotel,
	 habitacion_frente,estado,estadistica_de_dias)
VALUES (@nro,@piso,@tipo_codigo,@id_hotel,@habitacion_frente,@estado,@estadistica_de_dias)	
					
GO		

drop procedure habitacionAlta

execute habitacionAlta 333, 2, 1004, 6,'S', 1, 'EstadisticaDeDias'
							
select * from ASPIRE_GDD.habitacion


--modificacion
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE habitacionModificacion @id_habitacion int, @nro numeric(18,0), @piso integer, @tipo_codigo int, @id_hotel int,
	 @habitacion_frente char , @estado bit, @estadistica_de_dias varchar(255)
AS		
											
UPDATE ASPIRE_GDD.habitacion
SET nro=@nro, piso=@piso, tipo_codigo=@tipo_codigo , id_hotel=@id_hotel, 
	habitacion_frente=@habitacion_frente, estado=@estado , estadistica_de_dias=@estadistica_de_dias 	
WHERE id_habitacion=@id_habitacion


execute habitacionModificacion 333, 98, 3, 1005, 7, 'S', 1, 'EstadisticaDeDias'

select * from ASPIRE_GDD.habitacion
drop procedure habitacionModificacion

--baja

GO  
CREATE PROCEDURE habitacionBaja @id_habitacion int 
AS		
											
UPDATE ASPIRE_GDD.habitacion
SET estado=0   
WHERE id_habitacion=@id_habitacion

/*  ojo DOBLE ARROBA te borra TODO
DELETE FROM #habitaciones
WHERE @id_habitacion=@id_habitacion	
*/			

drop procedure habitacionBaja
execute habitacionBaja  333 
select * from ASPIRE_GDD.habitacion



--ojo AL BORRAR y luego insertar EL IDBORRADO NO se reutiliza

--revisar 
--parametro del procedure: idea juan  
--fk idhotel: via csharp
--fk tipocodigo: via csharp





select * from ASPIRE_GDD.regimen
--select * into #regimen from ASPIRE_GDD.regimen
--select * from #regimen

--ABM de regimen
--se agrego campo estado

--alta
GO  
CREATE PROCEDURE regimenAlta @descripcion varchar(100), @precio decimal, @estado bit
AS												
INSERT INTO ASPIRE_GDD.regimen (descripcion, precio, estado)
VALUES (@descripcion, @precio, 1)	
					
GO		

drop procedure regimenAlta

execute regimenAlta 'Enter Service', 25, 1
select * from ASPIRE_GDD.regimen


--modificacion
GO  
CREATE PROCEDURE regimenModificacion @id_regimen int, @descripcion varchar(100), @precio decimal, @estado bit
AS		
											
UPDATE ASPIRE_GDD.regimen
SET descripcion=@descripcion, precio=@precio, estado=@estado 
WHERE id_regimen=@id_regimen		
GO		

drop procedure regimenModificacion

execute regimenModificacion 5, 'Servicio entrada', 20, 1
select * from ASPIRE_GDD.regimen

--baja
GO 
CREATE PROCEDURE regimenBaja @id_regimen int
AS		
											
UPDATE ASPIRE_GDD.regimen
SET estado=0  
WHERE id_regimen=@id_regimen
GO
				
drop procedure regimenBaja
execute regimenBaja  5  
select * from ASPIRE_GDD.regimen

--RESERVA, PROBLEMA CON FOREIGN KEYS:

/*Mens 547, Nivel 16, Estado 0, Procedimiento reservaAlta, Línea 15
Instrucción INSERT en conflicto con la restricción FOREIGN KEY "FK__Reserva__id_esta__375B2DB9". 
El conflicto ha aparecido en la base de datos "GD1C2018", tabla "ASPIRE_GDD.estadia", column 'id_estadia'.
Se terminó la instrucción.
*/

select * from ASPIRE_GDD.Reserva
	select * from ASPIRE_GDD.cliente --idcliente idusuariocliente
	select * from ASPIRE_GDD.Hotel    --idhotel idhotel
	select * from ASPIRE_GDD.estadia   --idestadia idestadia
	select * from ASPIRE_GDD.regimen   --ideregimen idregimen
	select * from ASPIRE_GDD.cliente --idclienteorigen idusuariocliente			


select * into #reserva from ASPIRE_GDD.Reserva
select * from #reserva
drop table #reserva

--ABM de reserva
--atencion, dif a cliente y hotel: 
/*
create table ASPIRE_GDD.Reserva 
(
	fecha_inicio date,
	id_codigo_reserva int identity (1,1)primary key,
	id_codigo_viejo int ,
	cantidad_noches int,
	fecha_fin date,
	id_cliente int REFERENCES ASPIRE_GDD.Cliente,
	id_hotel int REFERENCES ASPIRE_GDD.Hotel,
	id_estadia int REFERENCES ASPIRE_GDD.Estadia,
	id_regimen int REFERENCES ASPIRE_GDD.regimen,
	id_clienteOrigen int,
	estado varchar(50),--confirmar
	precio int
	--constraint pk_cc  primary key(id_Codigo)
	--constraint fk_fc1 foreign key(id) references otratabla (id2)
);


*/


--alta
GO  

CREATE PROCEDURE reservaAlta @fecha_inicio date,	--asumo no pasa estado, arrancan habilitadas las reservas
	@id_codigo_viejo int ,
	@cantidad_noches int,
	@fecha_fin date,
	@id_cliente int, --REFERENCES ASPIRE_GDD.Cliente,
	@id_hotel int, --REFERENCES ASPIRE_GDD.Hotel,
	@id_estadia int, --REFERENCES ASPIRE_GDD.Estadia,
	@id_regimen int, --REFERENCES ASPIRE_GDD.regimen,
	@id_clienteOrigen int,
	@precio int
    
AS		
												
INSERT INTO ASPIRE_GDD.Reserva(fecha_inicio,id_codigo_viejo,cantidad_noches,fecha_fin,
	 id_cliente,id_hotel,id_estadia,id_clienteOrigen,estado,precio)
VALUES (@fecha_inicio,@id_codigo_viejo,@cantidad_noches,@fecha_fin,
	 @id_cliente,@id_hotel,@id_estadia,@id_clienteOrigen,1,@precio)   --arrancan habilitadas
					
GO		

drop procedure reservaAlta

execute reservaAlta '2018-06-10', 99999, 12, NULL,NULL, 4, NULL, 77777, 66666, NULL 
							
select * from ASPIRE_GDD.Reserva


--modificacion
GO  
CREATE PROCEDURE reservaModificacion @fecha_inicio date,	--asumo no pasa estado, arrancan habilitadas las reservas
	@id_codigo_reserva int,
	@id_codigo_viejo int ,
	@cantidad_noches int,
	@fecha_fin date,
	@id_cliente int, --REFERENCES ASPIRE_GDD.Cliente,
	@id_hotel int, --REFERENCES ASPIRE_GDD.Hotel,
	@id_estadia int, --REFERENCES ASPIRE_GDD.Estadia,
	@id_regimen int, --REFERENCES ASPIRE_GDD.regimen,
	@id_clienteOrigen int,
	@estado bit,
	@precio int
AS		
											
UPDATE ASPIRE_GDD.Reserva
SET fecha_inicio=@fecha_inicio,	
	id_codigo_viejo=@id_codigo_viejo,
    cantidad_noches=@cantidad_noches,
	fecha_fin=@fecha_fin,
	id_cliente=@id_cliente, --REFERENCES ASPIRE_GDD.Cliente,
	id_hotel=@id_hotel, --REFERENCES ASPIRE_GDD.Hotel,
	id_estadia=@id_estadia, --REFERENCES ASPIRE_GDD.Estadia,
	id_regimen=@id_regimen, 
	id_clienteOrigen=@id_clienteOrigen,
	estado=@estado,
	precio=@precio	
WHERE id_codigo_reserva=@id_codigo_reserva


execute reservaModificacion '2022-02-05', 96947, 99998, 11, NULL, NULL, 4, NULL, 4, 66666, 1, NULL

select * from ASPIRE_GDD.Reserva
drop procedure reservaModificacion

--baja

GO  
CREATE PROCEDURE reservaBaja @id_codigo_reserva int 
AS		
											
UPDATE ASPIRE_GDD.Reserva
SET estado=0   
WHERE id_codigo_reserva=@id_codigo_reserva


drop procedure reservaBaja
execute reservaBaja  96947 
select * from ASPIRE_GDD.Reserva

---fin bloque ABMs mati--

----------------------------------------------------- mas ABMs--------------------------------------------------------

select * from ASPIRE_GDD.usuarioBase

--ABM de usuarioBase

--alta
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE usuarioAlta  @id_usuario int, @username varchar(20),@pass varchar(30),@estado bit
AS		
											
INSERT INTO ASPIRE_GDD.usuarioBase(id_usuario,username,pass,estado)
--id_usuario se completa al ingresar username
VALUES (@id_usuario, @username, @pass,@estado) 
	
					
GO		


drop procedure usuarioAlta


execute usuarioAlta 6601,'charles35', 'charles123', 1
select * from ASPIRE_GDD.usuarioBase


--modificacion
GO 
CREATE PROCEDURE usuarioBaseModificacion  @id_usuario int, @username varchar(20),@pass varchar(30),@estado bit
AS		
											
UPDATE ASPIRE_GDD.usuarioBase
SET  username=@username,pass=@pass,estado=@estado
WHERE id_usuario=@id_usuario			
GO		

drop procedure usuarioBaseModificacion


execute usuarioBaseModificacion 6601, 'charlesAlbert','charlesA321', 0
select * from ASPIRE_GDD.usuarioBase

--baja
GO 
CREATE PROCEDURE usuarioBaseBaja @id_usuario int 
AS													
UPDATE ASPIRE_GDD.usuarioBase
SET estado=0
WHERE id_usuario=@id_usuario				


drop procedure usuarioBaseBaja
execute usuarioBaseBaja  6601 
select * from ASPIRE_GDD.usuarioBase

 
--select * into #clientesHoteles from ASPIRE_GDD.cliente
--select * from #clientesHoteles

--ABM de rol

--alta
GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE rolAlta @descripcion varchar(255), @estado bit
AS		

											
INSERT INTO ASPIRE_GDD.rol (descripcion,estado)
VALUES (@descripcion,@estado)	
-- ver razonamiento CONVERSION FECHA de abajo...					
GO		

drop procedure rolAlta

execute rolAlta 'Administrador', 1
execute rolAlta 'Recepcionista', 1
execute rolAlta 'Guest', 1
select * from ASPIRE_GDD.rol

--modificacion
GO 
CREATE PROCEDURE rolModificacion @id_rol int, @descripcion varchar(255), @estado bit
AS		
											
UPDATE ASPIRE_GDD.rol
SET descripcion=@descripcion, estado=@estado
WHERE id_rol=@id_rol
			
	

/*CONVERT(DATE,'1928-06-24 00:00:00.000',20)*/ 
drop procedure rolModificacion

execute rolModificacion 3, 'RoleNAME3',0
select * from ASPIRE_GDD.rol 

--baja
GO  
CREATE PROCEDURE rolBaja @id_rol int 
AS		
											
UPDATE ASPIRE_GDD.rol
SET estado=0 
WHERE id_rol=@id_rol 
			

drop procedure rolBaja
execute rolBaja 1  
select * from ASPIRE_GDD.rol

/*------REGISTRAR CONSUMIBLE------


select * from ASPIRE_GDD.consumible
select * into #consumible from ASPIRE_GDD.consumible
select * from #consumible

create table ASPIRE_GDD.consumible
(id_codigo iNT
descripcion varchar(50),
precio decimal)



GO  --PARA QUE SEA EL PROC la unica inst del lote
CREATE PROCEDURE registrarConsumible id_codigo int, descripcion varchar(50), precio decimal
AS		

											
INSERT INTO #consumible(descripcion,precio)
VALUES (@descripcion,@precio)	
-- ver razonamiento CONVERSION FECHA de abajo...					
GO		

/*CONVERT(DATE,'1928-06-24 00:00:00.000',20)*/ 
drop procedure registrarConsumible

execute registrarConsumible 55566688, 'Rapostiolfo','JAMES', @fecha, 'arisgarcia@gmail.com','Avenida Raona', '1220', 1, 'A',
							'ARGENTINO', 1, 0
select * from ASPIRE_GDD.cliente

*/




