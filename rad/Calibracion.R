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
    not.null.solrad <- data[!is.na(data$Solrad),]
    return(bccal(lat=lat, days=as.Date(not.null.solrad$Date), rad_mea=not.null.solrad$Solrad, Tmax=not.null.solrad$Tmax, Tmin=not.null.solrad$Tmin, tal=0.77))
}

calibrar.ap <- function(){
    ap.pergamino <- apcal(lat=-33.93, days=as.Date(pergamino$Date), rad_mea=pergamino$Solrad, SSD=pergamino$Sunabs)
    
    #ap.pilar <- apcal(lat=-31.67, days=as.Date(pilar$Date), rad_mea=pilar$Solrad, SSD=pilar$Sunabs)
    return(ap.pergamino)
}

#rad.bc <- bc(days=as.Date(pergamino$Date), lat=-33.93, BCb=BCb.pergamino, Tmax=pergamino$Tmax, Tmin=pergamino$Tmin, tal=0.77)
#df <- data.frame(pergamino, rad.bc, (rad.bc - pergamino$Solrad))
