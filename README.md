# Project_ASPP
Project for the course Advance Scientific Programming with Python

This project consisted on several parts.

On my daily research I have to apply models to the stars in the Milky Way

This project was split into two parts. 

The first part consists of cythonizing the code I use for the models

And the second part consists of using MPI4PY to fasten my codes.

CYTHON:

For the cython part, I have in the folder functions the folder cython and the folder normal.

The folder normal contains the functions I use W1_DS, W2_DS, W3_DS, and W4_DS that I was using before any implementation.

The folder normal contains the cythonized functions.

In the main folder we have the file test.py, which shows how much time it takes to run every implementation. We see that the cython one is definetely faster

In the file test.ipynb we have the same as test.py, but in an jupyter notebook environment.

In the file test_loop.ipynb studies diferences in loops, and how they are treated. I did not get interesting differences.

The file Project.ipynb shows how my normal codes works using the normal functions and the cython functions

MPI4PY:

In addition to the implementation of cython, I used MPI4PY to improve the performance even more 

The file MPI shows the same as Project.ipynb but as .py file and applying mpi4py.

Since the code applies the model to a very large numpy array, I split this into different processes and I gather them later using the gather function.
