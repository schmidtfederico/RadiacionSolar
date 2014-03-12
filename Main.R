source("init/init.R")
source("rad/Estimacion.R")
source("plot/Resultados.R")

dir.create("output", showWarnings = FALSE)

###################################### Estación Laboulaye ######################################
pdf("output/Laboulaye.pdf")
resultados.laboulaye <- estimar.radiacion(lat=-34.13, laboulaye)
plotear.resultados(resultados.laboulaye, nombre.estacion="Laboulaye")
dev.off()

###################################### Estación Pergamino ######################################
pdf("output/Pergamino.pdf")
resultados.pergamino <- estimar.radiacion(lat=-33.93, pergamino)
plotear.resultados(resultados.pergamino, nombre.estacion="Pergamino")
dev.off()

######################################## Estación Pilar ########################################
pdf("output/Pilar.pdf")
resultados.pilar <- estimar.radiacion(lat=-31.67, pilar)
plotear.resultados(resultados.pilar, nombre.estacion="Pilar")
dev.off()
