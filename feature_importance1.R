require("lightgbm")
library(tidyverse)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv") 

#https://www.datatechnotes.com/2022/05/lightgbm-multi-class-classification.html

dtrain  <- lgb.Dataset( data= data.matrix(df %>% select(where(is.numeric))),
                        label= as.numeric(as.factor(df$Group)) - 1 )

model  <- lgb.train( data= dtrain, objective = "multiclass", num_class = 4)

as.data.frame( lgb.importance(model) )
tree_imp = lgb.importance(model)#, percentage = T)
lgb.plot.importance(tree_imp, measure = "Gain")

