source("rad/EstimacionPorTemperaturas.R")
source("rad/EstimacionPorHeliofania.R")

estimar.radiacion <- function(lat, data) {
    data = data[!is.na(data$Solrad),]
    
    BCb.data <- calibrar.bc.csv(lat=lat, data=data)
    rad.bc.data <- estimar.por.bc.csv(lat=lat, data=data, BCb=BCb.data)
    
    ha.cal.data <- calibrar.ha.csv(lat=lat, data=data)
    rad.ha.data <- estimar.por.ha.csv(lat=lat, data=data, ha.cal=ha.cal.data)
    
    ap.cal.data <- calibrar.ap.csv(lat=lat, data=data)
    rad.ap.data <- estimar.por.ap.csv(lat=lat, data=data, ap.cal=ap.cal.data)
    
    rad.mh.data <- estimar.por.mh.csv(lat=lat, data=data)
    
    resultados.data <- data.frame(rad.bc.data, rad.ha.data, rad.mh.data, rad.ap.data,
                                       data$Solrad)
    colnames(resultados.data) = c("bc", "ha", "mh", "ap", "data")
    
    return(resultados.data)
}