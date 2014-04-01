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
calibracion.laboulaye <- calibrar.por.mes.csv(lat=-34.13, laboulaye)
resultados.laboulaye <- estimar.por.mes(lat=-34.13, laboulaye, cal=calibracion.laboulaye)
error.laboulaye <- calcular.errores(resultados=resultados.laboulaye)

resultados.laboulaye.ajustados <- ajustar.radiacion(lat=-34.13, resultados.laboulaye)
error.laboulaye.ajustado <- calcular.errores(resultados=resultados.laboulaye.ajustados)

###################################### Estación Pergamino ######################################
calibracion.pergamino <- calibrar.por.mes.csv(lat=-33.93, pergamino)
resultados.pergamino <- estimar.por.mes(lat=-33.93, pergamino, cal=calibracion.pergamino)
error.pergamino <- calcular.errores(resultados=resultados.pergamino)

resultados.pergamino.ajustados <- ajustar.radiacion(lat=-33.93, resultados.pergamino)
error.pergamino.ajustado <- calcular.errores(resultados=resultados.pergamino.ajustados)

######################################## Estación Pilar ########################################
calibracion.pilar <- calibrar.por.mes.csv(lat=-31.67, pilar)
resultados.pilar <- estimar.por.mes(lat=-31.67, pilar, cal=calibracion.pilar)
error.pilar <- calcular.errores(resultados=resultados.pilar)

resultados.pilar.ajustados <- ajustar.radiacion(lat=-31.67, resultados.pilar)
error.pilar.ajustado <- calcular.errores(resultados=resultados.pilar.ajustados)

##################################### Estación Buenos Aires ####################################
calibracion.bsas <- calibrar.por.mes.csv(lat=-34.58, buenos.aires)
resultados.bsas <- estimar.por.mes(lat=-34.58, buenos.aires, cal=calibracion.bsas)
error.bsas <- calcular.errores(resultados=resultados.bsas)

resultados.bsas.ajustados <- ajustar.radiacion(lat=-34.58, resultados.bsas)
error.bsas.ajustado <- calcular.errores(resultados.bsas.ajustados)
