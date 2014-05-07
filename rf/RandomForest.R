if(!require('randomForest')) install.packages('randomForest');

train <- rbind(bsas.calibracion, pilar.calibracion)

rfA <- randomForest(Solrad~Tmax+Tmin+Precip+Nub+Sunabs+ExtraT, data=na.omit(train), ntree=1000)
rfB <- randomForest(Solrad~Sunabs+ExtraT, data=train[!is.na(train$Sunabs),], ntree=1000)
