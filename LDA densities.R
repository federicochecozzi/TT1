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
  add_markers(size = 1, alpha = 0.7, color = ~Group, colors = c('#F8766D', '#7CAE00','#00BFC4','#C77CFF'))
