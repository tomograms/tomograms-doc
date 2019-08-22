## Install directions

> <span style="color:red"> ***NOTE:*** 
> ***pyPhase is under development is currently not available for download/install.*** </span>

> <span style="color:red"> ***To run pyPhase during this period, the source code files need to be in the machine. Make sure to add their path to the system.*** </span>

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

### Using the source code
Obtain a copy or download pyPhase source code from a git repository.
Make sure to had the code's path to your system. This can be done in python with

~~~ python
import os
import sys

pyphase_path = os.path.abspath('~/path/to/pyphase')
sys.path.append(pyphase_path)
~~~  

or in your system. In bash do
```bash
PATH=$PATH:~/path/to/pyphase
```

## Requeriments

pyPhase has the following packages dependencies:
- numpy
- pyelastix
- EDFfile
- PIL
- yaml
- pickle
- sortedcontainers
- parallelizer

*TODO: add versions.*


#### Elastix
To use shift and motions correction in pyPhase, [elastix](http://elastix.isi.uu.nl/)
 needs to be installed in the machine. By default, pyelastix will look for elastix's executables in `'/user/bin/'`, `'/user/local/bin'` and `'/opt/local/bin'`. 
 If your binaries are elswhere add their path to `pyelastix.py` under the `_find_executables()` method. 



