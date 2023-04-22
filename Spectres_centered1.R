library(tidyverse)
library(magrittr)
library(rospca)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv") 

title_string <- function(file,dfi)
{
  dfi %>%
    filter(File == file) %>%
    transmute(title = paste("Group:",Group,", Sample:",Sample,", File: ",File)) %$%
    title
}

# plot_spectre <- function(d, ymin, ymax){
#   ggplot(d,aes(x = Wavelength, y = Intensity)) + 
#     geom_line() +
#     theme(legend.position="none") + 
#     ylim(ymin,ymax) 
# }

#Grupo 1

df1 <- df %>%
  filter(Group == "04_02")

pcar1 <- robpca(df1 %>% select(where(is.numeric)))

df1 <- df1 %>% select(where(negate(is.numeric))) %>% 
  bind_cols(t(t(df1 %>% select(where(is.numeric))) - pcar1$center))

df1_long <- df1 %>% 
  pivot_longer(cols = !c("Group","Sample","File"), names_to = "Wavelength", values_to = "Intensity") %>%
  mutate(Wavelength = as.numeric(substring(Wavelength,2)))

pdf("spc24Oct2019/spectres_centered_04_02.pdf")

for (F in unique(df1$File)) {
  print(F)
  p <- df1_long %>% 
    filter(File == F) %>%
    ggplot(aes(x = Wavelength, y = Intensity)) + 
    geom_line() +
    ggtitle(title_string(F,df1))
  print(p)
}

dev.off()

pdf("spc24Oct2019/outliers_04_02.pdf")

outliers1 <- c("M14_04.csv","M14_13.csv","M14_17.csv","M2_17.csv")

df1_long %>% 
  filter(!File %in% outliers1) %>%
  ggplot(aes(x = Wavelength, y = Intensity, color = File)) + 
  geom_line() +
  theme(legend.position="none") + 
  ylim(-600,600)

df1_long %>% 
  filter(File %in% outliers1) %>% 
  split(df_long %>% filter(File %in% outliers1) %$% File) %>%
  lapply(function(d){
    ggplot(d,aes(x = Wavelength, y = Intensity)) + 
      geom_line() +
      theme(legend.position="none") + 
      ylim(-600,600) 
  })

dev.off()

#Grupo 2

df2 <- df %>%
  filter(Group == "05_01")

pcar2 <- robpca(df2 %>% select(where(is.numeric)))

df2 <- df2 %>% select(where(negate(is.numeric))) %>% 
  bind_cols(t(t(df2 %>% select(where(is.numeric))) - pcar2$center))

df2_long <- df2 %>% 
  pivot_longer(cols = !c("Group","Sample","File"), names_to = "Wavelength", values_to = "Intensity") %>%
  mutate(Wavelength = as.numeric(substring(Wavelength,2)))

pdf("spc24Oct2019/spectres_centered_05_01.pdf")

for (F in unique(df2$File)) {
  print(F)
  p <- df2_long %>% 
    filter(File == F) %>%
    ggplot(aes(x = Wavelength, y = Intensity)) + 
    geom_line() +
    ggtitle(title_string(F,df2))
  print(p)
}

dev.off()

pdf("spc24Oct2019/outliers_05_01.pdf")

outliers2 <- c("M6_02.csv","M6_04.csv","M6_05.csv","M6_09.csv",
               "M9_08.csv","M9_10.csv","M9_14.csv","M6_15.csv")

df2_long %>% 
  filter(!File %in% outliers2) %>%
  ggplot(aes(x = Wavelength, y = Intensity, color = File)) + 
  geom_line() +
  theme(legend.position="none") + 
  ylim(-400,400)

df2_long %>% 
  filter(File %in% outliers2) %>% 
  split(df2_long %>% filter(File %in% outliers2) %$% File) %>%
  lapply(function(d){
    ggplot(d,aes(x = Wavelength, y = Intensity)) + 
      geom_line() +
      theme(legend.position="none") + 
      ylim(-400,400) 
  })

dev.off()

#Grupo 3

df3 <- df %>%
  filter(Group == "09_02")

pcar3 <- robpca(df3 %>% select(where(is.numeric)))

df3 <- df3 %>% select(where(negate(is.numeric))) %>% 
  bind_cols(t(t(df3 %>% select(where(is.numeric))) - pcar3$center))

df3_long <- df3 %>% 
  pivot_longer(cols = !c("Group","Sample","File"), names_to = "Wavelength", values_to = "Intensity") %>%
  mutate(Wavelength = as.numeric(substring(Wavelength,2)))

pdf("spc24Oct2019/spectres_centered_09_02.pdf")

for (F in unique(df3$File)) {
  print(F)
  p <- df3_long %>% 
    filter(File == F) %>%
    ggplot(aes(x = Wavelength, y = Intensity)) + 
    geom_line() +
    ggtitle(title_string(F,df3))
  print(p)
}

dev.off()

pdf("spc24Oct2019/outliers_09_02.pdf")

outliers3 <- c("M8_12.csv","M13_12.csv")

df3_long %>% 
  filter(!File %in% outliers3) %>%
  ggplot(aes(x = Wavelength, y = Intensity, color = File)) + 
  geom_line() +
  theme(legend.position="none") + 
  ylim(-1600,1000)

df3_long %>% 
  filter(File %in% outliers3) %>% 
  split(df3_long %>% filter(File %in% outliers3) %$% File) %>%
  lapply(function(d){
    ggplot(d,aes(x = Wavelength, y = Intensity)) + 
      geom_line() +
      theme(legend.position="none") + 
      ylim(-1600,1000) 
  })

dev.off()

#Grupo 4

df4 <- df %>%
  filter(Group == "12_02")

pcar4 <- robpca(df4 %>% select(where(is.numeric)))

df4 <- df4 %>% select(where(negate(is.numeric))) %>% 
  bind_cols(t(t(df4 %>% select(where(is.numeric))) - pcar4$center))

df4_long <- df4 %>% 
  pivot_longer(cols = !c("Group","Sample","File"), names_to = "Wavelength", values_to = "Intensity") %>%
  mutate(Wavelength = as.numeric(substring(Wavelength,2)))

pdf("spc24Oct2019/spectres_centered_12_02.pdf")

for (F in unique(df4$File)) {
  print(F)
  p <- df4_long %>% 
    filter(File == F) %>%
    ggplot(aes(x = Wavelength, y = Intensity)) + 
    geom_line() +
    ggtitle(title_string(F,df4))
  print(p)
}

dev.off()

pdf("spc24Oct2019/outliers_12_02.pdf")

outliers4 <- c("M4_18.csv","M5_08.csv","M5_09.csv","M5_10.csv","M5_13.csv","M5_16.csv")

df4_long %>% 
  filter(!File %in% outliers4) %>%
  ggplot(aes(x = Wavelength, y = Intensity, color = File)) + 
  geom_line() +
  theme(legend.position="none") + 
  ylim(-400,700)

df4_long %>% 
  filter(File %in% outliers4) %>% 
  split(df4_long %>% filter(File %in% outliers4) %$% File) %>%
  lapply(function(d){
    ggplot(d,aes(x = Wavelength, y = Intensity)) + 
      geom_line() +
      theme(legend.position="none") + 
      ylim(-400,700) 
  })

dev.off()
