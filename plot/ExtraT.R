source("plot/Commons.R")

plot.extrat <- function(lat, resultados, metodo=NA) {
    if(is.na(metodo)) {
        valores <- resultados$data
        bgcolor <- 'tomato2'
        ylabel <- 'Radiación Diaria Observada [MJ/m²]'
    } else {
        valores <- resultados[, metodo]
        bgcolor = color.ploteo.metodo[[metodo]]
        ylabel <- paste("Radiación Estimada Por", nombre.metodo[[metodo]], '[MJ/m²]')
    }
    # Configuramos los márgenes c(bottom, left, top, right)
    par(mar=c(4,4,1,1))
    
    plot(x=dayOfYear(resultados$Date), y=valores, pch=21, cex=0.5, bg=bgcolor, xlab='Día del Año', ylab=ylabel, ylim=c(1,45))
    extraT <- extrat(i=1:366, lat=radians(lat))$ExtraTerrestrialSolarRadiationDaily
    # Radiación solar recibida en la atmósfera (Qo)
    lines(x=1:366, y=extraT)
    # Radiaición solar en la superficie terrestre.    
    lines(x=1:366, y=tal*extraT, lty=2, lwd=2)
}