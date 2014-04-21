if(!require('neuralnet')) { install.packages('neuralnet'); }
source('init/init.R')
source('plot/Commons.R')
source('plot/Resultados.R')
library('neuralnet')

train <- read.csv('rna/train/pergamino-training.csv')
validation <- read.csv('rna/train/pergamino-validation.csv')

train <- na.omit(data.frame(train[,1:5], train[,7:8]))
validation <- na.omit(data.frame(validation[,1:5], validation[,7:8]))

#validation <- data.frame(validation$Mes, validation$Tmax, validation$Tmin, validation$Precip,
#                         validation$Nub, validation$Sunabs, validation$ExtraT)
#                         validation$Sunabs, validation$ExtraT)

#nnet <- neuralnet(Solrad~Mes+Tmax+Tmin+Precip+Nub+Sunabs+ExtraT, train, learningrate=1, hidden=c(70,90,90,70),
#                        threshold=1, lifesign='full', lifesign.step=50)
nnet <- neuralnet(Solrad~Tmax+Tmin+Precip+Sunabs+ExtraT, train, learningrate=1, hidden=c(70,90,90,70),
                  threshold=1, lifesign='full', lifesign.step=50)
#bs.as.nnet <- neuralnet(Solrad~Tmax+Tmin+Precip+Nub+Sunabs+ExtraT, train.bsas, learningrate=1, hidden=c(70,90,90,70),
#                        threshold=1, lifesign='full', lifesign.step=50)
print(nnet)

values <- compute(nnet, validation[,2:6])$net.result[,1]
values.adj <-  mapply(min, values, validation$ExtraT)

plotear.nube(prediccion=values.adj, data=validation$Solrad, ylab='Radiación predicha por RNA', bg='bisque', error=NA)

root.mean.square.error(prediccion=values.adj, valor=validation$Solrad)
mean.absolute.error(prediccion=values.adj, valor=validation$Solrad)
