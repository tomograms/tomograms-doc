## How to use pyPhase

pyPhase may be used [in python](#in-python), or using a [terminal](#using-terminal).

>***Note:***
>*For the moment being pyPhase is supported for Linux only.*

## Conda and source code 

Create a new Conda environment 

```bash
# load Anaconda module (optional, required on Aurora)
module purge
module load Anaconda3/5.2.0

# create new environment
conda create -n myenv python=3.6 numpy tifffile

# activate the enviornment
source activate myenv
```
Make sure to had the code's path to your system. This can be done in python with

~~~ python
import os
import sys

pyphase_path = os.path.abspath('~/path/to/pyphase')
sys.path.append(pyphase_path)
~~~  

or in the terminal
```bash
PATH=$PATH:~/path/to/pyphase
```
 
Import pyphase into your python script with:
~~~python
import pyphase
~~~


Usage examples can be found [here](examples.md).


### Using Terminal

After [installing](install.md) run:

```console 
:~$ pyphase -h
``` 
```shell
pyphase.py [-h] [-p start end] [--parameter alpha] [--algorithm alg]
                  [--reconstruct_delta | --reconstruct_beta | --project_delta | --project_beta | --propagate | --difference | --retrieve_difference | --reconstruct_delta_update | --reconstruct_beta_update | --update_delta | --update_beta]
                  name


PyPhase phase retrieval

positional arguments:
  name                  name of the data set

optional arguments:
  -h, --help            show this help message and exit
  -p start end, --projections start end
                        projections to reconstruct
  --parameter alpha     regularisation parameter
  --algorithm alg       algorithm for phase retrieval or propagation
  --reconstruct_delta   tomographic reconstruction of delta from phase maps
  --reconstruct_beta    tomographic reconstruction of beta from attenuation
                        maps
  --project_delta       create projections of delta
  --project_beta        create projections of beta
  --propagate           propagate projections
  --difference          calculate difference between measurement and current
                        solution in contrast plane
  --retrieve_difference
                        retrieve phase from difference images
  --reconstruct_delta_update
                        reconstruct delta update from retrieved difference
                        image
  --reconstruct_beta_update
                        reconstruct beta update from retrieved difference
                        image
  --update_delta        update current solution for delta with calculated
                        update
  --update_beta         update current solution for beta with calculated
                        update
```

Usage examples can be found [here](examples.md).



