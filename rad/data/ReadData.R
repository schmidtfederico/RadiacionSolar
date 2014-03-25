# Filtramos los datos para eliminar de los mismos los registros donde la
# medición de la radiación es nula ya que no nos sirven para calibrar
# ni para después comparar la performance del método de estimación.
read.not.na <- function(file, field='Solrad', ...) {
    data <- read.csv(file, ...)
    data <- data[!is.na(data[,field]),]
    return(data)
}

# Se leen los archivos CSV de cada estación.
pergamino = read.not.na("rad/data/RadPergamino.csv")
pilar = read.not.na("rad/data/RadPilar.csv")
laboulaye = read.not.na("rad/data/RadLaboulaye.csv")
buenos.aires = read.not.na("rad/data/RadBsAs.csv")