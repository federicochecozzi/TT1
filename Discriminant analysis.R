library(tidymodels)
library(mvnormtest)
library(MASS)
library(tidyverse)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv") 

set.seed(911)

df_split <- initial_split(df,
                          prop = 0.8)

df_train <- df_split %>%
  training()

df_test <- df_split %>%
  testing()

#revisando supuestos (no funciona bien, en Python igual se revisó la normalidad)
#df %>%
#  filter(Group == '04_02') %>%
#  dplyr::select(where(is.numeric)) %>%
#  t() %>% mshapiro.test()


#LDA
model_lda <- lda(Group~., data = df_train %>% dplyr::select(-c(Sample,File)))
model_lda

predictions <- model_lda %>% predict(df_test)
predictions

table(predictions$class,df_test$Group)

library(ggord)
ggord(model_lda, df_train$Group)