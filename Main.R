source("init/init.R")
source('rad/data/ReadData.R')
source("rad/Estimacion.R")
source("plot/Resultados.R")
source('plot/ExtraT.R')

###################################### Estación Laboulaye ######################################
calibracion.laboulaye <- calibrar.todos.csv(lat=-34.13, laboulaye, nrows=90)
resultados.laboulaye <- estimar.radiacion(lat=-34.13, laboulaye, cal=calibracion.laboulaye)
error.laboulaye <- calcular.errores(resultados=resultados.laboulaye)

resultados.laboulaye.ajustados <- ajustar.radiacion(lat=-34.13, resultados.laboulaye)
error.laboulaye.ajustado <- calcular.errores(resultados=resultados.laboulaye.ajustados)

###################################### Estación Pergamino ######################################
calibracion.pergamino <- calibrar.todos.csv(lat=-33.93, pergamino, nrows=90)
resultados.pergamino <- estimar.radiacion(lat=-33.93, pergamino, cal=calibracion.pergamino)
error.pergamino <- calcular.errores(resultados=resultados.pergamino)

resultados.pergamino.ajustados <- ajustar.radiacion(lat=-33.93, resultados.pergamino)
error.pergamino.ajustado <- calcular.errores(resultados=resultados.pergamino.ajustados)

######################################## Estación Pilar ########################################
calibracion.pilar <- calibrar.todos.csv(lat=-31.67, pilar, nrows=90)
resultados.pilar <- estimar.radiacion(lat=-31.67, pilar, cal=calibracion.pilar)
error.pilar <- calcular.errores(resultados=resultados.pilar)

resultados.pilar.ajustados <- ajustar.radiacion(lat=-31.67, resultados.pilar)
error.pilar.ajustado <- calcular.errores(resultados=resultados.pilar.ajustados)

##################################### Estación Buenos Aires ####################################
calibracion.bsas <- calibrar.todos.csv(lat=-34.58, buenos.aires, nrows=90)
resultados.bsas <- estimar.radiacion(lat=-34.58, buenos.aires, cal=calibracion.bsas)
error.bsas <- calcular.errores(resultados=resultados.bsas)

resultados.bsas.ajustados <- ajustar.radiacion(lat=-34.58, resultados.bsas)
error.bsas.ajustado <- calcular.errores(resultados.bsas.ajustados)
