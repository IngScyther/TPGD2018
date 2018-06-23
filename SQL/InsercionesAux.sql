


use GD1c2018
Go
--1
insert ASPIRE_GDD.id_Funcion values ('ABM de ROL',1)
--insert ASPIRE_GDD.id_Funcion values ('Login',1)
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
--insert ASPIRE_GDD.id_Funcion values ('Facturar estadia',1)
--11
insert ASPIRE_GDD.id_Funcion values ('Listado estadistico',1)

Go
select * from ASPIRE_GDD.id_Funcion
Go

select * from ASPIRE_GDD.rol
Go

select * from ASPIRE_GDD.rolX_Usuario
Go

insert ASPIRE_GDD.rolX_Usuario values (1,1)

alter table ASPIRE_GDD.id_Funcion alter column estado bit

insert ASPIRE_GDD.rol values ('Administrador',1)
insert ASPIRE_GDD.rol values ('Guest',1)


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

insert ASPIRE_GDD.funcionesX_Rol values (2,7)
insert ASPIRE_GDD.funcionesX_Rol values (2,8)

insert ASPIRE_GDD.funcionesX_Rol values (3,6)
insert ASPIRE_GDD.funcionesX_Rol values (3,7)
insert ASPIRE_GDD.funcionesX_Rol values (3,8)
insert ASPIRE_GDD.funcionesX_Rol values (3,9)
select * from ASPIRE_GDD.usuarioBase
Go


insert ASPIRE_GDD.usuarioBase values ('admin','w23e',1,null,12345678,'Flavio@Hotel.org',4444444,'Zapata',getdate())
insert ASPIRE_GDD.rolX_Usuario values(1,1)

select u.username, u.pass, u.dni, u.mail, u.telefono, u.direccion, u.fecha_nacimiento,r.id_rol,r.descripcion,f.id_funcion,f.descripcion_func,h.id_hotel ,h.calle from ASPIRE_GDD.usuarioBase u
--select * from ASPIRE_GDD.usuarioBase u 
join ASPIRE_GDD.rolX_Usuario rxu on (u.id_usuario= rxu.id_usuario)
join ASPIRE_GDD.rol r on (r.id_rol= rxu.id_rol)
join ASPIRE_GDD.funcionesX_Rol fxr on (fxr.id_rol= r.id_rol)
join ASPIRE_GDD.id_Funcion f on (f.id_funcion= fxr.id_funcion)
join ASPIRE_GDD.HotelxEmpleado HxE on (u.id_usuario = HxE.id_usuario)
join ASPIRE_GDD.Hotel h on (h.id_hotel=HxE.id_Hotel)
where h.id_hotel = 1 and f.id_funcion = 1
order by u.id_usuario

/* Procedure */
create procedure mostrarHab
as
select * from ASPIRE_GDD.Hab
Go

select * from ASPIRE_GDD.HotelxEmpleado
Go

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

drop procedure mostrarFuncionesGuest
Go
create procedure mostrarFuncionesGuest
as
select f.descripcion_func  from ASPIRE_GDD.rol r
join ASPIRE_GDD.funcionesX_Rol fxr on (r.id_rol = fxr.id_rol)
join ASPIRE_GDD.id_Funcion f on (f.id_funcion = fxr.id_funcion)
where r.descripcion = 'Guest'
Go
execute mostrarFuncionesGuest


select * from ASPIRE_GDD.usuarioBase
select * from ASPIRE_GDD.rol
select * from ASPIRE_GDD.Hotel

insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,1)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,2)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,3)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,4)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,5)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,6)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,7)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,8)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,9)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,10)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,11)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,12)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,13)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,14)
insert ASPIRE_GDD.USUARIOxROLxHOTEL values (1,1,15)