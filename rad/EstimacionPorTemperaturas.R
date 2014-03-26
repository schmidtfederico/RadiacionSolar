source("rad/Calibracion.R")

# Todas las funciones de estimacón terminadas en ".csv" toman como entrada un campo
# data que debe ser un Data Frame con las cabeceras:
#  ___________________________________________________________________
# |  Date  |  Tmax  |  Tmin  |  Precip  |  Sunabs  |  Solrad  |  Nub  |
#  ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Bristow-Campbell
estimar.por.bc.csv <- function (lat, data, BCb) {
    return(bc(days=as.Date(data$Date), lat=lat, BCb=BCb, Tmax=data$Tmax, Tmin=data$Tmin, tal=tal))
}

# Hargreaves
estimar.por.ha.csv <- function (lat, data, ha.cal) {
    return(ha(days=as.Date(data$Date), lat=lat, Tmax=data$Tmax, Tmin=data$Tmin, A=ha.cal[[1]], B=ha.cal[[2]]))
}

# Mahmood-Hubbard
estimar.por.mh.csv <- function(lat, data){
    return(mh(days=as.Date(data$Date), lat=lat, Tmax=data$Tmax, Tmin=data$Tmin))
}

# Supit-Van Kappel
estimar.por.su.csv <- function(lat, data, su.cal) {
    data.not.na <- data[!is.na(data$Nub),]
    if(nrow(data.not.na) == 0) {
        return(NA)
    }
    return(su(lat=lat, days=as.Date(data$Date), A=su.cal[[1]], B=su.cal[[2]], C=su.cal[[3]], tmax=data$Tmax, tmin=data$Tmin, CC=data$Nub))
}

# Las funciones a continuación toman como entrada un registro de la DB de Clima de la estación
# y un resultset de la DB de Clima con las mediciones diarias.

# Bristow-Campbell
estimar.por.bc <- function(estacion, result){
    # Calculamos el porcentaje de días que llovió en el conjunto de registros.
    porcentaje.lluvias <- length(result$prcp[result$prcp > 0]) / length(result$prcp)
    
    fechas <- as.Date(result$fecha)
    
    # Calibramos el modelo de Bristow-Campbell y obtenemos el coeficiente 'B'.
    BCb <- bcauto(lat=estacion$lat_dec, lon=estacion$lon_dec, days=fechas, Tmax=result$tmax, Tmin=result$tmin, tal=tal, perce=porcentaje.lluvias)
    # Corremos el modelo de Bristow-Campbell y obtenemos la radiación solar.
    return(bc(days=fechas, lat=estacion$lat_dec, BCb=BCb, Tmax=result$tmax, Tmin=result$tmin, tal=tal))
}

# Hargreaves
estimar.por.ha <- function(estacion, result) {
    # Calculamos el porcentaje de días que llovió en el conjunto de registros.
    porcentaje.lluvias <- length(result$prcp[result$prcp > 0]) / length(result$prcp)
    
    fechas <- as.Date(result$fecha)
    
    # Calculamos los coeficientes 'A' y 'B' de Hargreaves.
    hvalues <- hauto(lat=estacion$lat_dec, lon=estacion$lon_dec, days=fechas, Tmax=result$tmax, Tmin=result$tmin, tal=tal, perce=porcentaje.lluvias)
    return(ha(days=fechas, lat=estacion$lat_dec, A=hvalues[[1]], B=hvalues[[2]], Tmax=result$tmax, Tmin=result$tmin))
}

# Mahmood-Hubbard
estimar.por.mh <- function(estacion, result) {
    return(mh(days=fechas, lat=estacion$lat_dec, Tmax=result$tmax, Tmin=result$tmin))
}


