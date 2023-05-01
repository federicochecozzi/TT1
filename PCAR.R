library(tidyverse)
library(rospca)

ncomp <- 90

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv")

pcar <- robpca(df %>% select(where(is.numeric)), k = ncomp, kmax = 156)
df <-  df %>% select(negate(where(is.numeric))) %>%
  bind_cols(pcar$scores)

write.csv2(df,"spc24Oct2019/Minería_PCAR.csv", row.names = FALSE)
