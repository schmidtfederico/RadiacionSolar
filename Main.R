source("init/init.R")
source("rad/EstimacionPorTemperaturas.R")

###### BRISTOW-CAMPBELL ######
BCb.laboulaye <- calibrar.bc.csv(lat=-34.13, data=laboulaye)
rad.bc.laboulaye <- estimar.por.bc.csv(lat=-34.13, data=laboulaye, BCb=BCb.laboulaye)

resultados.laboulaye <- data.frame(rad.bc.laboulaye, laboulaye$Solrad)