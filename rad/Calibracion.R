# Se leen los archivos CSV de cada estación.
pergamino = read.csv("rad/data/RadPergamino.csv")
pilar = read.csv("rad/data/RadPilar.csv")
laboulaye = read.csv("rad/data/RadLaboulaye.csv")

# Todas las funciones de calibración terminadas en ".csv" toman como entrada un campo
# data que debe ser un Data Frame con las cabeceras:
#  ___________________________________________________________
# |  Date  |  Tmax  |  Tmin  |  Precip  |  Sunabs  |  Solrad  |
#  ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
# Además, filtran los datos para usar los registros que contienen toda la información
# necesaria para realizar la calibración.

# Bristow-Campbell
calibrar.bc.csv <- function(lat, data) {
    # Filtramos las filas donde la medición de la radiación esté ausente.
    not.null.solrad <- data[!is.na(data$Solrad),]
    return(bccal(lat=lat, days=as.Date(not.null.solrad$Date), rad_mea=not.null.solrad$Solrad, Tmax=not.null.solrad$Tmax, Tmin=not.null.solrad$Tmin, tal=0.77))
}

# Hargreaves
calibrar.ha.csv <- function(lat, data) {
    not.null.solrad <- data[!is.na(data$Solrad),]
    return(hacal(lat=lat, days=as.Date(not.null.solrad$Date), rad_mea=not.null.solrad$Solrad, tmax=not.null.solrad$Tmax, tmin=not.null.solrad$Tmin))
}

# Angstrom-Prescott
calibrar.ap.csv <- function(lat, data) {
    # Filtramos las filas donde la medición de la radiación esté ausente.
    not.null.solrad <- data[!is.na(data$Solrad),]
    # Filtramos las filas donde la heliofanía esté ausente.
    not.null.sunrad <- not.null.solrad[!is.na(not.null.solrad$Sunabs),]
    
    return(apcal(lat=lat, days=as.Date(not.null.sunrad$Date), rad_mea=not.null.sunrad$Solrad, SSD=not.null.sunrad$Sunabs))
}