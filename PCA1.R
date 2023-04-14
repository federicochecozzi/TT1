library(tidyverse)
library(ggfortify)
library(rospca)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv")

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
