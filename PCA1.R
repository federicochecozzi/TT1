library(tidyverse)
library(ggfortify)
library(rospca)
library(magrittr)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

df <- read.csv2("spc24Oct2019/Minería.csv")

#PCA general

pca <- df %>% 
  select(where(is.numeric)) %>%
  prcomp()

screeplot(pca, type = "l", npcs = 156)
abline(h = 1, col="red", lty=5)
legend("topright", legend=c("Autovalor = 1"),
       col=c("red"), lty=5, cex=0.6)

prop_variance <- pca$sdev^2 / sum(pca$sdev^2)
prop_variance_cum <- cumsum(prop_variance)

ggplot(data = data.frame(prop_variance_cum, pc = 1:156), 
       aes(x = pc, y = prop_variance_cum, group = 1)) +
  geom_col(width = 0.3, fill = 'slateblue3') +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")

autoplot(pca, data = df, colour = 'Group', alpha = 0.5)#, loadings = FALSE, 
         #loadings.colour = 'black', loadings.label = TRUE, loadings.label.size = 3)

pcar <- robpca(df %>% select(where(is.numeric)), k = 2)

#screeplot(pcar, type = "l", npcs = 10)
prop_variance_r <- pcar$eigenvalues / sum(pcar$eigenvalues)
prop_variance_cum_r <- cumsum(prop_variance_r)

ggplot(data = data.frame(prop_variance_cum_r, pc = 1:pcar$k), 
       aes(x = pc, y = prop_variance_cum_r, group = 1)) +
  geom_col(width = 0.3, fill = 'slateblue3') +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")

pcar$scores %>%
  ggplot(aes(x = PC1, y = PC2, color = df$Group)) +
  geom_point() +
  labs(color = "Group")

#PCA por grupo
#grupo 1
pca_g1 <- df %>% 
  filter(Group == "04_02") %>%
  select(where(is.numeric)) %>%
  prcomp()
  
prop_variance_g1 <- pca_g1$sdev^2 / sum(pca_g1$sdev^2)
prop_variance_cum_g1 <- cumsum(prop_variance_g1)
  
ggplot(data = data.frame(prop_variance_cum_g1, pc = 1:40), 
         aes(x = pc, y = prop_variance_cum_g1, group = 1)) +
geom_col(width = 0.3, fill = 'slateblue3') +
theme_bw() +
    labs(x = "Componente principal",
         y = "Prop. varianza explicada acumulada")
  
autoplot(pca_g1, data = df %>% filter(Group == "04_02"), colour = 'Sample', alpha = 0.5)

pcar_g1 <- robpca(df %>% filter(Group == "04_02") %>% select(where(is.numeric)))

prop_variance_r_g1 <- pcar_g1$eigenvalues / sum(pcar_g1$eigenvalues)
prop_variance_cum_r_g1 <- cumsum(prop_variance_r_g1)

ggplot(data = data.frame(prop_variance_cum_r_g1, pc = 1:pcar_g1$k), 
       aes(x = pc, y = prop_variance_cum_r_g1, group = 1)) +
  geom_col(width = 0.3, fill = 'slateblue3') +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")

pcar_g1$scores %>%
  ggplot(aes(x = PC1, y = PC2)) +
  geom_point(color = rep(c(1,2), each = 20)) + #esto es para darle un color a cada grupo de muestras, es poco elegante
  theme(text = element_text(size = 20)) 
diagPlot(pcar_g1, id = 4) #4,13,17,37

sum(pcar_g1$flag.all) #cantidad de mediciones que no son atípicas

#grupo 2
pca_g2 <- df %>% 
  filter(Group == "05_01") %>%
  select(where(is.numeric)) %>%
  prcomp()

prop_variance_g2 <- pca_g2$sdev^2 / sum(pca_g2$sdev^2)
prop_variance_cum_g2 <- cumsum(prop_variance_g2)

ggplot(data = data.frame(prop_variance_cum_g2, pc = 1:36), 
       aes(x = pc, y = prop_variance_cum_g2, group = 1)) +
  geom_col(width = 0.3, fill = 'slateblue3') +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")

autoplot(pca_g2, data = df %>% filter(Group == "05_01"), colour = 'Sample', alpha = 0.5)

pcar_g2 <- robpca(df %>% filter(Group == "05_01") %>% select(where(is.numeric)))

prop_variance_r_g2 <- pcar_g2$eigenvalues / sum(pcar_g2$eigenvalues)
prop_variance_cum_r_g2 <- cumsum(prop_variance_r_g2)

ggplot(data = data.frame(prop_variance_cum_r_g2, pc = 1:pcar_g2$k), 
       aes(x = pc, y = prop_variance_cum_r_g2, group = 1)) +
  geom_col(width = 0.3, fill = 'slateblue3') +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")

pcar_g2$scores %>%
  ggplot(aes(x = PC1, y = PC2)) +
  geom_point(color = c(rep(1,times = 16),rep(2,times = 20))) + #esto es para darle un color a cada grupo de muestras, es poco elegante
  theme(text = element_text(size = 20))
  
diagPlot(pcar_g2, id = 7) #2,4,5,9,24,26,30,31

sum(pcar_g2$flag.all) #cantidad de mediciones que no son atípicas

#grupo 3
pca_g3 <- df %>% 
  filter(Group == "09_02") %>%
  select(where(is.numeric)) %>%
  prcomp()

prop_variance_g3 <- pca_g3$sdev^2 / sum(pca_g3$sdev^2)
prop_variance_cum_g3 <- cumsum(prop_variance_g3)

ggplot(data = data.frame(prop_variance_cum_g3, pc = 1:40), 
       aes(x = pc, y = prop_variance_cum_g3, group = 1)) +
  geom_col(width = 0.3, fill = 'slateblue3') +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")

autoplot(pca_g3, data = df %>% filter(Group == "09_02"), colour = 'Sample', alpha = 0.5)

#aparentemente basta con un componente para capturar más del 90% de la varianza
pcar_g3 <- robpca(df %>% filter(Group == "09_02") %>% select(where(is.numeric)), k = 2)

prop_variance_r_g3 <- pcar_g3$eigenvalues / sum(pcar_g3$eigenvalues)
prop_variance_cum_r_g3 <- cumsum(prop_variance_r_g3)

ggplot(data = data.frame(prop_variance_cum_r_g3, pc = 1:pcar_g3$k), 
       aes(x = pc, y = prop_variance_cum_r_g3, group = 1)) +
  geom_col(width = 0.3, fill = 'slateblue3') +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")

#usar con k = 2
pcar_g3$scores %>%
  ggplot(aes(x = PC1, y = PC2)) +
  geom_point(color = rep(c(1,2), each = 20)) + #esto es para darle un color a cada grupo de muestras, es poco elegante
  theme(text = element_text(size = 20))

diagPlot(pcar_g3, id = 2) #12, 32

sum(pcar_g3$flag.all) #cantidad de mediciones que no son atípicas

#grupo 4
pca_g4 <- df %>% 
  filter(Group == "12_02") %>%
  select(where(is.numeric)) %>%
  prcomp()

prop_variance_g4 <- pca_g4$sdev^2 / sum(pca_g4$sdev^2)
prop_variance_cum_g4 <- cumsum(prop_variance_g4)

ggplot(data = data.frame(prop_variance_cum_g4, pc = 1:40), 
       aes(x = pc, y = prop_variance_cum_g4, group = 1)) +
  geom_col(width = 0.3, fill = 'slateblue3') +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")

autoplot(pca_g4, data = df %>% filter(Group == "12_02"), colour = 'Sample', alpha = 0.5)

pcar_g4 <- robpca(df %>% filter(Group == "12_02") %>% select(where(is.numeric)))

prop_variance_r_g4 <- pcar_g4$eigenvalues / sum(pcar_g4$eigenvalues)
prop_variance_cum_r_g4 <- cumsum(prop_variance_r_g4)

ggplot(data = data.frame(prop_variance_cum_r_g4, pc = 1:pcar_g4$k), 
       aes(x = pc, y = prop_variance_cum_r_g4, group = 1)) +
  geom_col(width = 0.3, fill = 'slateblue3') +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")

pcar_g4$scores %>%
  ggplot(aes(x = PC1, y = PC2)) +
  geom_point(color = rep(c(1,2), each = 20)) + #esto es para darle un color a cada grupo de muestras, es poco elegante
  theme(text = element_text(size = 20))

diagPlot(pcar_g4, id = 4) #18,28,29,30,33,36

sum(pcar_g4$flag.all) #cantidad de mediciones que no son atípicas


#PCA robusto con outliers removidos (gracias a que encontré todos los outlieres con los gráficos de diagnóstico)

outlier_list <- c("M14_04.csv","M14_13.csv","M14_17.csv","M2_17.csv","M6_02.csv","M6_04.csv","M6_05.csv","M6_09.csv",
                  "M9_08.csv","M9_10.csv","M9_14.csv","M9_15.csv","M8_12.csv","M13_12.csv","M4_18.csv","M5_08.csv",
                  "M5_09.csv","M5_10.csv","M5_13.csv","M5_16.csv")

pcarb <- robpca(df %>% filter(!File %in% outlier_list) %>% select(where(is.numeric)), k = 2)

prop_variance_rb <- pcarb$eigenvalues / sum(pcarb$eigenvalues)
prop_variance_cum_rb <- cumsum(prop_variance_rb)

ggplot(data = data.frame(prop_variance_cum_rb, pc = 1:pcarb$k), 
       aes(x = pc, y = prop_variance_cum_rb, group = 1)) +
  geom_col(width = 0.3, fill = 'slateblue3') +
  theme_bw() +
  labs(x = "Componente principal",
       y = "Prop. varianza explicada acumulada")

pcarb$scores %>%
  ggplot(aes(x = PC1, y = PC2, color = df %>% filter(!File %in% outlier_list) %$% Group)) +
  geom_point() +
  labs(color = 'Group') + 
  theme(text = element_text(size = 20)) 

