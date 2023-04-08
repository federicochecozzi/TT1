# -*- coding: utf-8 -*-
"""
Created on Sat Apr  8 15:11:33 2023

@author: Federico Checozzi
"""

import pandas as pd
import os
import glob

wdir = r"C:\Users\tiama\OneDrive\Documentos\Maestría en minería y exploración de datos\Taller de Tesis 1\TT1"
os.chdir(wdir)

files = glob.glob('Datos/Mediciones2019/*/*.ols')
datalabels = {f : f.split("\\") for f in files}
spectredf = pd.concat([pd.read_csv(file, sep = '\t', header = 5, decimal = '.', usecols = [0, 1]).assign(Group = labels[1] ,File = labels[2]) for file,labels in datalabels.items()], ignore_index=True).pipe(pd.pivot_table, values="Counts", index=["Group","File"],columns=["Wavelength"])
os.makedirs('Datos procesados/Mediciones2019', exist_ok=True)  
spectredf.to_csv('Datos procesados/Mediciones2019/Calcio.csv', sep = ';', decimal = ',')
