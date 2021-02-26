import numpy as np
cimport numpy as np
from scipy.interpolate import interp2d

######################################################
##  Blackbody model for the dyson spheres 5 - 1000 K ##
######################################################
w4_data = '/Users/matias/Documents/Codes_PhD/W4_mags.txt'
w3_data = '/Users/matias/Documents/Codes_PhD/W3_mags.txt'
w2_data = '/Users/matias/Documents/Codes_PhD/W2_mags.txt'
w1_data = '/Users/matias/Documents/Codes_PhD/W1_mags.txt'

cdef np.ndarray w4,w3,w2,w1 = np.zeros((1000,200))
cdef np.ndarray x = np.zeros(200)
cdef np.ndarray y = np.zeros(1000)

w4 = np.loadtxt(w4_data)
w3 = np.loadtxt(w3_data)
w2 = np.loadtxt(w2_data)
w1 = np.loadtxt(w1_data)

x = np.arange(5,1000+1,5)
y = np.logspace(np.log10(1e-10),np.log10(100),1000)
fw4 = interp2d(x, y, w4, kind='cubic')
fw3 = interp2d(x, y, w3, kind='cubic')
fw2 = interp2d(x, y, w2, kind='cubic')
fw1 = interp2d(x, y, w1, kind='cubic')

def o_W1_DS(W1,TDS,LStar,eta): #W1 vega mag, TDS in K, LStar in Lsun, TStar in L, eta dimensionless
    #Star magnitude after DS absorption
    cdef np.ndarray Lbol_DS = np.zeros(len(W1))
    cdef np.ndarray W1star = np.zeros(len(W1))
    W1star = W1 - 2.5*np.log10(1 - eta)
    Lbol_DS=eta*LStar #Lsun
    #for i,p in enumerate(zip(TDS*np.ones(len(W1)),Lbol_DS)):
    #    W1DS[i] = fw1(*p)[0]
    W1DS = np.array([fw1(*p)[0] for p in zip(TDS*np.ones(len(W1)),Lbol_DS)])
    #nW1DS = np.array(W1DS)
    return -2.5*np.log10(10**(W1star/-2.5) + 10**(W1DS/-2.5))


def n_W1_DS(W1,TDS,LStar,eta): #W1 vega mag, TDS in K, LStar in Lsun, TStar in L, eta dimensionless
    #Star magnitude after DS absorption
    cdef np.ndarray Lbol_DS = np.zeros(len(W1))
    cdef np.ndarray W1star = np.zeros(len(W1))
    cdef np.ndarray W1DS = np.zeros(len(W1))
    W1star = W1 - 2.5*np.log10(1 - eta)
    Lbol_DS=eta*LStar #Lsun
    for i,p in enumerate(zip(TDS*np.ones(len(W1)),Lbol_DS)):
        W1DS[i] = fw1(*p)[0]
    return -2.5*np.log10(10**(W1star/-2.5) + 10**(W1DS/-2.5))
