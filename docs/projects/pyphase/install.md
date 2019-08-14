## Install directions

> <span style="color:red"> ***NOTE:*** 
> ***pyPhase is under development is currently not available for download/install.*** </span>

> <span style="color:red"> ***To run pyPhase during this period, the source code files need to be in python project's directory.*** </span>



Here you can find install directions for *pyPhase*.

### Conda
Install pyPhase in your conda enviornment with

```console
conda install pyphase 
```

### Pip
With pip

```console
pip install pyphase
```

## Requeriments

pyPhase has the following packages dependencies:
- numpy (Version)
- pyelastix
- EDFfile
- PIL
- yaml
- pickle
- sortedcontainers
- parallelizer


#### Elastix
To use shift and motions correction in pyPhase, [elastix](http://elastix.isi.uu.nl/)
 needs to be installed in the machine. By default, pyelastix will look for elastix's executables in `'/user/bin/'`, `'/user/local/bin'` and `'/opt/local/bin'`. 
 If installed elswhere add the path to pyelastix `_find_executables()`. 



