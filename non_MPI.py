#collective.py
#example to run: mpiexec -n 4 python collective.py 10000 
import time
from astropy.table import Table
import numpy as np
import pandas as pd
import sys
import functions.cython.BB as BB
from mpi4py import MPI

t0 = time.time()

file1 = '/Users/matias/Documents/Data/_10-result.fits.gz'
dat = Table.read(file1,format='fits')
df = dat.to_pandas()
df = df.dropna(subset=['bp_rp'])
df['dist'] = 1000./df['parallax']
df['g_abs'] = df['phot_g_mean_mag'] - 5*np.log10(df['dist']/10)
df['w1_abs'] = df['w1mpro'] - 5*np.log10(df['dist']/10)
df['w2_abs'] = df['w2mpro'] - 5*np.log10(df['dist']/10)
df['w3_abs'] = df['w3mpro'] - 5*np.log10(df['dist']/10)
df['w4_abs'] = df['w4mpro'] - 5*np.log10(df['dist']/10)
df['g_w1'] = df['phot_g_mean_mag'] - df['w1mpro']
df['g_w2'] = df['phot_g_mean_mag'] - df['w2mpro']
df['g_w3'] = df['phot_g_mean_mag'] - df['w3mpro']
df['g_w4'] = df['phot_g_mean_mag'] - df['w4mpro']
#I need luminosities
#Stars with luminosities
df_yes = df.dropna(subset=['lum_val'])
df_yes = df_yes.reset_index(drop=True)
#Stars without luminosities
df_no = df[df['lum_val'].isnull()]
df_no = df_no.reset_index(drop=True)
df_no['lum_val'] = 10**(-4.98050389e-04*df_no['g_abs']**3 + 1.64079645e-02*df_no['g_abs']**2 -4.87229162e-01*df_no['g_abs'] + 1.98621692e+00)

frames = [df_yes,df_no]
df_center= pd.concat(frames)

tt = 100
ee = 5e-1

df_count = df_center 

w4dstop = BB.W4_DS(np.array(df_count['w4_abs']),tt,np.array(df_count['lum_val']),ee)
gdstop = np.array(df_count['phot_g_mean_mag']) - 2.5*np.log10(1 - ee)
Gdstop = gdstop - 5*np.log10(df_count['dist']/10.)

print("Execution time :",time.time()-t0,' s')
