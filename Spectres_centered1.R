library(tidyverse)
library(magrittr)
library(rospca)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv") %>%
  filter(Group == "04_02")

pcar <- robpca(df %>% select(where(is.numeric)))

df <- df %>% select(where(negate(is.numeric))) %>% 
  bind_cols(t(t(df %>% select(where(is.numeric))) - pcar$center))

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


pdf("spc24Oct2019/spectres_centered_04_02.pdf")

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

pdf("spc24Oct2019/outliers_04_02.pdf")

outliers1 <- c("M14_04.csv","M14_13.csv","M14_17.csv","M2_17.csv")

df_long %>% 
  filter(!File %in% outliers1) %>%
  ggplot(aes(x = Wavelength, y = Intensity, color = File)) + 
  geom_line() +
  theme(legend.position="none") + 
  ylim(-600,600)

# df_long %>% 
#   filter(File %in% outliers1) %>%
#   ggplot(aes(x = Wavelength, y = Intensity, color = File)) + 
#   geom_line() +
#   theme(legend.position="none") + 
#   ylim(-600,600)

df_long %>% 
  filter(File %in% outliers1) %>% 
  split(df_long %>% filter(File %in% outliers1) %$% File) %>%
  lapply(function(d){
    ggplot(d,aes(x = Wavelength, y = Intensity)) + 
      geom_line() +
      theme(legend.position="none") + 
      ylim(-600,600) 
  })

dev.off()