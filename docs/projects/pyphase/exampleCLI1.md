## Multidistance CFT phase retrieval


This example shows how to use a *CTF algorithm* to retrieve phase and attenuation using multidistance data.


Move into your project's directory:

```console
$ cd /path-to-project/myProject
```
Make sure your data has the correct data [format/structure](sturcture.md). 

Run 
```console
$pyphase --projections 0 10 --algotithm CTF my_projct_name
```
The parameter ***--projections*** receives two inputs, namely the number of the first and last projections (respectively) to be used. The default is ***---projections 0 0***.

In ***--algorithm*** you select the the algorithm used for retrieving the phase.

Finally the have the ***projects name***. Observe that it must match the [name of the file's and directories root name](sturcture.md).
The output is written into files locates in the folder named *'my_project_name_'*.

[\\]: # (check syntax above. Will algorithm be loaded as a string?)

