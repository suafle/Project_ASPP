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

def W1_DS(W1,float TDS,LStar,float eta): #W1 vega mag, TDS in K, LStar in Lsun, TStar in L, eta dimensionless
    #Star magnitude after DS absorption
    cdef double[:] Lbol_DS,W1star,W1DS = np.zeros(len(W1))
    #cdef np.ndarray Lbol_DS,W1star,W1DS = np.zeros(len(W1))
    W1star = W1 - 2.5*np.log10(1 - eta)
    Lbol_DS=eta*LStar
    for i,p in enumerate(zip(TDS*np.ones(len(W1)),Lbol_DS)):
        W1DS[i] = fw1(*p)[0]
    new_w1 = -2.5*np.log10(10**(np.array(W1star)/-2.5) + 10**(np.array(W1DS)/-2.5))
    return new_w1



def W2_DS(W2,float TDS,LStar,float eta): #W1 vega mag, TDS in K, LStar in Lsun, TStar in L, eta dimensionless
    #Star magnitude after DS absorption
    cdef np.ndarray Lbol_DS,W2star,W2DS = np.zeros(len(W2))
    W2star = W2 - 2.5*np.log10(1 - eta)
    Lbol_DS=eta*LStar #Lsun
    for i,p in enumerate(zip(TDS*np.ones(len(W2)),Lbol_DS)):
        W2DS[i] = fw2(*p)[0]
    return -2.5*np.log10(10**(W2star/-2.5) + 10**(W2DS/-2.5))


def W3_DS(W3,float TDS,LStar,float eta): #W1 vega mag, TDS in K, LStar in Lsun, TStar in L, eta dimensionless
    #Star magnitude after DS absorption
    cdef np.ndarray Lbol_DS,W3star,W3DS = np.zeros(len(W3))
    W3star = W3 - 2.5*np.log10(1 - eta)
    Lbol_DS=eta*LStar #Lsun
    for i,p in enumerate(zip(TDS*np.ones(len(W3)),Lbol_DS)):
        W3DS[i] = fw3(*p)[0]
    return -2.5*np.log10(10**(W3star/-2.5) + 10**(W3DS/-2.5))


def W4_DS(W4,float TDS,LStar,float eta): #W1 vega mag, TDS in K, LStar in Lsun, TStar in L, eta dimensionless
    #Star magnitude after DS absorption
    cdef np.ndarray Lbol_DS,W4star,W4DS = np.zeros(len(W4))
    W4star = W4 - 2.5*np.log10(1 - eta)
    Lbol_DS=eta*LStar #Lsun
    for i,p in enumerate(zip(TDS*np.ones(len(W4)),Lbol_DS)):
        W4DS[i] = fw4(*p)[0]
    return -2.5*np.log10(10**(W4star/-2.5) + 10**(W4DS/-2.5))
