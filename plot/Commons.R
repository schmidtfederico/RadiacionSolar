library(xtable)

# Abreviaturas de los métodos de predicción.
abreviaturas <- c("bc", "ha", "mh", "ap", "su")

# Nombres completos de los métodos.
nombre.metodo <- c("Bristow-Campbell", "Hargreaves", "Mahmood-Hubbard", "Ångström-Prescott", "Supit-Van Kappel")
names(nombre.metodo) <- abreviaturas

# Colores de ploteo de cada método de predicción.
color.ploteo.metodo <- c("lavender", "darkseagreen1", "skyblue", "bisque", "cadetblue4")
names(color.ploteo.metodo) <- abreviaturas

plot.xtable <- function(data.frame) {
    rws <- seq(1, (nrow(data.frame) - 1), by = 2)
    col <- rep("\\rowcolor[gray]{0.95}", length(rws))
    print(xtable(data.frame), booktabs = TRUE, add.to.row = list(pos = as.list(rws), command = col))
}

## Funciones de Ploteo y Cálculo de errores.
plotear.errores <- function(error) {
    # MAE, RMSE y MAD.
    # Obtenemos los límites del gráfico.
    pos <- par("usr")
    # En la esquina inferior derecha escribimos los valores calculados.
    text(pos[2]-4, pos[3]+1, paste("MAE = ", error[2]), cex=0.9)
    text(pos[2]-4, pos[3]+2.5, paste("RMSE = ", error[3]), cex=0.9)
    text(pos[2]-4, pos[3]+4, paste("MAD = ", error[1]), cex=0.9)
}

calcular.errores <- function(resultados) {
    error.bc <- calcular.error(resultados$bc, resultados$data)
    error.ha <- calcular.error(resultados$ha, resultados$data)
    error.mh <- calcular.error(resultados$mh, resultados$data)
    
    resultados.su <- resultados[!is.na(resultados$su),]
    error.su <- calcular.error(resultados.su$su, resultados.su$data)
    # Como puede ser que se tengan menos valores de Heliofanía que de mediciones reales de 
    # radiación solar en MJ/m², filtramos los datos por donde la heliofanía NO es "NA".
    resultados.ap <- resultados[!is.na(resultados$ap),]
    error.ap <- calcular.error(resultados.ap$ap, resultados.ap$data)
    
    errores <- data.frame(error.bc, error.ha, error.mh, error.su, error.ap)
    colnames(errores) <- c("bc", "ha", "mh", "su", "ap")
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