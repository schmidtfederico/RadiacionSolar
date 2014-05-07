# Todas las funciones de calibración terminadas en ".csv" toman como entrada un campo
# data que debe ser un Data Frame con las cabeceras:
#  ___________________________________________________________________
# |  Date  |  Tmax  |  Tmin  |  Precip  |  Sunabs  |  Solrad  |  Nub  |
#  ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Si no suprimimos estos warnings, cuando se divide un valor NA dentro de la sqrt
# del método, nos avisa y no es algo inesperado que suceda porque hay estaciones
# para las cuales no se cuenta con datos de nubosidad.
suppressWarnings(sucal)
suppressWarnings(su)

# Transmisividad atmosférica.
tal=0.8

calibrar.por.mes.csv <- function(lat, data) {
    calibracion <- data.frame(row.names=c('BCb', 'Ha', 'Hb', 'Sa', 'Sb', 'Sc', 'APa', 'APb'))
    for(mes in 1:12) {
        data.mes <- data[as.numeric(strftime(data$Date, "%m")) == mes,]
        if(nrow(data.mes) > 26) {
            calibracion.mes <- calibrar.todos.random.csv(lat=lat, data=data.mes, perc=1)
        } else if(nrow(data.mes) > 10) {
            calibracion.mes <- calibrar.todos.random.csv(lat=lat, data=data.mes, perc=1)
        } else {
            calibracion.mes <- calibrar.todos.random.csv(lat=lat, data=data.mes, perc=1)
        }
        calibracion[, as.character(mes)] <- calibracion.mes
    }
    return(calibracion)
}

# Calibra todos los métodos y devuelve un vector con los parámetros de cálculo
# de cada método.
calibrar.todos.csv <- function(lat, data, offset=0, nrows=NA) {
    BCb <- calibrar.bc.csv(lat=lat, data=data, offset=offset, nrows=nrows)
    ha.cal <- calibrar.ha.csv(lat=lat, data=data, offset=offset, nrows=nrows)
    su.cal <- calibrar.su.csv(lat=lat, data=data, offset=offset, nrows=nrows)
    ap.cal <- calibrar.ap.csv(lat=lat, data=data, offset=offset, nrows=nrows)
    
    cal <- c(BCb, ha.cal[1:2], su.cal[1:3], ap.cal[1:2])   
    names(cal) <- c('BCb', 'Ha', 'Hb', 'Sa', 'Sb', 'Sc', 'APa', 'APb')
    
    return(cal)
}

calibrar.todos.random.csv <- function(lat, data, perc=0.5) {
    # Muestreamos las observaciones para obtener una porcentaje de
    # todos los datos disponibles.
    row.numbers <- sample(x=1:nrow(data), size=(nrow(data)*perc), replace=FALSE)
    cal.data <- data[row.numbers,]
    
    return(calibrar.todos.csv(lat=lat, data=cal.data))
}

# Bristow-Campbell
calibrar.bc.csv <- function(lat, data, offset=0, nrows=NA) {
    data <- data.subset(data, offset, nrows)
    return(bccal(lat=lat, days=as.Date(data$Date), rad_mea=data$Solrad, Tmax=data$Tmax, Tmin=data$Tmin, tal=tal))
}

# Hargreaves
calibrar.ha.csv <- function(lat, data, offset=0, nrows=NA) {
    data <- data.subset(data, offset, nrows)
    return(hacal(lat=lat, days=as.Date(data$Date), rad_mea=data$Solrad, tmax=data$Tmax, tmin=data$Tmin))
}

# Angstrom-Prescott
calibrar.ap.csv <- function(lat, data, offset=0, nrows=NA) {
    # Filtramos las filas donde la heliofanía esté ausente.
    data <- data[!is.na(data$Sunabs),]
    data <- data.subset(data, offset, nrows)
    return(apcal(lat=lat, days=as.Date(data$Date), rad_mea=data$Solrad, SSD=data$Sunabs))
}

calibrar.su.csv <- function(lat, data, offset=0, nrows=NA){
    data.not.na <- data[!is.na(data$Nub),]
    data.not.na <- data.subset(data.not.na, offset, nrows)

    if(nrow(data[!is.na(data$Nub),]) < 20) {
        values <- c(0.07891896, 0.44729405, 0.14067643, 0.97747470)
        names(values) <- c("Sa", "Sb", "Sc", "Sr2")
        return(values)
    }
    return(sucal(lat=lat, days=as.Date(data.not.na$Date), rad_mea=data.not.na$Solrad, tmax=data.not.na$Tmax,
                 tmin=data.not.na$Tmin, cc=data.not.na$Nub))
}

data.subset <- function(data, offset=1, nrows=NA) {
    if(is.na(nrows)) {
        nrows <- nrow(data)
    }
    data <- data[offset:nrows,]
    return(data)
}