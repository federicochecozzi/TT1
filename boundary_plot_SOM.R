library(tidymodels)
library(tidyverse)
require(lightgbm)

seed <-911

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería_SOM.csv")

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
  num_class = 4,
  colsample_bytree =  1,
  learning_rate = 0.04699209731494774,
  min_child_samples =  24,
  num_leaves = 4,
  random_state = 911
)

model  <- lgb.train( data= dtrain, params = params)

#table(colnames(prediction)[apply(prediction,1,which.max)]
#      ,df_test$Group)

resolution = 100

r <- sapply(df %>% select(where(is.numeric)), range, na.rm = TRUE)
xs <- seq(floor(r[1,1]), ceiling(r[2,1]), length.out = resolution)
ys <- seq(floor(r[1,2]), ceiling(r[2,2]), length.out = resolution)
g <- cbind(rep(xs, each=resolution), rep(ys, time = resolution))
colnames(g) <- colnames(df %>% select(where(is.numeric)))
g <- as.data.frame(g)

prediction <- as.data.frame(predict( model,
                                     data.matrix(g),
                                     reshape = TRUE))
g <- g %>% 
  mutate(class = as.factor(apply(prediction,1,which.max)),
         prob = apply(prediction,1,max))

ggplot() + 
  geom_raster(data= g, aes(x= x, y=y, fill=class, alpha = prob ), interpolate = TRUE) +
  geom_contour(data= g, aes(x= x, y=y, z = as.numeric(class)), color = 'black') +
  geom_point(data = df_test, size = 2, aes(x= x, y=y, color=Group)) + 
  geom_point(data = df_test, size = 2, shape = 1, aes(x= x, y=y)) +
  theme(text = element_text(size = 20)) +
  guides(fill = 'none') + 
  coord_equal()
