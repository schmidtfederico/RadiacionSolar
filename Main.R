source("init/init.R")
source("rad/Estimacion.R")
source("plot/Resultados.R")

dir.create("output", showWarnings = FALSE)

###################################### Estación Laboulaye ######################################
pdf("output/Laboulaye.pdf")
resultados.laboulaye <- estimar.radiacion(lat=-34.13, laboulaye)
error.laboulaye <- calcular.errores(resultados=resultados.laboulaye)
plotear.resultados(resultados.laboulaye, nombre.estacion="Laboulaye", errores=error.laboulaye)
dev.off()

###################################### Estación Pergamino ######################################
pdf("output/Pergamino.pdf")
resultados.pergamino <- estimar.radiacion(lat=-33.93, pergamino)
error.pergamino <- calcular.errores(resultados=resultados.pergamino)
plotear.resultados(resultados.pergamino, nombre.estacion="Pergamino", errores=error.pergamino)
dev.off()

######################################## Estación Pilar ########################################
pdf("output/Pilar.pdf")
resultados.pilar <- estimar.radiacion(lat=-31.67, pilar)
error.pilar <- calcular.errores(resultados=resultados.pilar)
plotear.resultados(resultados.pilar, nombre.estacion="Pilar", errores=error.pilar)
dev.off()
