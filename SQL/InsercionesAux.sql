


use GD1c2018
Go

insert ASPIRE_GDD.id_Funcion values (1,'ABM de ROL',1)
--insert ASPIRE_GDD.id_Funcion values ('Login',1)
insert ASPIRE_GDD.id_Funcion values (2,'ABM de Usuario',1)
insert ASPIRE_GDD.id_Funcion values (3,'ABM de Cliente',1)
insert ASPIRE_GDD.id_Funcion values (4,'ABM de Hotel',1)
insert ASPIRE_GDD.id_Funcion values (5,'ABM de Habitacion',1)
insert ASPIRE_GDD.id_Funcion values (6,'ABM de Regimen de Estadia',1)
insert ASPIRE_GDD.id_Funcion values (7,'Generar o Modificar Reserva',1)
insert ASPIRE_GDD.id_Funcion values (8,'Registrar estadia',1)
insert ASPIRE_GDD.id_Funcion values (9,'Registrar consumibles',1)
insert ASPIRE_GDD.id_Funcion values (10,'Facturar estadia',1)
insert ASPIRE_GDD.id_Funcion values (11,'Listado estadistico',1)
insert ASPIRE_GDD.id_Funcion values (12,'Cancelar reserva',1)
Go
select * from ASPIRE_GDD.id_Funcion
Go

select * from ASPIRE_GDD.rol
Go

select * from ASPIRE_GDD.rolX_Usuario
Go

alter table ASPIRE_GDD.id_Funcion alter column estado bit
insert ASPIRE_GDD.rol values (1,'Administrador',cast(1 as bit))
insert ASPIRE_GDD.rol values (2,'Guest',cast(1 as bit))

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