# Borramos los objetos del workspace.
rm(list = objects()); gc()
# Incluimos o instalamos los paquetes necesarios.
source("init/InstallPackages.R")
# Incluimos las funciones de conexión y manejo de la conexión PostgreSQL.
# source("db/PostgreSQL/PostgreSQL.r")