source("init/init.R")
source('rad/data/ReadData.R')
source("rad/Estimacion.R")
source("plot/Resultados.R")
source('plot/ExtraT.R')

porcentaje.calibracion <- 0.7

# Eliminamos las mediciones que sean sospechosas (aquellas que exceden el máximo teórico
# de radiación solar a la altura del suelo).
pilar <- filtrar.mediciones(lat=lat.pilar, pilar)
buenos.aires <- filtrar.mediciones(lat=lat.bsas, buenos.aires)
lujan <- filtrar.mediciones(lat=lat.lujan, lujan)

pilar.calibracion <- muestrear(pilar, perc=porcentaje.calibracion)
pilar.estimacion <- pilar[!pilar$Date %in% pilar.calibracion$Date,]

bsas.calibracion <- muestrear(buenos.aires, perc=porcentaje.calibracion)
bsas.estimacion <- buenos.aires[!buenos.aires$Date %in% bsas.calibracion$Date,]

lujan.calibracion <- muestrear(lujan, perc=porcentaje.calibracion)
lujan.estimacion <- lujan[!lujan$Date %in% lujan.calibracion$Date,]

source('rf/RandomForest.R')

######################################## Estación Pilar ########################################
calibracion.pilar <- calibrar.todos.csv(lat=lat.pilar, pilar.calibracion)
resultados.pilar <- estimar.radiacion(lat=lat.pilar, pilar.estimacion, cal=calibracion.pilar)
error.pilar <- calcular.errores(resultados=resultados.pilar)

resultados.pilar.ajustados <- ajustar.radiacion(lat=lat.pilar, resultados.pilar)
error.pilar.ajustado <- calcular.errores(resultados=resultados.pilar.ajustados)

##################################### Estación Buenos Aires ####################################
calibracion.bsas <- calibrar.todos.csv(lat=lat.bsas, bsas.calibracion)
resultados.bsas <- estimar.radiacion(lat=lat.bsas, bsas.estimacion, cal=calibracion.bsas)
error.bsas <- calcular.errores(resultados=resultados.bsas)

resultados.bsas.ajustados <- ajustar.radiacion(lat=lat.bsas, resultados.bsas)
error.bsas.ajustado <- calcular.errores(resultados.bsas.ajustados)

################################## Red Solarimétrica de Luján ##################################
calibracion.lujan <- calibrar.todos.csv(lat=lat.lujan, lujan.calibracion)
resultados.lujan <- estimar.radiacion(lat=lat.lujan, lujan.estimacion, cal=calibracion.lujan)
error.lujan <- calcular.errores(resultados=resultados.lujan)

resultados.lujan.ajustados <- ajustar.radiacion(lat=lat.lujan, resultados.lujan)
error.lujan.ajustado <- calcular.errores(resultados.lujan.ajustados)