# -*- coding: utf-8 -*-
"""
Created on Wed May 10 22:58:49 2023

@author: Federico Checozzi
"""

import pandas as pd
import os
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib as mpl
import numpy as np
from minisom import MiniSom

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

som = MiniSom(10, 10, 7797, learning_rate=0.001, sigma=1, neighborhood_function='gaussian')
som.pca_weights_init(X.to_numpy())
som.train_random(X.to_numpy(), 1000)  # random training

Xred = np.zeros((len(X.to_numpy()),2))
for i, (x, t) in enumerate(zip(X.to_numpy(), y)):  # scatterplot
    Xred[i,:] = som.winner(x)
    
plt.scatter(Xred[:,0],Xred[:,1],c=[color_dict[s] for s in list(y)],cmap=plt.cm.Set1,alpha=0.7)
plt.colorbar();