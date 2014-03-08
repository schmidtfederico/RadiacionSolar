
plotear.resultados <- function(resultados, nombre.estacion) {
    
    titulo.plot <- paste("Estación", nombre.estacion, sep=" ")
    # Bristow-Campbell
    plotear.con.ajuste(x=resultados$bc, y=resultados$data, xlab="Radiación Estimada Por Bristow-Campbell",
                       ylab="Radiación Medida", titulo=titulo.plot, bg="lavender")
    # Hargreaves
    plotear.con.ajuste(x=resultados$ha, y=resultados$data, xlab="Radiación Estimada Por Hargreaves",
                       ylab="Radiación Medida", titulo=titulo.plot, bg="darkseagreen1")
    # Mahmoood-Hubbard
    plotear.con.ajuste(x=resultados$mh, y=resultados$data, xlab="Radiación Estimada Por Mahmood-Hubbard",
                       ylab="Radiación Medida", titulo=titulo.plot, bg="skyblue")
    # Armstrong-Prescott
    plotear.con.ajuste(x=resultados$ap, y=resultados$data, xlab="Radiación Estimada Por Armstrong-Prescott",
                       ylab="Radiación Medida", titulo=titulo.plot, bg="bisque")
}


plotear.con.ajuste <- function(x, y, xlab, ylab, bg, titulo) {
    plot(x=x, y=y, bg=bg, pch=21, cex=0.5, lwd=0.5, main=titulo, xlab=xlab, ylab=ylab)
    abline(0,1, lwd=1.5)
    fit <- lm(x ~ y)
    abline(fit, lwd=1.5, col="firebrick1")
    rm(fit)
}