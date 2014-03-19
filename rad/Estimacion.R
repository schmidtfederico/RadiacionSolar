source("rad/EstimacionPorTemperaturas.R")
source("rad/EstimacionPorHeliofania.R")

# Dado una latitud y un archivo CSV con la estructura:
#  ___________________________________________________________
# |  Date  |  Tmax  |  Tmin  |  Precip  |  Sunabs  |  Solrad  |
#  ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
# calibra y estima la radiación por los distintos métodos.
calibrar.metodos <- function(lat, data, offset=1, nrows=NA) {
    if(is.na(nrows)) {
        nrows <- length(data)
    }
    data <- data[offset:nrows]
    
    # TODO: terminar de implementar para poder probar de calibrar con una fracción de los datos.
}

estimar.radiacion <- function(lat, data) {
    # Filtramos los datos para eliminar de los mismos los registros donde la
    # medición de la radiación es nula ya que no nos sirven para calibrar
    # ni para después comparar la performance del método de estimación.
    data = data[!is.na(data$Solrad),]
    
    # Calibramos y estimamos por cada método.
    # Bristow-Campbell
    BCb.data <- calibrar.bc.csv(lat=lat, data=data)
    rad.bc.data <- estimar.por.bc.csv(lat=lat, data=data, BCb=BCb.data)
    
    # Hargreaves
    ha.cal.data <- calibrar.ha.csv(lat=lat, data=data)
    rad.ha.data <- estimar.por.ha.csv(lat=lat, data=data, ha.cal=ha.cal.data)
    
    # Angstrom-Prescott
    ap.cal.data <- calibrar.ap.csv(lat=lat, data=data)
    rad.ap.data <- estimar.por.ap.csv(lat=lat, data=data, ap.cal=ap.cal.data)
    
    # Mahmood-Hubbard
    rad.mh.data <- estimar.por.mh.csv(lat=lat, data=data)
    
    # Devolvemos un Data Frame donde el nombre del campo es la abreviación del nombre
    # del método y agregamos los valores medidos de la radiación como el campo 'data'.
    resultados.data <- data.frame(data$Date, rad.bc.data, rad.ha.data, rad.mh.data, rad.ap.data,
                                       data$Solrad)
    colnames(resultados.data) = c("Date", "bc", "ha", "mh", "ap", "data")
    
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
    # Angstrom-Prescott
    resultados$ap <- mapply(min, resultados$ap, maxRad)
    
    return(resultados)
}