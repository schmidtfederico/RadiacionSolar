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

###################################### Estación Laboulaye ######################################
laboulaye.subset1 <- laboulaye[sample(x=1:nrow(laboulaye), size=(nrow(laboulaye)*0.5), replace=FALSE),]
laboulaye.subset1 <- laboulaye.subset1[order(laboulaye.subset1$Date),]
laboulaye.subset2 <- laboulaye[!laboulaye$Date %in% laboulaye.subset1$Date,]

calibracion.laboulaye <- calibrar.por.mes.csv(lat=-34.13, laboulaye.subset1)
resultados.laboulaye <- estimar.por.mes(lat=-34.13, laboulaye.subset2, cal=calibracion.laboulaye)
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
bsas.subset1 <- buenos.aires[sample(x=1:nrow(buenos.aires), size=(nrow(buenos.aires)*0.5), replace=FALSE),]
bsas.subset1 <- bsas.subset1[order(bsas.subset1$Date),]
bsas.subset2 <- buenos.aires[!buenos.aires$Date %in% bsas.subset1$Date,]

calibracion.bsas <- calibrar.por.mes.csv(lat=-34.58, bsas.subset1)
resultados.bsas <- estimar.por.mes(lat=-34.58, bsas.subset2, cal=calibracion.bsas)
error.bsas <- calcular.errores(resultados=resultados.bsas)

resultados.bsas.ajustados <- ajustar.radiacion(lat=-34.58, resultados.bsas)
error.bsas.ajustado <- calcular.errores(resultados.bsas.ajustados)
