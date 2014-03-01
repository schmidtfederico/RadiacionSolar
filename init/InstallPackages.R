# Este script tiene todos los paquetes que son necesarios instalar para poder ejecutar correctamente
# el proyecto R. A su vez, contiene aclaraciones sobre los paquetes de software del sistema que es 
# necesario instalar para que todos los módulos requeridos compilen satisfactoriamente en sistemas UNIX.

options(install.packages.check.source = FALSE)
# Paquetes de acceso a bases de datos.
if(!require('DBI')) { install.packages('DBI'); require('DBI') }
if(!require('RPostgreSQL')) { install.packages('DBI'); require('RPostgreSQL') }


# Paquetes de estimación de radiación solar.
if(!require('zoo')) { install.packages('DBI'); require('zoo') }
# Requiere instalar en el SO Host el paquete: 'libnetcdf-dev'.
if(!require('ncdf')) { install.packages('DBI'); require('ncdf') }
# Requiere la instalacion de 'libudunits2-dev' en el sistema host.
if(!require('RNetCDF')) { install.packages('DBI'); require('RNetCDF') }
if(!require('sirad')) { install.packages('DBI'); require('sirad') }