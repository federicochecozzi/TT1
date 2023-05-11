# -*- coding: utf-8 -*-
"""
Created on Mon May  8 22:45:03 2023

@author: Federico Checozzi
"""

import pandas as pd
import os
import pingouin as pg

wdir = r"C:\Users\tiama\OneDrive\Documentos\Maestría en minería y exploración de datos\Taller de Tesis 1\TT1"
os.chdir(wdir)

#Tests por grupos
spectredf = pd.read_csv('Datos procesados/spc24Oct2019/Minería_PCAR.csv', sep = ';', decimal = ',').drop(columns = ['Sample','File'])

spectredf.groupby(by = ['Group']).apply(lambda x: pg.multivariate_normality(x))

#Tests por grupos sin outliers
outlier_list = ["M14_04.csv","M14_13.csv","M14_17.csv","M2_17.csv","M6_02.csv","M6_04.csv","M6_05.csv","M6_09.csv",
               "M9_08.csv","M9_10.csv","M9_14.csv","M6_15.csv","M8_12.csv","M13_12.csv","M4_18.csv","M5_08.csv",
               "M5_09.csv","M5_10.csv","M5_13.csv","M5_16.csv"]

spectredf = pd.read_csv('Datos procesados/spc24Oct2019/Minería_PCAR.csv', sep = ';', decimal = ',').query("File not in @outlier_list").drop(columns = ['Sample','File'])

spectredf.groupby(by = ['Group']).apply(lambda x: pg.multivariate_normality(x))