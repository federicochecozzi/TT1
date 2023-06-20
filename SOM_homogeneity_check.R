library(tidyverse)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería_SOM.csv")

#Revisa coordenadas con más de un espectro asociado
df_filtered <- df %>% 
  group_by(x,y) %>%
  filter(n() > 1) %>%
  arrange(x,y)

#Número de coordenadas únicas con al menos dos espectros asociados
sum(!duplicated(df_filtered %>% select(-Group)))

#Chequeo de homogeneidad en cada coordenada (si la cantidad de grupos presente es 1 o más)
f <- function(vector){
  if (length(unique(vector)) > 1){
    return(FALSE)
    #return(tibble(homogeneous = FALSE))
  }else{
    return(TRUE)
    #return(tibble(homogeneous = TRUE))
  }
}

homogeneity_checks <- df_filtered %>%
  group_by(x,y) %>%
  summarise(homogeneous = f(Group), .groups = 'keep')
  #group_map(~f(.x$Group))
