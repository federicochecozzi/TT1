require("lightgbm")
library(tidyverse)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv") 

#https://www.datatechnotes.com/2022/05/lightgbm-multi-class-classification.html

dtrain  <- lgb.Dataset( data= data.matrix(df %>% select(where(is.numeric))),
                        label= as.numeric(as.factor(df$Group)) - 1 )

model  <- lgb.train( data= dtrain, objective = "multiclass", num_class = 4)

tree_imp = lgb.importance(model)#, percentage = T)
as.data.frame( tree_imp )
lgb.plot.importance(tree_imp, measure = "Gain")

WI <- as.numeric(substring(tree_imp$Feature,2))

df_long1 <- df %>%
  filter(File == "M14_01.csv") %>%
  pivot_longer(cols = !c("Group","Sample","File"), names_to = "Wavelength", values_to = "Intensity") %>%
  mutate(Wavelength = as.numeric(substring(Wavelength,2))) %>%
  mutate(Important = Wavelength %in% WI[1:250])

df_long1 %>%
  ggplot(aes(x = Wavelength, y = Intensity)) + 
  geom_line() + 
  geom_point(data = df_long1 %>% filter(Important == TRUE), aes(x = Wavelength, y = Intensity, color = Important)) +
  theme(legend.position="none")

df_long2 <- df %>%
  filter(File == "M6_01.csv") %>%
  pivot_longer(cols = !c("Group","Sample","File"), names_to = "Wavelength", values_to = "Intensity") %>%
  mutate(Wavelength = as.numeric(substring(Wavelength,2))) %>%
  mutate(Important = Wavelength %in% WI[1:250])

df_long2 %>%
  ggplot(aes(x = Wavelength, y = Intensity)) + 
  geom_line() + 
  geom_point(data = df_long2 %>% filter(Important == TRUE), aes(x = Wavelength, y = Intensity, color = Important)) +
  theme(legend.position="none")

df_long3 <- df %>%
  filter(File == "M13_01.csv") %>%
  pivot_longer(cols = !c("Group","Sample","File"), names_to = "Wavelength", values_to = "Intensity") %>%
  mutate(Wavelength = as.numeric(substring(Wavelength,2))) %>%
  mutate(Important = Wavelength %in% WI[1:250])

df_long3 %>%
  ggplot(aes(x = Wavelength, y = Intensity)) + 
  geom_line() + 
  geom_point(data = df_long3 %>% filter(Important == TRUE), aes(x = Wavelength, y = Intensity, color = Important)) +
  theme(legend.position="none")

df_long4 <- df %>%
  filter(File == "M4_01.csv") %>%
  pivot_longer(cols = !c("Group","Sample","File"), names_to = "Wavelength", values_to = "Intensity") %>%
  mutate(Wavelength = as.numeric(substring(Wavelength,2))) %>%
  mutate(Important = Wavelength %in% WI[1:250])

df_long4 %>%
  ggplot(aes(x = Wavelength, y = Intensity)) + 
  geom_line() + 
  geom_point(data = df_long4 %>% filter(Important == TRUE), aes(x = Wavelength, y = Intensity, color = Important)) +
  theme(legend.position="none")