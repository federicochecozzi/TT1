library(tidyverse)
library(magrittr)

setwd("C://Users//tiama//OneDrive//Documentos//Maestría en minería y exploración de datos//Taller de Tesis 1//TT1//Datos procesados")

#podría haber usado stat_summary

df <- read.csv2("spc24Oct2019/Minería.csv") %>%
  select(where(is.numeric)|contains("Group")) %>%
  group_by(Group) %>%
  summarise_all(median)

df_long <- df %>% 
  pivot_longer(cols = !c("Group"), names_to = "Wavelength", values_to = "Intensity") %>%
  mutate(Wavelength = as.numeric(substring(Wavelength,2)))

for (G in unique(df$Group)) {
  pdf(paste0("spc24Oct2019/median_",G,".pdf"))
  p <- df_long %>% 
    filter(Group == G) %>%
    ggplot(aes(x = Wavelength, y = Intensity)) + 
    geom_line() +
    ylim(-10,2750) +
    theme(text = element_text(size = 20)) +
    labs(x = "Longitud de onda (nm)",y = "Intensidad (a.u.)")
  print(p)
  dev.off()
}