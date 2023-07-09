#https://stackoverflow.com/questions/61289706/unable-to-plot-decision-boundary-in-r-with-geom-contour
#https://stackoverflow.com/questions/55936315/decision-boundary-plots-in-ggplot2
#https://scikit-learn.org/stable/modules/generated/sklearn.inspection.DecisionBoundaryDisplay.html#sklearn.inspection.DecisionBoundaryDisplay.from_estimator
#https://stackoverflow.com/questions/31234621/variation-on-how-to-plot-decision-boundary-of-a-k-nearest-neighbor-classifier-f

library(tidymodels)
library(tidyverse)
require(lightgbm)

seed <-277 #original: 911

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería_UMAPb.csv")

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
  learning_rate = 0.09010802025608756,
  min_child_samples =  16,
  num_leaves = 16,
  random_state = 277,
  reg_alpha =  0.05
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
geom_raster(data= g, aes(x= dim1, y=dim2, fill=class, alpha = prob ), interpolate = TRUE) +
geom_contour(data= g, aes(x= dim1, y=dim2, z = as.numeric(class)), color = 'black') +
geom_point(data = df_test, size = 2, aes(x= dim1, y=dim2, color=Group)) + 
geom_point(data = df_test, size = 2, shape = 1, aes(x= dim1, y=dim2)) +
theme(text = element_text(size = 20)) +
guides(fill = 'none') + 
coord_equal()
