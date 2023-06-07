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
import seaborn as sns
from umap import UMAP
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

seed = seeds[4]

start = time.time()

um = UMAP()#random_state = seed)
Xred = um.fit_transform(X) 
end = time.time()
print('Execution time is:')
print(end - start)

#Pasar a seaborn, esto luce feo
#plt.scatter(Xred[:,0],Xred[:,1],c=[color_dict[s] for s in list(y)],cmap=plt.cm.Set1,alpha=0.7)
#plt.colorbar(ticks=range(4));

sns.scatterplot(x = Xred[:,0],y = Xred[:,1], hue = y,alpha=0.7)
plt.xlabel("Primera dimensión")
plt.ylabel("Segunda dimensión")

df_umap = pd.DataFrame({'dim1': Xred[:,0], 'dim2': Xred[:,1], 'Group': y})
df_umap.to_csv('Datos procesados/spc24Oct2019/Minería_UMAP.csv', sep = ';', decimal = ',', index = False)