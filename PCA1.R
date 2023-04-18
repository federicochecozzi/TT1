library(tidyverse)
library(ggfortify)
library(rospca)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv")

#PCA general

pca <- df %>% 
  select(where(is.numeric)) %>%
  prcomp()

screeplot(pca, type = "l", npcs = 156)
abline(h = 1, col="red", lty=5)
legend("topright", legend=c("Autovalor = 1"),
       col=c("red"), lty=5, cex=0.6)

prop_variance <- pca$sdev^2 / sum(pca$sdev^2)
prop_variance_cum <- cumsum(prop_variance)

ggplot(data = data.frame(prop_variance_cum, pc = 1:156), 
       aes(x = pc, y = prop_variance_cum, group = 1)) +
  geom_col(width = 0.3, fill = 'slateblue3') +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")

autoplot(pca, data = df, colour = 'Group', alpha = 0.5)#, loadings = FALSE, 
         #loadings.colour = 'black', loadings.label = TRUE, loadings.label.size = 3)

pcar <- robpca(df %>% select(where(is.numeric)), k=10)

#screeplot(pcar, type = "l", npcs = 10)
prop_variance_r <- pcar$eigenvalues / sum(pcar$eigenvalues)
prop_variance_cum_r <- cumsum(prop_variance_r)

ggplot(data = data.frame(prop_variance_cum_r, pc = 1:10), 
       aes(x = pc, y = prop_variance_cum_r, group = 1)) +
  geom_col(width = 0.3, fill = 'slateblue3') +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")

pcar$scores %>%
  ggplot(aes(x = PC1, y = PC2, color = df$Group)) +
  geom_point()

#PCA por grupo

pca_g1 <- df %>% 
  filter(Group == "04_02") %>%
  select(where(is.numeric)) %>%
  prcomp()
  
prop_variance_g1 <- pca_g1$sdev^2 / sum(pca_g1$sdev^2)
prop_variance_cum_g1 <- cumsum(prop_variance_g1)
  
ggplot(data = data.frame(prop_variance_cum_g1, pc = 1:40), 
         aes(x = pc, y = prop_variance_cum_g1, group = 1)) +
geom_col(width = 0.3, fill = 'slateblue3') +
theme_bw() +
    labs(x = "Componente principal",
         y = "Prop. varianza explicada acumulada")
  
autoplot(pca_g1, data = df %>% filter(Group == "04_02"), colour = 'Group', alpha = 0.5)

pcar_g1 <- robpca(df %>% filter(Group == "04_02") %>% select(where(is.numeric)))

prop_variance_r_g1 <- pcar_g1$eigenvalues / sum(pcar_g1$eigenvalues)
prop_variance_cum_r_g1 <- cumsum(prop_variance_r_g1)

ggplot(data = data.frame(prop_variance_cum_r_g1, pc = 1:pcar_g1$k), 
       aes(x = pc, y = prop_variance_cum_r_g1, group = 1)) +
  geom_col(width = 0.3, fill = 'slateblue3') +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")

pcar_g1$scores %>%
  ggplot(aes(x = PC1, y = PC2)) +
  geom_point(color = rep(c(1,2), each = 20)) #esto es para darle un color a cada grupo de muestras, es poco elegante

diagPlot(pcar_g1, id = 3)
