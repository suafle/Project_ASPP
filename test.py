import functions.normal.BB as BB
import functions.cython.BB as c_BB
import numpy as np

W1 = np.array([0])
TDS = 300
LStar = np.array([1])
eta = 0.9

print(BB.W1_DS(W1,TDS,LStar,eta))
print(c_BB.W1_DS(W1,TDS,LStar,eta))
