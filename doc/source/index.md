# Tomograms

Common platform for tomographic reconstructions and image processing

## Events

### Quantim hackathon (Nov 26-27, 2018)

### Lunarc Aurora

- [Download ThinLinc client](https://www.cendio.com/thinlinc/download)
- ThinLinc or ssh to: `aurora.lunarc.lu.se`
- [Lunarc Documentation](http://lunarc-documentation.readthedocs.io) 

### Useful hints

#### Creating Ananconda enviroment

The plan is to use Anaconda. Create a new enviroment (e.g. name=lhack-an3-5.2) in order to not interfere with your other software (only once at the hackathon beginning).

```bash
module purge
module load Anaconda3/5.2.0

# create new environment (name=lhack-an3-5.2) with tifffile and spyder
conda create --override-channels --channel conda-forge \
             -n lhack-an3-5.2 python=3.6 tifffile spyder
```

#### Using Anaconda environment in an interactive node

```bash
# skip this line if you want to run directly in the frontend
# in case adjust project number (-A), partition type (-p) and requred memory (--mem)
#    lu: -A lu2018-2-48 -p lu --mem=220GB
#  snic: -A snic2017-1-485 -p snic --mem=50GB
# maxiv: --mem=210GB
interactive -A lu2018-2-48 -p lu --mem=210GB -t 12:00:00 --exclusive

module purge
module load Anaconda3/5.2.0

source activate lhack-an3-5.2
```

#### Running Jupyter notebook on LUNARC with small data (algorithm development)

1. on the front end if you just want to tweak a script on a small dataset ( e.g. 300 x 300 x 300 pixels):
```bash
module purge
module load Anaconda3
#start a new jupyter notebook:
jupyter notebook

#if you have an example notebook you can load it directly by navigating to the directory where your script is. Easiest is if you navigate to the directory where your data is and put the python script there
cd /nobackup/YourData
jupyter notebook 'notebookName.ipynb'
```
#### Imaging data visualisation 
1. connect to LUNARC using ThinLinc 
2. upload your data to your nobackup directory /lunarc/nobackup/users/'your user name'
ImageJ
Applications -> Lunarc Applications -> Medical Imaging -> fiji
Tomviz
Applications -> Lunarc Applications -> Volume Rendering -> Tomviz
Slicer3D
Applications -> Lunarc Applications -> Volume Rendering -> Slicer3D

#### Using SPYDER editor of Python scripts on LUNARC
1. connected to LUNARC using ThinLinc 
2. go to Applications -> Lunarc Applications -> Python -> Spyder - Anaconda3

#### Loading image data, cropping, downscaling

Here we try to provide scirpts for loading in data and handling them before you start the analysis / visualisation

1. One example how to load in a stack of tiff files and downscale it you find here:
[Kevin's kaggle script](https://www.kaggle.com/kmader/simple-loading-and-processing)

#### Getting exclusive node with jupyter-notebook

Lunarc is working on the implementation of a proper JupyterHub but it is not available
for the time of hackathon. So we suggest to use a trick you can find on the Web, e.g.
here: [Remote Access to IPython Notebooks via SSH](https://coderwall.com/p/ohk6cg/remote-access-to-ipython-notebooks-via-ssh).
The trick is:
1. allocating the node, getting its hostname and starting the jupyter notobook
2. making a ssh tunnel from the frontend to the given node
3. connecting to the jupyter notebook from a browser at the frontend

```bash
# 1) open a terminal and get the node:
interactive -A lu2018-2-48 -p lu --mem=210GB -t 12:00:00 --exclusive

# 2) type there "hostname" in order to get node name (e.g. au10)
hostname

# 3) get jupyter notebook from anaconda or e.g. from modules:

module purge
module load Anaconda3/5.2.0

source activate lhack-an3-5.2

jupyter-notebook

# (you will get the link, e.g.: http://localhost:8888/?token=56240c.....)

# 4) open ThinLinc to aurora.lunarc.lu.se or clu0-gn-0 (MAX IV)
tlclient

# 5) in ThinLinc, open terminal and type: "ssh -L 8001:localhost:8888 au10".
# You are using info about the node (au10) and the port (8888) from the previous
# steps no. 2-3 and you choose a new local port 8001 (your choice but must be free)
ssh -L 8001:localhost:8888 au10

# 6) in ThinLink, open browser and put there a link (keep localhost ip address!!! but
# replace the port (8888) with the new one (8001)

http://localhost:8001/?token=56240c.....

# You should have the notebook running in the node (au10) but the interface in the
# browser in ThinLinc.
```



## References
1. [Lunarc Documentation](http://lunarc-documentation.readthedocs.io)
2. [Tomopedia](https://tomopedia.github.io/)
3. [Tomobank](https://tomobank.readthedocs.io)
