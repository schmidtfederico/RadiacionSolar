
plotear.resultados <- function(resultados, nombre.estacion) {
    
    titulo.plot <- paste("Estación", nombre.estacion, sep=" ")
    # Bristow-Campbell
    plotear.con.ajuste(x=resultados$bc, y=resultados$data, xlab="Radiación Estimada Por Bristow-Campbell",
                       titulo=titulo.plot, bg="lavender")
    
    # Hargreaves
    plotear.con.ajuste(x=resultados$ha, y=resultados$data, xlab="Radiación Estimada Por Hargreaves",
                       titulo=titulo.plot, bg="darkseagreen1")
    
    # Mahmoood-Hubbard
    plotear.con.ajuste(x=resultados$mh, y=resultados$data, xlab="Radiación Estimada Por Mahmood-Hubbard",
                       titulo=titulo.plot, bg="skyblue")
    
    # Armstrong-Prescott
    # Como puede ser que se tengan menos valores de Heliofanía que de mediciones reales de 
    # radiación solar en MJ/m², filtramos los datos por donde la heliofanía NO es "NA".
    resultados <- resultados[!is.na(resultados$ap),]
    plotear.con.ajuste(x=resultados$ap, y=resultados$data, xlab="Radiación Estimada Por Armstrong-Prescott",
                       titulo=titulo.plot, bg="bisque")
}


plotear.con.ajuste <- function(x, y, xlab, ylab, bg, titulo) {
    plot(x=x, y=y, bg=bg, pch=21, cex=0.5, lwd=0.5, main=titulo, xlab=xlab, ylab="Radiación Medida")
    abline(0,1, lwd=1.5)
    fit <- lm(y ~ x, na.action=na.exclude)
    abline(fit, lwd=1.5, col="firebrick1")
    
    # Residuales
    print(paste(length(x), length(fit$residuals), length(y), sep="/"))
    plot(x=x, y=fit$residuals, pch=21, cex=0.5, lwd=0.5, main=titulo, xlab=xlab, ylab="Residuales", bg=bg)
    abline(0,0, lwd=1.5)
    
    rm(fit)
}