source('Main.R')

# Export para análisis.
#colnames(pilar) <- c('fecha', 'tmax', 'tmin', 'prcp', 'helio', 'rad','nub')
#write.csv(pilar, file='/home/federico/Escritorio/pilar.csv', row.names=FALSE)
#colnames(pergamino) <- c('fecha', 'tmax', 'tmin', 'prcp', 'helio', 'rad','nub')
#write.csv(pergamino, file='/home/federico/Escritorio/pergamino.csv', row.names=FALSE)

datos <- pergamino
lat <- lat.pergamino
resultados <- resultados.pergamino.ajustados
file.part <- "pergamino"
training.perc <- 0.6

subset1 <- datos[sample(x=1:nrow(datos), size=(nrow(datos)*training.perc), replace=FALSE),]
subset1 <- subset1[order(subset1$Date),]
subset2 <- datos[!datos$Date %in% subset1$Date,]

extraT <- extrat(dayOfYear(subset1$Date), lat=radians(lat))$ExtraTerrestrialSolarRadiationDaily
training <- data.frame(Mes=as.numeric(format(subset1$Date, "%m")), Tmax=subset1$Tmax, Tmin=subset1$Tmin,
                       Precip=subset1$Precip, Sunabs=subset1$Sunabs, Nub=subset1$Nub, ExtraT=extraT, 
                       Solrad=subset1$Solrad)

extraT <- extrat(dayOfYear(subset2$Date), lat=radians(lat))$ExtraTerrestrialSolarRadiationDaily
validation <- data.frame(Mes=as.numeric(format(subset2$Date, "%m")), Tmax=subset2$Tmax, Tmin=subset2$Tmin,
                         Precip=subset2$Precip, Sunabs=subset2$Sunabs, Nub=subset2$Nub, ExtraT=extraT, 
                         Solrad=subset2$Solrad, AP=resultados$ap[resultados$Date %in% subset2$Date])

write.table(training, file=paste0("rna/train/", file.part, "-training.csv"), sep=',', row.names=FALSE)
write.table(validation, file=paste0("rna/train/", file.part, "-validation.csv"), sep=',', row.names=FALSE)