# -*- coding: utf-8 -*-
"""
Created on Mon Jun  5 22:27:22 2023

@author: Federico Checozzi
"""

import pandas as pd
import numpy as np
import os

file = "Resultados de clasificación.csv"
wdir = r"C:\Users\tiama\OneDrive\Documentos\Maestría en minería y exploración de datos\Taller de Tesis 1\TT1\Datos procesados\spc24Oct2019"
os.chdir(wdir)

df = pd.read_csv(file, sep = ';', header = 0, decimal = ',')

df.groupby(by = 'Method').mean()