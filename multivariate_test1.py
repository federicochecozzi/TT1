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

spectredf = pd.read_csv('Datos procesados/spc24Oct2019/Minería.csv', sep = ';', decimal = ',').query("Group == '04_02'").drop(columns = ['Group','Sample','File'])

pg.multivariate_normality(spectredf, alpha=.05)
