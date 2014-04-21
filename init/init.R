# Borramos los objetos del workspace.
rm(list = objects()); gc()
# Incluimos o instalamos los paquetes necesarios.
source("init/InstallPackages.R")
# Incluimos las funciones de conexión y manejo de la conexión PostgreSQL.
# source("db/PostgreSQL/PostgreSQL.r")

lat.bsas <- 
    
lat.laboulaye <- -34.13
lat.pergamino <- -33.93
lat.pilar <- -31.67
lat.bsas <- -34.58