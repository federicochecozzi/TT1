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
import time

seeds = [911, 277, 307, 349, 101]

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

seed = seeds[0]

start = time.time()

som = MiniSom(8, 8, 7797, learning_rate=0.3, sigma=1, neighborhood_function='gaussian', random_seed = seed)
som.pca_weights_init(X.to_numpy())
som.train_random(X.to_numpy(), 10000)  # random training

Xred = np.zeros((len(X.to_numpy()),2))
for i, (x, t) in enumerate(zip(X.to_numpy(), y)):  # scatterplot
    Xred[i,:] = som.winner(x)

end = time.time()
print('Execution time is:')
print(end - start)

plt.scatter(Xred[:,0],Xred[:,1],c=[color_dict[s] for s in list(y)],cmap=plt.cm.Set1,alpha=0.7)
plt.colorbar();

#plt.scatter(Xred[:,0] + np.random.uniform(0, 0.25, 156),Xred[:,1] + np.random.uniform(0, 0.25, 156) ,c=[color_dict[s] for s in list(y)],cmap=plt.cm.Set1,alpha=0.7)
#plt.colorbar();

df_som = pd.DataFrame({'x': Xred[:,0],'y': Xred[:,1], 'Group': y})

df_som.to_csv('Datos procesados/spc24Oct2019/Minería_SOM.csv', sep = ';', decimal = ',', index = False)