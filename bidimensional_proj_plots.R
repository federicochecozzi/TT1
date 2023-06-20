library(tidyverse)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería_SOM.csv")

pdf("spc24Oct2019/SOM.pdf")

df %>% ggplot(aes(x = x, y= y, color = Group)) +
  geom_point(alpha = 0.6) + 
  theme(text = element_text(size = 20)) 

dev.off()

df <- read.csv2("spc24Oct2019/Minería_UMAPb.csv")

pdf("spc24Oct2019/UMAP.pdf")

df %>% ggplot(aes(x = dim1, y= dim2, color = Group)) +
  geom_point(alpha = 0.6) + 
  theme(text = element_text(size = 20)) 

dev.off()
