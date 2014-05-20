if(!require('randomForest')) install.packages('randomForest');
rm(list = objects()); gc()
source("plot/Commons.R")
source("plot/Resultados.R")

train <- rbind(read.csv('rna/train/pilar-training.csv'), read.csv('rna/train/bsas-training.csv'))
validation <- rbind(read.csv('rna/train/pilar-validation.csv'))

#train <- na.omit(data.frame(train[,1:6], train[,7:8]))
#validation <- na.omit(data.frame(validation[,1:5], validation[,7:8]))

train <- na.omit(train)
validation <- na.omit(validation)

rf <- randomForest(Solrad~Tmax+Tmin+ExtraT, data=train, ntree=1000)
rf2 <- randomForest(Solrad~Sunabs+ExtraT, data=train, ntree=1000)

importance(rf)
importance(rf2)

values <- predict(rf, validation)
values.adj <-  mapply(min, values, validation$ExtraT)

errores <- calcular.error(prediccion=values.adj, data=validation$Solrad)
plotear.nube(prediccion=values.adj, data=validation$Solrad, ylab='Radiación predicha por RF', bg='bisque', error=errores)
