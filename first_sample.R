library(tidyverse)
library(magrittr)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv") %>% 
  filter(File %in% c("M4_01.csv","M6_01.csv","M13_01.csv","M14_01.csv"))

df_long <- df %>% 
  pivot_longer(cols = !c("Group","Sample","File"), names_to = "Wavelength", values_to = "Intensity") %>%
  mutate(Wavelength = as.numeric(substring(Wavelength,2)))

title_string <- function(file)
{
  df %>%
    filter(File == file) %>%
    transmute(title = paste("Group:",Group,", Sample:",Sample,", File: ",File)) %$%
    title
}

for (F in unique(df$File)) {
  pdf(paste0("spc24Oct2019/",str_replace(F,".csv",".pdf")))
  p <- df_long %>% 
    filter(File == F) %>%
    ggplot(aes(x = Wavelength, y = Intensity)) + 
    geom_line() +
    ggtitle(title_string(F))
  print(p)
  dev.off()
}

