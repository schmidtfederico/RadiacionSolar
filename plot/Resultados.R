
plotear.resultados <- function(resultados, nombre.estacion, errores) {
    
    titulo.plot <- paste("Estación", nombre.estacion, sep=" ")
    
    # Bristow-Campbell
    plotear.con.ajuste(data=resultados$data, prediccion=resultados$bc, error=errores$bc,
                       ylab="Radiación Estimada Por Bristow-Campbell",
                       titulo=titulo.plot, bg="lavender")
    
    # Hargreaves
    plotear.con.ajuste(data=resultados$data, prediccion=resultados$ha, error=errores$ha,
                       ylab="Radiación Estimada Por Hargreaves",
                       titulo=titulo.plot, bg="darkseagreen1")
    
    # Mahmoood-Hubbard
    plotear.con.ajuste(data=resultados$data, prediccion=resultados$mh, error=errores$mh,
                       ylab="Radiación Estimada Por Mahmood-Hubbard",
                       titulo=titulo.plot, bg="skyblue")
    
    # Angstrom-Prescott
    # Como puede ser que se tengan menos valores de Heliofanía que de mediciones reales de 
    # radiación solar en MJ/m², filtramos los datos por donde la heliofanía NO es "NA".
    resultados <- resultados[!is.na(resultados$ap),]
    plotear.con.ajuste(data=resultados$data, prediccion=resultados$ap, error=errores$ap,
                       ylab="Radiación Estimada Por Angstrom-Prescott",
                       titulo=titulo.plot, bg="bisque")
}


plotear.con.ajuste <- function(data, prediccion, error, ylab, bg, titulo) {
    # Ploteamos la nube de puntos con los datos en el eje 'x' y los valores de la predicción
    # en el eje 'y'.
    plot(x=data, y=prediccion, bg=bg, pch=21, cex=0.5, lwd=0.5, main=titulo, xlab="Radiación Medida", ylab=ylab)
    # Ploteamos una línea x=y que sería el resultado ideal de cada método de predicción.
    abline(0,1, lwd=1.5)
    # Ajustamos los valores de la nube a una recta y la ploteamos.
    fit <- lm(prediccion ~ data, na.action=na.exclude)
    abline(fit, lwd=1.5, col="firebrick1")
    
    # Ploteamos en el gráfico un cuadro con los colores de las líneas y su significado.
    legend("topleft", inset=.01, box.lwd=0, c("1:1","Ajuste"), lty=1, lwd=2, col=c("black" ,"firebrick1"), cex=0.9)
    
    # MAE, RMSE y MAD.
    # Obtenemos los límites del gráfico.
    pos <- par("usr")
    # En la esquina inferior derecha escribimos los valores calculados.
    text(pos[2]-4, pos[3]+1, paste("MAE = ", error[2]), cex=0.9)
    text(pos[2]-4, pos[3]+2.5, paste("RMSE = ", error[3]), cex=0.9)
    text(pos[2]-4, pos[3]+4, paste("MAD = ", error[1]), cex=0.9)               
    
    # Residuales
    # Ploteamos la nube de residuales del ajuste.
    plot(x=data, y=fit$residuals, pch=21, cex=0.5, lwd=0.5, main=titulo, xlab=ylab, ylab="Residuales", bg=bg)
    # Ploteamos una línea en y=0 para poder ver de qué lado hay más puntos y evaluar
    # si el método subestima o sobrestima en la mayoría de los casos y en qué valores
    # tiene a tener más o menos error.
    abline(0,0, lwd=1.5)
    
    # Ploteamos el gráfico de comparación de cuantiles.
    qqplot(x=data, y=prediccion, bg=bg, pch=21, cex=0.5, lwd=0.5, main=paste(titulo, "QQPlot"), xlab="Radiación Medida", ylab=ylab)
    abline(0, 1, lwd=1.5)
    
    # Elimino el objeto fit porque suele ocupar mucho espacio en memoria.
    rm(fit)
}


calcular.errores <- function(resultados) {
    error.bc <- calcular.error(resultados$bc, resultados$data)
    error.ha <- calcular.error(resultados$ha, resultados$data)
    error.mh <- calcular.error(resultados$mh, resultados$data)
    # Como puede ser que se tengan menos valores de Heliofanía que de mediciones reales de 
    # radiación solar en MJ/m², filtramos los datos por donde la heliofanía NO es "NA".
    resultados <- resultados[!is.na(resultados$ap),]
    error.ap <- calcular.error(resultados$ap, resultados$data)
    
    errores <- data.frame(error.bc, error.ha, error.mh, error.ap)
    colnames(errores) <- c("bc", "ha", "mh", "ap")
    return(errores)
}

calcular.error <- function(prediccion, data) {
    errores <- c(median.absolute.deviation(prediccion, data),
                 mean.absolute.error(prediccion, data),
                 root.mean.square.error(prediccion, data))
    names(errores) <- c("mad", "mae", "rmse")
    return(errores)
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