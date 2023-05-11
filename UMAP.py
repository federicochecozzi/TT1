# -*- coding: utf-8 -*-
"""
Created on Wed May 10 22:36:32 2023

@author: Federico Checozzi
"""

import pandas as pd
import os
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib as mpl
from umap import UMAP

wdir = r"C:\Users\tiama\OneDrive\Documentos\Maestría en minería y exploración de datos\Taller de Tesis 1\TT1"
os.chdir(wdir)

#Advertencia: tarda mucho en correr, preferiblemente correr por partes con F9

#Tests por muestras
spectredf = pd.read_csv('Datos procesados/spc24Oct2019/Minería.csv', sep = ';', decimal = ',').drop(columns = ['Sample','File'])

X = spectredf.drop(columns = ['Group'])
y = spectredf['Group']

color_dict = {
    "04_02": 0,
    "05_01": 1,
    "09_02": 2,
    "12_02": 3
    }

um = UMAP(n_neighbors=100)
Xred = um.fit_transform(X)

#Pasar a seaborn, esto luce feo
plt.scatter(Xred[:,0],Xred[:,1],c=[color_dict[s] for s in list(y)],cmap=plt.cm.Set1,alpha=0.7)
plt.colorbar(ticks=range(4));