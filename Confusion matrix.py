# -*- coding: utf-8 -*-
"""
Created on Sat Jun 10 22:38:28 2023

@author: Federico Checozzi
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

#Matriz de confusión de LDA
c_matrix = np.array([[1,0,0,0],[0,11,0,1],[0,0,10,0],[0,0,0,9]])

cm = pd.DataFrame(c_matrix, columns = ['04_02', '05_01', '09_02', '12_02'], index = ['04_02', '05_01', '09_02', '12_02'])
cm = cm.loc[['04_02', '05_01', '09_02', '12_02'],['04_02', '05_01', '09_02', '12_02']]

plt.figure()
sns.set(font_scale=1.5)

sns.heatmap(cm,annot=True,fmt='g', cbar = False)
plt.xlabel('Pred')
plt.ylabel('Real');

#Matriz de confusión de LDA - PCAR
c_matrix = np.array([[1,0,0,0],[0,12,0,0],[0,0,8,2],[0,0,0,9]])

cm = pd.DataFrame(c_matrix, columns = ['04_02', '05_01', '09_02', '12_02'], index = ['04_02', '05_01', '09_02', '12_02'])
cm = cm.loc[['04_02', '05_01', '09_02', '12_02'],['04_02', '05_01', '09_02', '12_02']]

plt.figure()
sns.set(font_scale=1.5)

sns.heatmap(cm,annot=True,fmt='g', cbar = False)
plt.xlabel('Pred')
plt.ylabel('Real');

#Matriz de confusión de QDA - PCAR
c_matrix = np.array([[8,0,0,0],[1,7,0,0],[0,0,8,0],[4,0,0,4]])

cm = pd.DataFrame(c_matrix, columns = ['04_02', '05_01', '09_02', '12_02'], index = ['04_02', '05_01', '09_02', '12_02'])
cm = cm.loc[['04_02', '05_01', '09_02', '12_02'],['04_02', '05_01', '09_02', '12_02']]

plt.figure()
sns.set(font_scale=1.5)

sns.heatmap(cm,annot=True,fmt='g', cbar = False)
plt.xlabel('Pred')
plt.ylabel('Real');
