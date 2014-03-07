source("rad/Calibracion.R")

# Transmisividad atmosférica.
tal=0.77

BCb.avg <- calibrar.bc.avg()

estimar.por.bc <- function(estacion, result, fechas){
    # Calculamos el porcentaje de días que llovió en el conjunto de registros.
    porcentaje.lluvias <- length(result$prcp[result$prcp > 0]) / length(result$prcp)
    
    # Calibramos el modelo de Bristow-Campbell y obtenemos el coeficiente 'B'.
    BCb <- bcauto(lat=estacion$lat_dec, lon=estacion$lon_dec, days=fechas, Tmax=result$tmax, Tmin=result$tmin, tal=tal, perce=porcentaje.lluvias)
    # Corremos el modelo de Bristow-Campbell y obtenemos la radiación solar.
    return(bc(days=fechas, lat=estacion$lat_dec, BCb=BCb, Tmax=result$tmax, Tmin=result$tmin, tal=tal))
}

estimar.por.bc.csv <- function (lat, data, BCb=NULL) {
    if(is.null(BCb)){
        BCb <- BCb.avg
    }
    return(bc(days=as.Date(data$Date), lat=lat, BCb=BCb, Tmax=data$Tmax, Tmin=data$Tmin, tal=tal))
}

estimar.por.ha <- function(estacion, result, fechas) {
    # Calculamos el porcentaje de días que llovió en el conjunto de registros.
    porcentaje.lluvias <- length(result$prcp[result$prcp > 0]) / length(result$prcp)
    # Calculamos los coeficientes 'A' y 'B' de Hargreaves.
    hvalues <- hauto(lat=estacion$lat_dec, lon=estacion$lon_dec, days=fechas, Tmax=result$tmax, Tmin=result$tmin, tal=tal, perce=porcentaje.lluvias)
    
    return(ha(days=fechas, lat=estacion$lat_dec, A=hvalues[[1]], B=hvalues[[2]], Tmax=result$tmax, Tmin=result$tmin))
}

estimar.por.mh <- function(estacion, result, fechas) {
    return(mh(days=fechas, lat=estacion$lat_dec, Tmax=result$tmax, Tmin=result$tmin))
}

