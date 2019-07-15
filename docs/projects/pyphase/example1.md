## Multidistance CFT phase retrieval

[\\]: # (adding images?)

[Install](install.md) pyPhase. Then:
~~~python
import pyPhase
~~~
Define the projects name
~~~python
name = 'holosim'
~~~
and set the path to the data
~~~python
path = /data/staff/tomograms/HoloSim
~~~
Make sure that the data folders and files have the right [format and structure](structure.md).
Create a DataSet object
~~~python
ds = dataset.DataSet(path,name)
~~~
[\\]: # (more about dataset here?)

Choose a phase retreival algorithm(link to list of algorithms) and create a retreiver for the dataset, with the appropriate arguments 
~~~python
alpha =  1e-8
retriever = phaseretrieval.CTF(ds,alpha)
~~~
RuSelect to range to of projections for which to run the retrieval algorithm
~~~python
start = 0   #default = 0
end = 3     #default = 0
~~~
 Run the phase retreival
~~~python
retriever.ReconstructProjections(ds,start, end)
~~~
For each projection, a file named `holosim_` with the retrieved phase and and file named `holosim_att_`, with the retrieved attenuation, is created in the `[path]/myProject_`
