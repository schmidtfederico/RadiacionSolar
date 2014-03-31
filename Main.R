source("init/init.R")
source('rad/data/ReadData.R')
source("rad/Estimacion.R")
source("plot/Resultados.R")
source('plot/ExtraT.R')

# Eliminamos las mediciones que sean sospechosas (aquellas que exceden el máximo teórico
# de radiación solar a la altura del suelo).
laboulaye <- filtrar.mediciones(lat=-34.13, laboulaye)
pergamino <- filtrar.mediciones(lat=-33.93, pergamino)
pilar <- filtrar.mediciones(lat=-31.67, pilar)
buenos.aires <- filtrar.mediciones(lat=-34.58, buenos.aires)

porcentaje.calibracion <- 0.1

###################################### Estación Laboulaye ######################################
calibracion.laboulaye <- calibrar.todos.random.csv(lat=-34.13, laboulaye, perc=porcentaje.calibracion)
resultados.laboulaye <- estimar.radiacion(lat=-34.13, laboulaye, cal=calibracion.laboulaye)
error.laboulaye <- calcular.errores(resultados=resultados.laboulaye)

resultados.laboulaye.ajustados <- ajustar.radiacion(lat=-34.13, resultados.laboulaye)
error.laboulaye.ajustado <- calcular.errores(resultados=resultados.laboulaye.ajustados)

###################################### Estación Pergamino ######################################
calibracion.pergamino <- calibrar.todos.random.csv(lat=-33.93, pergamino, perc=porcentaje.calibracion)
resultados.pergamino <- estimar.radiacion(lat=-33.93, pergamino, cal=calibracion.pergamino)
error.pergamino <- calcular.errores(resultados=resultados.pergamino)

resultados.pergamino.ajustados <- ajustar.radiacion(lat=-33.93, resultados.pergamino)
error.pergamino.ajustado <- calcular.errores(resultados=resultados.pergamino.ajustados)

######################################## Estación Pilar ########################################
calibracion.pilar <- calibrar.todos.random.csv(lat=-31.67, pilar, perc=porcentaje.calibracion)
resultados.pilar <- estimar.radiacion(lat=-31.67, pilar, cal=calibracion.pilar)
error.pilar <- calcular.errores(resultados=resultados.pilar)

resultados.pilar.ajustados <- ajustar.radiacion(lat=-31.67, resultados.pilar)
error.pilar.ajustado <- calcular.errores(resultados=resultados.pilar.ajustados)

##################################### Estación Buenos Aires ####################################
calibracion.bsas <- calibrar.todos.random.csv(lat=-34.58, buenos.aires, perc=porcentaje.calibracion)
resultados.bsas <- estimar.radiacion(lat=-34.58, buenos.aires, cal=calibracion.bsas)
error.bsas <- calcular.errores(resultados=resultados.bsas)

resultados.bsas.ajustados <- ajustar.radiacion(lat=-34.58, resultados.bsas)
error.bsas.ajustado <- calcular.errores(resultados.bsas.ajustados)
