library(tidyverse)
library(rospca)

ncomp <- 90

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv")

seeds <- c(911, 277, 307, 349, 101)
set.seed(seeds[1])

start_time <- Sys.time()

pcar <- robpca(df %>% select(where(is.numeric)), k = ncomp, kmax = 156)

end_time <- Sys.time()

end_time - start_time

df <-  df %>% select(negate(where(is.numeric))) %>%
  bind_cols(pcar$scores)

write.csv2(df,"spc24Oct2019/Minería_PCAR.csv", row.names = FALSE)
