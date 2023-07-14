library(tidyverse)

ncomp <- 90

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv")

start_time <- Sys.time()

pca <- prcomp(df %>% select(where(is.numeric)), rank = ncomp)

end_time <- Sys.time()

end_time - start_time

df <-  df %>% select(negate(where(is.numeric))) %>%
  bind_cols(pca$x)

write.csv2(df,"spc24Oct2019/Minería_PCA.csv", row.names = FALSE)
