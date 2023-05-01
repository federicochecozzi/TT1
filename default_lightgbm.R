library(tidymodels)
library(tidyverse)
require(lightgbm)
library(rospca)

projection <- TRUE
ncomp <- 50 #número de componentes, si es cero el algoritmo elige suficientes componentes para sumar el 90% de la varianza
seed <-277 #original: 911

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv")

if(projection){
  pcar <- robpca(df %>% select(where(is.numeric)), k = ncomp, kmax = 156)
  df <-  df %>% select(negate(where(is.numeric))) %>%
    bind_cols(pcar$scores)
}

set.seed(seed)

df_split <- initial_split(df,
                          prop = 0.8)

df_train <- df_split %>%
  training()

df_test <- df_split %>%
  testing()

dtrain  <- lgb.Dataset( data= data.matrix(df_train %>% select(where(is.numeric))),
                        label= as.numeric(as.factor(df_train$Group)) - 1 )

params <- list(
  objective = "multiclass", 
  num_class = 4
)

model  <- lgb.train( data= dtrain, params = params)

prediction  <- as.data.frame(predict( model,
                        data.matrix( df_test %>% select(where(is.numeric))),
                        reshape = TRUE))

table(colnames(prediction)[apply(prediction,1,which.max)]
,df_test$Group)
