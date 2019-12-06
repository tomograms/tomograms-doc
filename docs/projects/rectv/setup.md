# 4D tomographic reconstruction by time domain decomposition

[rectv_gpu on GitHub](https://github.com/math-vrn/rectv_gpu)

## Setup

A basic installation of `rectv_gpu` can be done with Anaconda in a user home directory.
below anoe can find instructions for MAX IV and LUNARC.

```bash
# load Anaconda3 and CUDA
module purge
module add Anaconda3 CUDA

# create conda environment
conda create -n rectv -c conda-forge python=3.7

# activate environment
source activate rectv

# install tomopy via conda
conda install tomopy h5py dxchange

# ensure you have pip in your conda environment
conda install pip

# follow instructions on https://github.com/math-vrn/rectv_gpu
# set CUDAHOME environmental variable
export CUDAHOME=$CUDA_HOME
# install via pip (note: update the number to follow the last commit)
pip install https://github.com/math-vrn/rectv_gpu/archive/cd8546b97ee2fd25b5aed159c71cb0a1b21442c5.tar.gz
```

Optionally for running jupyter notebooks one needs to install `ipykernel`.

```bash
# (optional)
# if you want to use this environment with jupyter install the kernel
conda install nb_conda_kernels ipykernel
# if the notebook extension is not installed upstream you have to install it with juputer-lab localy as well
conda install nb_conda_kernels jupyterlab
```

