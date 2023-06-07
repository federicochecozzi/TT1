# -*- coding: utf-8 -*-
"""
Created on Sat Apr 29 20:31:23 2023

@author: Federico Checozzi
"""

#https://towardsdatascience.com/hyper-parameter-tuning-in-python-1923797f124f

import pandas as pd
import numpy as np
import os
from sklearn.model_selection import train_test_split, RandomizedSearchCV
import time
import lightgbm as lgb
from sklearn.metrics import accuracy_score, confusion_matrix
from scipy.stats import uniform
import re

seeds = [911, 277, 307, 349, 101]

file = "Minería_PCAR.csv" #"Minería.csv","Minería_SOM.csv"
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
              #en el caso de tener pocos features usar la lista y no la distribución [0.5,1],
              'feature_fraction': uniform(loc=0.2, scale=0.8),
              'min_data_in_leaf': [2,4,8,16,32],
             'learning_rate': uniform(loc=0.005, scale=0.295)}
clf=RandomizedSearchCV(lgbm,parameters,scoring='accuracy',n_iter=100, random_state=seed)
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

#{'feature_fraction': 0.9630324699363759, 'learning_rate': 0.27610794631607066, 'min_data_in_leaf': 4, 'num_leaves': 128}
#0.9375