# -*- coding: utf-8 -*-
"""
Created on Sat Apr  8 20:10:38 2023

@author: Federico Checozzi
"""

import pandas as pd
import os
import pingouin as pg

wdir = r"C:\Users\tiama\OneDrive\Documentos\Maestría en minería y exploración de datos\Taller de Tesis 1\TT1"
os.chdir(wdir)

#Advertencia: tarda mucho en correr, preferiblemente correr por partes con F9

#Tests por muestras
spectredf = pd.read_csv('Datos procesados/spc24Oct2019/Minería.csv', sep = ';', decimal = ',').drop(columns = ['Group','File'])
#.query("Group == '04_02'").drop(columns = ['Group','Sample','File'])

#pg.multivariate_normality(spectredf, alpha=.05)
spectredf.groupby(by = ['Sample']).apply(lambda x: pg.multivariate_normality(x))

#Tests por grupos
spectredf = pd.read_csv('Datos procesados/spc24Oct2019/Minería.csv', sep = ';', decimal = ',').drop(columns = ['Sample','File'])

spectredf.groupby(by = ['Group']).apply(lambda x: pg.multivariate_normality(x))

#Tests por grupos sin outliers
outlier_list = ["M14_04.csv","M14_13.csv","M14_17.csv","M2_17.csv","M6_02.csv","M6_04.csv","M6_05.csv","M6_09.csv",
               "M9_08.csv","M9_10.csv","M9_14.csv","M6_15.csv","M8_12.csv","M13_12.csv","M4_18.csv","M5_08.csv",
               "M5_09.csv","M5_10.csv","M5_13.csv","M5_16.csv"]

spectredf = pd.read_csv('Datos procesados/spc24Oct2019/Minería.csv', sep = ';', decimal = ',').query("File not in @outlier_list").drop(columns = ['Sample','File'])

spectredf.groupby(by = ['Group']).apply(lambda x: pg.multivariate_normality(x))