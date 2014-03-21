# Todas las funciones de calibración terminadas en ".csv" toman como entrada un campo
# data que debe ser un Data Frame con las cabeceras:
#  ___________________________________________________________________
# |  Date  |  Tmax  |  Tmin  |  Precip  |  Sunabs  |  Solrad  |  Nub  |
#  ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

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

calibrar.su.csv <- function(lat, data){
    data <- data[!is.na(data$Nub),]
    if(nrow(data) < 20) {
        values <- c(0.07891896, 0.44729405, 0.14067643, 0.97747470)
        names(values) <- c("Sa", "Sb", "Sc", "Sr2")
        return(values)
    }
    return(sucal(lat=lat, days=as.Date(data$Date), rad_mea=data$Solrad, tmax=data$Tmax, tmin=data$Tmin, cc=data$Nub))
}

data.subset <- function(data, offset=1, nrows=NA) {
    if(is.na(nrows)) {
        nrows <- nrow(data)
    }
    data <- data[offset:nrows]
    return(data)
}