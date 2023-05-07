library(tidyverse)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv")

#https://stackoverflow.com/questions/71799329/include-bar-labels-inside-ggplot-plot-bar-chart

pdf("spc24Oct2019/Class_distribution.pdf")

ggplot(df, aes(x = Group, fill = Sample )) + 
  geom_bar( position="dodge2" ) +
  scale_fill_brewer(palette = "Set2") +
  geom_text(aes(label = Sample), stat = "count", vjust = 1,                 
            position = position_dodge2(width = 0.9), colour = "white") +
  theme(legend.position="none") +
  xlab("Grupo") + ylab("Cantidad de observaciones")

dev.off()