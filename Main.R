source("init/init.R")
source("rad/Estimacion.R")
source("plot/Resultados.R")
source('plot/ExtraT.R')

###################################### Estación Laboulaye ######################################
resultados.laboulaye <- estimar.radiacion(lat=-34.13, laboulaye)
error.laboulaye <- calcular.errores(resultados=resultados.laboulaye)

resultados.laboulaye.ajustados <- ajustar.radiacion(lat=-34.13, resultados.laboulaye)
error.laboulaye.ajustado <- calcular.errores(resultados=resultados.laboulaye.ajustados)
#plotear.resultados.todos(resultados.laboulaye, errores=error.laboulaye)

###################################### Estación Pergamino ######################################
resultados.pergamino <- estimar.radiacion(lat=-33.93, pergamino)
error.pergamino <- calcular.errores(resultados=resultados.pergamino)

resultados.pergamino.ajustados <- ajustar.radiacion(lat=-33.93, resultados.pergamino)
error.pergamino.ajustado <- calcular.errores(resultados=resultados.pergamino.ajustados)
#plotear.resultados.todos(resultados.pergamino, errores=error.pergamino)

######################################## Estación Pilar ########################################
resultados.pilar <- estimar.radiacion(lat=-31.67, pilar)
error.pilar <- calcular.errores(resultados=resultados.pilar)

resultados.pilar.ajustados <- ajustar.radiacion(lat=-31.67, resultados.pilar)
error.pilar.ajustado <- calcular.errores(resultados=resultados.pilar.ajustados)
#plotear.resultados.todos(resultados.pilar, errores=error.pilar)
