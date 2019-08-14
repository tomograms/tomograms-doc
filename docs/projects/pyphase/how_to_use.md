## How to use pyPhase

pyPhase may be used [in python](#in-python), or using a [terminal](#using-terminal).

>***Note:***
>*For the moment being pyPhase is supported for Linux only.*

## In python

Make sure pyPhase is [Installed](install.md). Import it into your python script with:
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



