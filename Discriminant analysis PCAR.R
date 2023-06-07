#library(vegan)
library(tidymodels)
#library(mvnormtest)
#library(mvnTest)
library(MASS)
library(mlr)
library(tidyverse)
library(ggord)

seeds <- c(911, 277, 307, 349, 101)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería_PCAR.csv") 

#usar solo con QDA
#df <- df[1:23]

#Entrenamiento y predicción
set.seed(seeds[1])

df_split <- initial_split(df,
                          prop = 0.8)

df_train <- df_split %>%
  training()

df_test <- df_split %>%
  testing()



#LDA
start_time <- Sys.time()

model_lda <- lda(Group~., data = df_train %>% dplyr::select(-c(Sample,File)))#, prior = c(40/156,36/156,40/156,40/156))
predictions <- model_lda %>% predict(df_test)

end_time <- Sys.time()

end_time - start_time

#model_lda
#predictions

table(predictions$class,df_test$Group)

measureACC(predictions$class,df_test$Group)

prop = model_lda$svd^2/sum(model_lda$svd^2)
prop

lda.data <- cbind(df_train, predict(model_lda)$x)
ggplot(lda.data, aes(LD1, LD2)) +
  geom_point(aes(color = Group)) +
  xlab(paste('LD1 (', round(prop[1] * 100,2) ,'%)')) + 
  ylab(paste('LD2 (', round(prop[2] * 100,2) ,'%)'))

#ggord(model_lda, df_train$Group)

#QDA
start_time <- Sys.time()

model_qda <- qda(Group~., data = df_train %>% dplyr::select(-c(Sample,File)))#, prior = c(40/156,36/156,40/156,40/156))
predictions <- model_qda %>% predict(df_test)

end_time <- Sys.time()

end_time - start_time

#model_qda
#predictions

table(predictions$class,df_test$Group)

measureACC(predictions$class,df_test$Group)

#esto no tiene sentido por si solo
#prop = model_qda$svd^2/sum(model_lda$svd^2)
#prop

#qda.data <- cbind(df_train, predict(model_qda)$x)
#ggplot(qda.data, aes(LD1, LD2)) +
#  geom_point(aes(color = Group)) +
#  xlab(paste('QD1 (', round(prop[1] * 100,2) ,'%)')) + 
#  ylab(paste('QD2 (', round(prop[2] * 100,2) ,'%)'))

#ggord(model_qda, df_train$Group)
