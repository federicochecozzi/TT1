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

df <- read.csv2("spc24Oct2019/Minería.csv") 

#revisando supuestos (no funciona bien, en Python igual se revisó la normalidad)
#df %>%
#  filter(Group == '04_02') %>%
#  dplyr::select(where(is.numeric)) %>%
#  t() %>% mshapiro.test()

#ridículamente lento, pero permite ver el p valor en vez de obtener un nan como en python
#df %>%
#  filter(Group == '04_02') %>%
#  dplyr::select(where(is.numeric)) %>%
#  HZ.test()

#test_levene <- df %>% 
#  dplyr::select(where(is.numeric)) %>%
#  dist(method = 'euclidean') %>%
#  vegan::betadisper(df$Group, type = c("median","centroid"), bias.adjust = T,sqrt.dist = FALSE, add = FALSE) %>%
#  anova()
#cat(paste("p-value <",test_levene$`Pr(>F)`[1]))

#Entrenamiento y predicción
set.seed(seeds[2])

df_split <- initial_split(df,
                          prop = 0.8)

df_train <- df_split %>%
  training()

df_test <- df_split %>%
  testing()



#LDA
start_time <- Sys.time()

model_lda <- lda(Group~., data = df_train %>% dplyr::select(-c(Sample,File)))
predictions <- model_lda %>% predict(df_test)

end_time <- Sys.time()

end_time - start_time

#model_lda
#predictions

table(df_test$Group,predictions$class)

measureACC(predictions$class,df_test$Group)

prop = model_lda$svd^2/sum(model_lda$svd^2)
prop

lda.data <- cbind(df_train, predict(model_lda)$x)
ggplot(lda.data, aes(LD1, LD2)) +
  geom_point(aes(color = Group)) +
  xlab(paste('LD1 (', round(prop[1] * 100,2) ,'%)')) + 
  ylab(paste('LD2 (', round(prop[2] * 100,2) ,'%)'))

#ggord(model_lda, df_train$Group)

#https://analyticalsciencejournals.onlinelibrary.wiley.com/doi/10.1002/cem.676
#del modo que está escrita la función, no es posible usarla si hay pocas muestras 
#relativas al número de variables, ya que no descarta dimensiones latentes
#QDA
#start_time <- Sys.time()

#model_qda <- qda(Group~., data = df_train %>% dplyr::select(-c(Sample,File)))
#predictions <- model_qda %>% predict(df_test)

#Sys.time() - start_time

#model_qda
#predictions

#table(predictions$class,df_test$Group)

#measureACC(predictions$class,df_test$Group)

#ggord(model_qda, df_train$Group)