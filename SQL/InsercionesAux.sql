


use GD1c2018
Go

insert ASPIRE_GDD.id_Funcion values ('ABM de ROL',1)
--insert ASPIRE_GDD.id_Funcion values ('Login',1)
insert ASPIRE_GDD.id_Funcion values ('ABM de Usuario',1)
insert ASPIRE_GDD.id_Funcion values ('ABM de Cliente',1)
insert ASPIRE_GDD.id_Funcion values ('ABM de Hotel',1)
insert ASPIRE_GDD.id_Funcion values ('ABM de Habitacion',1)
insert ASPIRE_GDD.id_Funcion values ('ABM de Regimen de Estadia',1)
insert ASPIRE_GDD.id_Funcion values ('Generar o Modificar Reserva',1)
insert ASPIRE_GDD.id_Funcion values ('Registrar estadia',1)
insert ASPIRE_GDD.id_Funcion values ('Registrar consumibles',1)
insert ASPIRE_GDD.id_Funcion values ('Facturar estadia',1)
insert ASPIRE_GDD.id_Funcion values ('Listado estadistico',1)
insert ASPIRE_GDD.id_Funcion values ('Cancelar reserva',1)
Go
select * from ASPIRE_GDD.id_Funcion
Go

select * from ASPIRE_GDD.rol
Go

select * from ASPIRE_GDD.rolX_Usuario
Go

alter table ASPIRE_GDD.id_Funcion alter column estado bit
insert ASPIRE_GDD.rol values ('Administrador',1)



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
insert ASPIRE_GDD.funcionesX_Rol values (2,12)

select * from ASPIRE_GDD.usuarioBase
Go


insert ASPIRE_GDD.usuarioBase values ('admin','w23e',null)
insert ASPIRE_GDD.rolX_Usuario values(1,1)

select * from ASPIRE_GDD.usuarioBase u 
join ASPIRE_GDD.rolX_Usuario rxu on (u.id_usuario= rxu.id_usuario)
join ASPIRE_GDD.rol r on (r.id_rol= rxu.id_rol)
join ASPIRE_GDD.funcionesX_Rol fxr on (fxr.id_rol= r.id_rol)
join ASPIRE_GDD.id_Funcion f on (f.id_funcion= fxr.id_funcion)
order by u.id_usuario

/* Procedure */
create procedure mostrarHab
as
select * from ASPIRE_GDD.Hab
Go

select * from 


