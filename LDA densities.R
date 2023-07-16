library(MASS)
library(tidyverse)
library(plotly)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv") 

model_lda <- lda(Group~., data = df %>% dplyr::select(-c(Sample,File)))
predictions <- model_lda %>% predict(df %>% dplyr::select(-c(Group,Sample,File)))

tibble(LD1 = predictions$x[,1], Group = df$Group) %>% 
ggplot() +
  geom_density(aes(LD1, fill = Group), alpha = 0.3) +
  labs(title='Distribuciones de LD1') + ylab('Densidad') + 
  theme(text = element_text(size = 20))

tibble(LD2 = predictions$x[,2], Group = df$Group) %>% 
  ggplot() +
  geom_density(aes(LD2, fill = Group), alpha = 0.3) +
  labs(title='Distribuciones de LD2') + ylab('Densidad') + 
  theme(text = element_text(size = 20))

tibble(LD3 = predictions$x[,3], Group = df$Group) %>% 
  ggplot() +
  geom_density(aes(LD3, fill = Group), alpha = 0.3) +
  labs(title='Distribuciones de LD3') + ylab('Densidad') + 
  theme(text = element_text(size = 20))

tibble(LD1 = predictions$x[,1], Group = df$Group) %>% 
  ggplot() +
  geom_histogram(aes(LD1, fill = Group), alpha = 0.3, bins = 30, position = 'identity') +
  labs(title='Distribuciones de LD1') + ylab('Densidad') + 
  theme(text = element_text(size = 20))

tibble(LD2 = predictions$x[,2], Group = df$Group) %>% 
  ggplot() +
  geom_histogram(aes(LD2, fill = Group), alpha = 0.3, bins = 30, position = 'identity') +
  labs(title='Distribuciones de LD2') + ylab('Densidad') + 
  theme(text = element_text(size = 20))

tibble(LD3 = predictions$x[,3], Group = df$Group) %>% 
  ggplot() +
  geom_histogram(aes(LD3, fill = Group), alpha = 0.3, bins = 30, position = 'identity') +
  labs(title='Distribuciones de LD3') + ylab('Densidad')+ 
  theme(text = element_text(size = 20))

tibble(LD1 = predictions$x[,1],LD2 = predictions$x[,2],LD3 = predictions$x[,3], Group = df$Group) %>%
  plot_ly(x = ~LD1, y = ~LD2, z = ~LD3) %>%
  layout(
    font = list(size = 20)) %>%
  add_markers(alpha = 0.7, color = ~Group, colors = c('#F8766D', '#7CAE00','#00BFC4','#C77CFF'))

grid.lines = 100
x.pred <- seq(min(predictions$x[,1]), max(predictions$x[,1]), length.out = grid.lines)
y.pred <- seq(min(predictions$x[,2]), max(predictions$x[,2]), length.out = grid.lines)
xy <- expand.grid( x = x.pred, y = y.pred)

boundary.z <- function(xy,model,group.a,group.b){
priors <- model$prior
means <- colSums(priors*model$means)
scaling <- model$scaling
dm <- scale(model$means, center = means, scale = FALSE) %*% scaling
d <- -0.5*( sum(dm[group.a,]^2) - sum(dm[group.b,]^2)) + log(priors[group.a]/priors[group.b])
-( (dm[group.a,1] - dm[group.b,1])*xy$x +  (dm[group.a,2] - dm[group.b,2])*xy$y + d)/(dm[group.a,3] - dm[group.b,3])
}

z.pred.12 <- matrix(boundary.z(xy,model_lda,1,2), 
                 nrow = grid.lines, ncol = grid.lines)
z.pred.23 <- matrix(boundary.z(xy,model_lda,2,3), 
                    nrow = grid.lines, ncol = grid.lines)
z.pred.34 <- matrix(boundary.z(xy,model_lda,3,4), 
                    nrow = grid.lines, ncol = grid.lines)

z.pred.24 <- matrix(boundary.z(xy,model_lda,2,4), 
                    nrow = grid.lines, ncol = grid.lines)

tibble(LD1 = predictions$x[,1],LD2 = predictions$x[,2],LD3 = predictions$x[,3], Group = df$Group) %>%
  plot_ly(x = ~LD1, y = ~LD2, z = ~LD3) %>%
  layout(
    font = list(size = 20)) %>%
  add_markers(alpha = 0.7, color = ~Group, colors = c('#F8766D', '#7CAE00','#00BFC4','#C77CFF')) %>%
  add_surface(x=x.pred, y=y.pred, z=z.pred.24,type = 'mesh3d', name = 'boundary 2 and 4', opacity = 0.3) 
#  add_surface(x=x.pred, y=y.pred, z=z.pred.23,type = 'mesh3d', name = 'boundary 2 and 3', colors = '#000000', opacity = 0.3)%>%
#  add_surface(x=x.pred, y=y.pred, z=z.pred.34,type = 'mesh3d', name = 'boundary 3 and 4', colors = '#000000', opacity = 0.3)
