source("init/init.R")
source("rad/EstimacionPorTemperaturas.R")
source("rad/EstimacionPorHeliofania.R")

###### BRISTOW-CAMPBELL ######
data = laboulaye[!is.na(laboulaye$Solrad),]

BCb.laboulaye <- calibrar.bc.csv(lat=-34.13, data=laboulaye)
rad.bc.laboulaye <- estimar.por.bc.csv(lat=-34.13, data=data, BCb=BCb.laboulaye)

ap.cal.laboulaye <- calibrar.ap.csv(lat=-34.13, data=laboulaye)
rad.ap.laboulaye <- estimar.por.ap.csv(lat=-34.13, data=data, ap.cal=ap.cal.laboulaye)

resultados.laboulaye <- data.frame(rad.bc.laboulaye, rad.ap.laboulaye, data$Solrad)