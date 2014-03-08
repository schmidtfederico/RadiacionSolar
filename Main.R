source("init/init.R")
source("rad/Estimacion.R")
source("plot/Resultados.R")

###################################### Estación Laboulaye ######################################
resultados.laboulaye <- estimar.radiacion(lat=-34.13, laboulaye)
plotear.resultados(resultados.laboulaye, nombre.estacion="Laboulaye")

###################################### Estación Pergamino ######################################
resultados.pergamino <- estimar.radiacion(lat=-33.93, pergamino)
plotear.resultados(resultados.pergamino, nombre.estacion="Pergamino")

######################################## Estación Pilar ########################################
resultados.pilar <- estimar.radiacion(lat=-31.67, pilar)
plotear.resultados(resultados.pilar, nombre.estacion="Pilar")