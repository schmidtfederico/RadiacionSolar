# Filtramos los datos para eliminar de los mismos los registros donde la
# medición de la radiación es nula ya que no nos sirven para calibrar
# ni para después comparar la performance del método de estimación.
read.not.na <- function(file, field='Solrad', ...) {
    data <- read.csv(file, ...)
    data <- data[!is.na(data[,field]),]
    data$Date <- as.Date(data$Date)
    return(data)
}

filtrar.mediciones <- function(lat, data) {
    extraT <- extrat(i=1:366, lat=radians(lat))$ExtraTerrestrialSolarRadiationDaily
    maxRad <- extraT[dayOfYear(data$Date)]*tal
    
    data <- data[data$Solrad <= maxRad,]
    return(cbind(data, ExtraT=extraT[dayOfYear(data$Date)], Mes=as.numeric(format(data$Date, "%m"))))
}

muestrear <- function(data, perc=0.7) {
    sample <- data[sample(x=1:nrow(data), size=(nrow(data)*perc), replace=FALSE),]
    sample <- sample[order(sample$Date),]
    return(sample)
}

# Se leen los archivos CSV de cada estación.
pilar = read.not.na("rad/data/Pilar.csv")
buenos.aires = read.not.na("rad/data/BsAs.csv")
buenos.aires <- buenos.aires[buenos.aires$Date < '2014-01-01',]
