#!/usr/bin/python3

import pandas as pd
import numpy as np


# Reading files
foglalas = pd.read_csv('/home/matt/automation/all_idopont.csv', encoding = "utf-8", sep=',') # encoding = "ISO-8859-1",
ajandek = pd.read_csv('/home/matt/automation/all_ajandek.csv', encoding = "utf-8", sep=',')

# ajandek = 0, idopont = 1
ajandek['foglalas_mod'] = 'ajandek' # 0
foglalas['foglalas_mod'] = 'foglalas' # 1

# Merge tables
df = pd.concat([ajandek, foglalas])


# Filtering

# Filtering emails

email_szures = ["random@gmail.com", "random1@gmail.com", "random3@gmail.com", "random4@gmail.com"]
df = df[(df['email'] != 'random@gmail.com') & (df['email'] != 'random1@gmail.com') \
           & (df['email'] != 'random2@gmail.com') & (df['email'] != 'random3@gmail.com')]

# Filter unncesseary headers as rows (if it remained)
df = df[df['id'] != 'id']



# Convert subdate to week
df['subdate'] = pd.to_datetime(df['subdate'],  errors='coerce').astype('datetime64[W]')



# Report

# Ordered items
 termekek = {"Alap vezetés": "Alap", "Prémium vezetés": "Prémium", "Exkluzív vezetés": "Exkluzív", \
            'Prémium vezetés ': "Prémium", "Alap vezetés ": "Alap"}

df['ordered_items'] = df['ordered_items'].map(termekek)


kimutatas = df.groupby(['subdate', 'foglalas_mod'])['ordered_items'].value_counts().to_frame() # .reset_index() # .reset_index(level=[0,1])

kimutatas2 = kimutatas.unstack().fillna(0) # .reset_index()

kimutatas3 = pd.DataFrame(kimutatas2.reset_index().to_records()).drop('index', axis=1)
kimutatas3.columns = ['ido', 'foglalas_mod', 'alap', 'exkluziv', 'premium']
kimutatas3['ossz'] = kimutatas3['alap'] + kimutatas3['exkluziv'] + kimutatas3['premium']


kimutatas3['alap'] = kimutatas3['alap'].astype(int)
kimutatas3['exkluziv'] = kimutatas3['exkluziv'].astype(int)
kimutatas3['premium'] = kimutatas3['premium'].astype(int)
kimutatas3['ossz'] = kimutatas3['ossz'].astype(int)


kimutatas3.to_csv('/home/matt/automation/kimutatas_ordered_items.csv',sep=',', index=False, header=False)


# Payment method
fizetes_mod = df.groupby('foglalas_mod')['shipping_mode'].value_counts().to_frame()
fizetes_mod.columns = ['osszesen']
fizetes_mod = fizetes_mod.reset_index()
fizetes_mod.to_csv('/home/matt/automation/kimutatas_fizetes_mod.csv', sep=';', index=False, header=False)


## City distribtuion
varosok = df['booked_to'].value_counts().reset_index()
varosok.columns = ['city', 'booked_to']
varosok.to_csv('/home/matt/automation/kimutatas_varosok.csv', index=False, sep=',', header=False)


## Emails distribution
emailek = df['email'].str.split('@').str.get(-1).value_counts().to_frame().reset_index()
emailek.columns = ['Domain', 'Mennyiség']
emailek.to_csv('/home/matt/automation/kimutatas_email_eloszlas.csv', sep=',', index=False, header=False)


## Another version of weekly report
heti_lebontas_2 = df.groupby(['subdate','ordered_items'])['foglalas_mod'].value_counts().to_frame().unstack().fillna(0)
heti_lebontas_2 = pd.DataFrame(heti_lebontas_2.reset_index().to_records()).drop('index', axis=1)
heti_lebontas_2.columns = ['Date','Termek', 'ajandek', 'Idopont']
heti_lebontas_2['ossz'] = heti_lebontas_2['ajandek'] + heti_lebontas_2['Idopont']
heti_lebontas_2.to_csv('kimutatas_heti_lebontas_2.csv',sep=',', index=False, header=False)
