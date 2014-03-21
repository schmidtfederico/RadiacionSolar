# Todas las funciones de calibración terminadas en ".csv" toman como entrada un campo
# data que debe ser un Data Frame con las cabeceras:
#  ___________________________________________________________
# |  Date  |  Tmax  |  Tmin  |  Precip  |  Sunabs  |  Solrad  |
#  ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Bristow-Campbell
calibrar.bc.csv <- function(lat, data) {
    return(bccal(lat=lat, days=as.Date(data$Date), rad_mea=data$Solrad, Tmax=data$Tmax, Tmin=data$Tmin, tal=tal))
}

# Hargreaves
calibrar.ha.csv <- function(lat, data) {
    return(hacal(lat=lat, days=as.Date(data$Date), rad_mea=data$Solrad, tmax=data$Tmax, tmin=data$Tmin))
}

# Angstrom-Prescott
calibrar.ap.csv <- function(lat, data) {
    # Filtramos las filas donde la heliofanía esté ausente.
    data <- data[!is.na(data$Sunabs),]    
    return(apcal(lat=lat, days=as.Date(data$Date), rad_mea=data$Solrad, SSD=data$Sunabs))
}

data.subset <- function(data, offset=1, nrows=NA) {
    if(is.na(nrows)) {
        nrows <- nrow(data)
    }
    data <- data[offset:nrows]
    return(data)
}