pergamino = read.csv("rad/data/RadPergamino.csv")
pilar = read.csv("rad/data/RadPilar.csv")
laboulaye = read.csv("rad/data/RadLaboulaye.csv")

calibrar.bc.avg <- function() {
    # Obtenemos un valor de B con los datos de Pergamino.
    BCb.pergamino <- calibrar.bc.csv(lat=-33.93, data=pergamino)
    # Obtenemos un valor de B con los datos de Pilar, Córdoba.
    BCb.pilar <- calibrar.bc.csv(lat=-31.67, data=pilar)
    # Obtenemos el B para Laboulaye.
    BCb.laboulaye <- calibrar.bc.csv(lat=-34.13, data=laboulaye)
    return((BCb.pergamino + BCb.pilar + BCb.laboulaye) / 3)
}

calibrar.bc.csv <- function(lat, data) {
    # Filtramos las filas donde la medición de la radiación esté ausente.
    not.null.solrad <- data[!is.na(data$Solrad),]
    return(bccal(lat=lat, days=as.Date(not.null.solrad$Date), rad_mea=not.null.solrad$Solrad, Tmax=not.null.solrad$Tmax, Tmin=not.null.solrad$Tmin, tal=0.77))
}

calibrar.ap.csv <- function(lat, data) {
    # Filtramos las filas donde la medición de la radiación esté ausente.
    not.null.solrad <- data[!is.na(data$Solrad),]
    # Filtramos las filas donde la heliofanía esté ausente.
    not.null.sunrad <- not.null.solrad[!is.na(not.null.solrad$Sunabs),]
    
    return(apcal(lat=lat, days=as.Date(not.null.sunrad$Date), rad_mea=not.null.sunrad$Solrad, SSD=not.null.sunrad$Sunabs))
}