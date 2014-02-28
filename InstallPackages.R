# Este script tiene todos los paquetes que son necesarios instalar para poder ejecutar correctamente
# el proyecto R. A su vez, contiene aclaraciones sobre los paquetes de software del sistema que es 
# necesario instalar para que todos los módulos requeridos compilen satisfactoriamente en sistemas UNIX.

options(install.packages.check.source = FALSE)
# Paquetes de acceso a bases de datos.
install.packages('DBI')
install.packages('RPostgreSQL')

# Paquetes de estimación de radiación solar.
install.packages('zoo')
# Requiere instalar en el SO Host el paquete: 'libnetcdf-dev'.
install.packages('ncdf')
# Requiere la instalacion de 'libudunits2-dev' en el sistema host.
install.packages('RNetCDF')
install.packages('sirad')