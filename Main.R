source("init/init.R")
source("rad/Estimacion.R")
source("plot/Resultados.R")


###################################### Estación Laboulaye ######################################
resultados.laboulaye <- estimar.radiacion(lat=-34.13, laboulaye)
error.laboulaye <- calcular.errores(resultados=resultados.laboulaye)
#plotear.resultados.todos(resultados.laboulaye, errores=error.laboulaye)

###################################### Estación Pergamino ######################################
resultados.pergamino <- estimar.radiacion(lat=-33.93, pergamino)
error.pergamino <- calcular.errores(resultados=resultados.pergamino)
#plotear.resultados.todos(resultados.pergamino, errores=error.pergamino)

######################################## Estación Pilar ########################################
resultados.pilar <- estimar.radiacion(lat=-31.67, pilar)
error.pilar <- calcular.errores(resultados=resultados.pilar)
#plotear.resultados.todos(resultados.pilar, errores=error.pilar)
