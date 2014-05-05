source("init/init.R")
source('rad/data/ReadData.R')
source("rad/Estimacion.R")
source("plot/Resultados.R")
source('plot/ExtraT.R')

# Eliminamos las mediciones que sean sospechosas (aquellas que exceden el máximo teórico
# de radiación solar a la altura del suelo).
pilar <- filtrar.mediciones(lat=lat.pilar, pilar)
buenos.aires <- filtrar.mediciones(lat=lat.bsas, buenos.aires)

######################################## Estación Pilar ########################################
calibracion.pilar <- calibrar.por.mes.csv(lat=lat.pilar, pilar)
resultados.pilar <- estimar.por.mes(lat=lat.pilar, pilar, cal=calibracion.pilar)
error.pilar <- calcular.errores(resultados=resultados.pilar)

resultados.pilar.ajustados <- ajustar.radiacion(lat=lat.pilar, resultados.pilar)
error.pilar.ajustado <- calcular.errores(resultados=resultados.pilar.ajustados)

##################################### Estación Buenos Aires ####################################
bsas.subset1 <- buenos.aires[sample(x=1:nrow(buenos.aires), size=(nrow(buenos.aires)*0.5), replace=FALSE),]
bsas.subset1 <- bsas.subset1[order(bsas.subset1$Date),]
bsas.subset2 <- buenos.aires[!buenos.aires$Date %in% bsas.subset1$Date,]

calibracion.bsas <- calibrar.por.mes.csv(lat=lat.bsas, bsas.subset1)
resultados.bsas <- estimar.por.mes(lat=lat.bsas, bsas.subset2, cal=calibracion.bsas)
error.bsas <- calcular.errores(resultados=resultados.bsas)

resultados.bsas.ajustados <- ajustar.radiacion(lat=lat.bsas, resultados.bsas)
error.bsas.ajustado <- calcular.errores(resultados.bsas.ajustados)