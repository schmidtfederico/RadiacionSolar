source("plot/Commons.R")

plotear.resultados.todos <- function(resultados, errores) {
    # Bristow-Campbell
    plotear.resultados(resultados, errores, metodo='bc')
    
    # Hargreaves
    plotear.resultados(resultados, errores, metodo='ha')
    
    # Mahmoood-Hubbard
    plotear.resultados(resultados, errores, metodo='mh')
    
    # Angstrom-Prescott
    plotear.resultados(resultados, errores, metodo='ap')
}


plotear.resultados <- function(resultados, errores, plots='a', metodo) {
    if(metodo == 'ap') {
        # Como puede ser que se tengan menos valores de Heliofanía que de mediciones reales de 
        # radiación solar en MJ/m², filtramos los datos por donde la heliofanía NO es "NA".
        resultados <- resultados[!is.na(resultados$ap),]
    }
    
    data <- resultados$data
    # Extraemos del data frame la predicción para el método especificado y los errores
    # cometidos por el mismo.
    prediccion <- resultados[, metodo]
    error <- errores[, metodo]
    
    ylabel <- paste("Radiación Estimada Por", nombre.metodo[[metodo]], '[MJ/m²]')
    bgcolor <- color.ploteo.metodo[[metodo]]
    
    if(plots == 'a') {
        plotear.todos(data, prediccion, error, ylab=ylabel, bg=bgcolor)
    }
    if(plots == 'c') {
        plotear.nube(data, prediccion, error, ylab=ylabel, bg=bgcolor)
    }
    if(plots == 'r') {
        plotear.residuales(data, prediccion, error, ylab=ylabel, bg=bgcolor)
    }
    if(plots == 'q') {
        plotear.qq(data, prediccion, error, ylab=ylabel, bg=bgcolor)
    }
}


plotear.todos <- function(data, prediccion, error, ylab, bg, titulo=NA) {
    # Ajustamos los valores de la nube a una recta y la ploteamos.
    fit <- lm(prediccion ~ data, na.action=na.exclude)
    
    plotear.nube(data, prediccion, error, ylab, bg, titulo, fit)
    
    plotear.residuales(data, prediccion, error, ylab, bg, titulo, fit)
    
    plotear.qq(data, prediccion, error, ylab, bg, titulo)
    
    # Elimino el objeto fit porque suele ocupar mucho espacio en memoria.
    rm(fit)
}

# Plotea la nubre de comparación entre valor observado y valor calculado.
# Además, plotea una recta teórica de igualdad donde el valor observado y el predicho
# coinciden siempre y una recta de ajuste de la nube.
plotear.nube <- function(data, prediccion, error, ylab, bg, titulo=NA, fit=NA) {
    # Configuramos los márgenes c(bottom, left, top, right)
    par(mar=c(4,4,1,1))
    # Ploteamos la nube de puntos con los datos en el eje 'x' y los valores de la predicción
    # en el eje 'y'.
    plot(x=data, y=prediccion, bg=bg, pch=21, cex=0.5, lwd=0.5, main=titulo, xlab="Radiación Diaria Observada [MJ/m²]", ylab=ylab)
    # Ploteamos una línea x=y que sería el resultado ideal de cada método de predicción.
    abline(0,1, lwd=1.5)
    
    if(length(fit) == 0 || is.na(fit)) {
        fit <- lm(prediccion ~ data, na.action=na.exclude)
    }
    abline(fit, lwd=1.5, col="firebrick1")
    
    # Ploteamos en el gráfico un cuadro con los colores de las líneas y su significado.
    legend("topleft", inset=.01, box.lwd=0, c("1:1","Ajuste"), lty=1, lwd=2, col=c("black" ,"firebrick1"), cex=0.9)
    
    plotear.errores(error)
}

# Plotea los residuales del ajuste de la nube de los valores observados vs predichos.
plotear.residuales <- function(data, prediccion, error, ylab, bg, titulo=NA, fit=NA) {
    if(length(fit) == 0 || is.na(fit)) {
        fit <- lm(prediccion ~ data, na.action=na.exclude)
    }
    # Configuramos los márgenes c(bottom, left, top, right)
    par(mar=c(4,4,1,1))
    
    # Residuales
    # Ploteamos la nube de residuales del ajuste.
    plot(x=data, y=fit$residuals, pch=21, cex=0.5, lwd=0.5, main=titulo, xlab=ylab, ylab="Residuales", bg=bg)
    # Ploteamos una línea en y=0 para poder ver de qué lado hay más puntos y evaluar
    # si el método subestima o sobrestima en la mayoría de los casos y en qué valores
    # tiene a tener más o menos error.
    abline(0,0, lwd=1.5)
}

# Plotea el gráfico de comparación de cuantiles de los valores observados y los valores
# predichos.
plotear.qq <- function(data, prediccion, error, ylab, bg, titulo=NA){
    if(!is.na(titulo)){
        titulo <- paste(titulo, "QQPlot")
    }
    # Configuramos los márgenes c(bottom, left, top, right)
    par(mar=c(4,4,1,1))
    
    qqplot(x=data, y=prediccion, bg=bg, pch=21, cex=0.5, lwd=0.5, main=titulo, xlab="Radiación Observada", ylab=ylab)
    abline(0, 1, lwd=1.5)
}