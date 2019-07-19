## How to use pyPhase

pyPhase may be used [in python](#in-python), or using a [terminal](#using-terminal).

>***Note:***
>*For the moment being pyPhase is supported for Unix only.*
### Using Terminal

After [installing](install.md) run:

```console 
foo$bar:~$ pyphase -h
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
#### Example

This example shows how to use a *CTF algorithm* to retrieve phase and attenuation using multidistance data.


Move into your project's directory:

```console
foo$bar:~$ cd /path-to-project/myProject
foo$bar:~/myProject$
```
Make sure your data has the correct data [format/structure](sturcture.md). 

```console
foo$bar:~$pyphase --projections 0 10 --algotithem 'CTF' my_projct_name
```
[\\]: # (check syntax above. Will algorithm be loaded as a string?)

## In python

Make sure pyPhase is [Installed](install.md). Import it into your python script with:
~~~python
import pyphase
~~~

Usage examples can be found [here](examples.md).
