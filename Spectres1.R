library(tidyverse)
library(magrittr)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv") %>% 
  group_by(Group) %>% 
  mutate(Group_number = row_number())

df_long <- df %>% 
  pivot_longer(cols = !c("Group","Group_number","Sample","File"), names_to = "Wavelength", values_to = "Intensity") %>%
  mutate(Wavelength = as.numeric(substring(Wavelength,2)))

title_string <- function(file)
{
  # df_row <- df %>%
  #   filter(File == file) %>%
  #   transmute(title = paste("Group:",Group,", Group_number:",Group_number,", Sample:",Sample,", File: ",File))
  # df_row$title
  df %>%
    filter(File == file) %>%
    transmute(title = paste("Group:",Group,", Group_number:",Group_number,", Sample:",Sample,", File: ",File)) %$%
    title
}

#Prueba con un solo espectro
df_long %>% 
  filter(File == "M14_01.csv") %>%
  ggplot(aes(x = Wavelength, y = Intensity)) + 
  geom_line() +
  ggtitle(title_string("M14_01.csv"))

for (F in unique(df$File)) {
  print(title_string(F))
}

pdf("spc24Oct2019/espectros.pdf")

for (F in unique(df$File)) {
  print(F)
  p <- df_long %>% 
    filter(File == F) %>%
    ggplot(aes(x = Wavelength, y = Intensity)) + 
    geom_line() +
    ggtitle(title_string(F))
  print(p)
}

dev.off()