source("rad/EstimacionPorTemperaturas.R")
source("rad/EstimacionPorHeliofania.R")

# Dado una latitud y un archivo CSV con la estructura:
#  ___________________________________________________________________
# |  Date  |  Tmax  |  Tmin  |  Precip  |  Sunabs  |  Solrad  |  Nub  |
#  ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
# calibra y estima la radiación por los distintos métodos.
estimar.radiacion <- function(lat, data, su=FALSE) {    
    # Calibramos y estimamos por cada método.
    # Bristow-Campbell
    BCb.data <- calibrar.bc.csv(lat=lat, data=data)
    rad.bc.data <- estimar.por.bc.csv(lat=lat, data=data, BCb=BCb.data)
    
    # Hargreaves
    ha.cal.data <- calibrar.ha.csv(lat=lat, data=data)
    rad.ha.data <- estimar.por.ha.csv(lat=lat, data=data, ha.cal=ha.cal.data)
    
    # Supit-Van Kappel
    su.cal.data <- calibrar.su.csv(lat=lat, data=data)
    rad.su.data <- estimar.por.su.csv(lat=lat, data=data, su.cal=su.cal.data)
    
    # Angstrom-Prescott
    ap.cal.data <- calibrar.ap.csv(lat=lat, data=data)
    rad.ap.data <- estimar.por.ap.csv(lat=lat, data=data, ap.cal=ap.cal.data)
    
    # Mahmood-Hubbard
    rad.mh.data <- estimar.por.mh.csv(lat=lat, data=data)
    
    # Devolvemos un Data Frame donde el nombre del campo es la abreviación del nombre
    # del método y agregamos los valores medidos de la radiación como el campo 'data'.
    resultados.data <- data.frame(data$Date, rad.bc.data, rad.ha.data, rad.mh.data, rad.su.data, rad.ap.data,
                                       data$Solrad)
    colnames(resultados.data) = c("Date", "bc", "ha", "mh", "su", "ap", "data")
    
    return(resultados.data)
}

ajustar.radiacion <- function(lat, resultados) {
    extraT <- extrat(i=1:366, lat=radians(lat))$ExtraTerrestrialSolarRadiationDaily
    
    maxRad <- extraT[dayOfYear(resultados$Date)]*tal
    
    # Bristow-Campbell
    resultados$bc <- mapply(min, resultados$bc, maxRad)
    # Hargreaves
    resultados$ha <- mapply(min, resultados$ha, maxRad)
    # Mahmood-Hubbard
    resultados$mh <- mapply(min, resultados$mh, maxRad)
    # Supit-Van Kapel
    resultados$su <- mapply(min, resultados$su, maxRad)
    # Angstrom-Prescott
    resultados$ap <- mapply(min, resultados$ap, maxRad)
    
    return(resultados)
}