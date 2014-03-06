pergamino = read.csv("rad/data/RadPergamino.csv")
pilar = read.csv("rad/data/RadPilar.csv")

calibrar.bc <- function() {
    # Obtenemos un valor de B con los datos de Pergamino.
    BCb.pergamino <- bccal(lat=-33.93, days=as.Date(pergamino$Date), rad_mea=pergamino$Solrad, Tmax=pergamino$Tmax, Tmin=pergamino$Tmin, tal=0.77)
    
    # Obtenemos un valor de B con los datos de Pilar, Córdoba.
    BCb.pilar <- bccal(lat=-31.67, days=as.Date(pilar$Date), rad_mea=pilar$Solrad, Tmax=pilar$Tmax, Tmin=pilar$Tmin, tal=0.77)
    
    return((BCb.pergamino + BCb.pilar) / 2)
}