import functions.normal.BB as BB
import functions.cython.BB as c_BB
import numpy as np
import time

W1 = np.array([0])
TDS = 300
LStar = np.array([1])
eta = 0.9

t0 = time.time()
BB.W1_DS(W1,TDS,LStar,eta)
print(time.time()-t0)
t0 = time.time()
c_BB.W1_DS(W1,TDS,LStar,eta)
print(time.time()-t0)
