if(!require('randomForest')) install.packages('randomForest');
rm(list = objects()); gc()
source("plot/Commons.R")
source("plot/Resultados.R")

train <- read.csv('rna/train/pergamino-training.csv')
validation <- read.csv('rna/train/bsas-validation.csv')

train <- na.omit(data.frame(train[,1:5], train[,7:8]))
validation <- na.omit(data.frame(validation[,1:5], validation[,7:8]))

train <- na.omit(train)
validation <- na.omit(validation)

#rf <- randomForest(Solrad~Mes+Tmax+Tmin+Precip+Nub+Sunabs+ExtraT, data=train)
rf <- randomForest(Solrad~Mes+Tmax+Tmin+Precip+Sunabs+ExtraT, data=train)

importance(rf)

values <- predict(rf, validation)
values.adj <-  mapply(min, values, validation$ExtraT)

plotear.nube(prediccion=values.adj, data=validation$Solrad, ylab='Radiación predicha por RF', bg='bisque', error=NA)

root.mean.square.error(prediccion=values.adj, valor=validation$Solrad)
mean.absolute.error(prediccion=values.adj, valor=validation$Solrad)
