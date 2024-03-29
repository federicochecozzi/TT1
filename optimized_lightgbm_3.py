# -*- coding: utf-8 -*-
"""
Created on Sat Jun 10 22:14:44 2023

@author: Federico Checozzi
"""

#https://towardsdatascience.com/hyper-parameter-tuning-in-python-1923797f124f

import pandas as pd
import numpy as np
import os
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split, RandomizedSearchCV
import time
import lightgbm as lgb
from sklearn.metrics import accuracy_score, confusion_matrix
from scipy.stats import uniform
import re

seeds = [911, 277, 307, 349, 101]

file = "Minería_PCAR.csv"
wdir = r"C:\Users\tiama\OneDrive\Documentos\Maestría en minería y exploración de datos\Taller de Tesis 1\TT1\Datos procesados\spc24Oct2019"
os.chdir(wdir)

df = pd.read_csv(file, sep = ';', header = 0, decimal = ',')
df = df.rename(columns = lambda x:re.sub('[^A-Za-z0-9_]+', '', x))

seed = seeds[4]
X_train, X_test, Y_train, Y_test = train_test_split(df.select_dtypes([np.number]), df.Group, test_size=0.2, random_state=seed)

start = time.time()
clf = lgb.LGBMClassifier(random_state=seed)
clf.fit(X=X_train, y=Y_train)
predicted=clf.predict(X_test)
print('Classification of the result is:')
print(accuracy_score(Y_test, predicted))
print(confusion_matrix(Y_test, predicted))
end = time.time()
print('Execution time is:')
print(end - start)

start = time.time()
lgbm=lgb.LGBMClassifier()
parameters = {'num_leaves': [2,4,8,16,32,64,128], 
              #en el caso de tener pocos features usar la lista y no la distribución 
              'colsample_bytree': [0.5,1],
              #'feature_fraction': uniform(loc=0.2, scale=0.8),
              #'min_data_in_leaf': [1,2,4,8,16,32],
              'min_child_samples': [16,20,24,28,32,36],
             'learning_rate': uniform(loc=0.005, scale=0.095),
             #'n_estimators': [50,100,250,500],
             'reg_alpha': [0,0.05,0.1,0.15],
             #'reg_lambda': [0,0.05,0.1,0.15],
             'n_jobs': [-1],
             'random_state': [seed]}
clf=RandomizedSearchCV(lgbm,parameters,scoring='accuracy', n_iter = 500, random_state=seed, verbose = 2)
clf.fit(X=X_train, y=Y_train)
print(clf.best_params_)
predicted=clf.predict(X_test)
print('Classification of the result is:')
print(accuracy_score(Y_test, predicted))
print(confusion_matrix(Y_test, predicted))
end = time.time()
print('Execution time is:')
print(end - start)

results = pd.DataFrame.from_dict(clf.cv_results_)

cm = pd.DataFrame(confusion_matrix(Y_test, predicted), columns = ['04_02', '05_01', '09_02', '12_02'], index = ['04_02', '05_01', '09_02', '12_02'])
cm = cm.loc[['04_02', '05_01', '09_02', '12_02'],['04_02', '05_01', '09_02', '12_02']]

sns.set(font_scale=1.5)

sns.heatmap(cm,annot=True,fmt='g', cbar = False)
plt.xlabel('Pred')
plt.ylabel('Real');

