
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
    
    # Angstrom-Prescott
    # Como puede ser que se tengan menos valores de Heliofanía que de mediciones reales de 
    # radiación solar en MJ/m², filtramos los datos por donde la heliofanía NO es "NA".
    resultados <- resultados[!is.na(resultados$ap),]
    plotear.con.ajuste(x=resultados$ap, y=resultados$data, xlab="Radiación Estimada Por Angstrom-Prescott",
                       titulo=titulo.plot, bg="bisque")
}


plotear.con.ajuste <- function(x, y, xlab, ylab, bg, titulo) {
    plot(x=y, y=x, bg=bg, pch=21, cex=0.5, lwd=0.5, main=titulo, xlab=xlab, ylab="Radiación Medida")
    abline(0,1, lwd=1.5)
    fit <- lm(x ~ y, na.action=na.exclude)
    abline(fit, lwd=1.5, col="firebrick1")
    
    legend("topleft", inset=.01, box.lwd=0, c("1:1","Ajuste"), lty=1, lwd=2, col=c("black" ,"firebrick1"), cex=0.9)
    
    # MAE, RMSE y MAD.
    pos <- par("usr")
    text(pos[2]-4, pos[3]+1, paste("MAE = ", mean.absolute.error(x, y)), cex=0.9)
    text(pos[2]-4, pos[3]+2.5, paste("RMSE = ", root.mean.square.error(x, y)), cex=0.9)
    text(pos[2]-4, pos[3]+4, paste("MAD = ", median.absolute.deviation(x, y)), cex=0.9)               
           
    
    # Residuales
    plot(x=x, y=fit$residuals, pch=21, cex=0.5, lwd=0.5, main=titulo, xlab=xlab, ylab="Residuales", bg=bg)
    abline(0,0, lwd=1.5)
    
    rm(fit)
}

mean.absolute.error <- function(prediccion, valor) {
    return(round(mean(abs(prediccion-valor)), 2))
}

root.mean.square.error <- function(prediccion, valor) {
    return(round(sqrt(mean((valor-prediccion)^2)), 2))
}

median.absolute.deviation <- function(prediccion, valor) {
    m <- median(valor)
    return(round(median(abs(prediccion-m)), 2))
}