# Propagating the (2D and 3D) phantoms with *Syris* 


### Installing syris and creating a conda enviornment

Make and go to the directory where ***syris*** will be installed.


Clone  [syris](https://github.com/ufo-kit/syris) from GitHub

```bash
git clone https://github.com/ufo-kit/syris.git
```

You will need to load the following modules in order to install and use syris.

```bash
module use /mxn/groups/pub/sw/modules/maxiv
module load Anaconda3
```
Create a conda environment for syris

```bash
conda create --name syris_env -c conda-forge python=2 numpy quantities pyopencl scipy testfixtures
```
 Make your system-wide implementation of OpenCL is visible to pyopencl by doing
 
```bash
ln -s /etc/OpenCL/vendors path/to/.conda/envs/syris_env/etc/OpenCL/vendors 
```

Activate the environment and pip install *pyfft*

```bash
conda activate syris_env

cd path/to/.conda/envs/syris_env #need to do this?

pip install pyfft
```

Now, move to the syris directory and *make*

```bash
cd path/to/syris
make
```
Syris may now be used.


## Propagate 2D projections with Syris

This notebook shows how to propagate projections using Syris.

On your python script or notebook, add syrus path to sys in order to be able to import the modules.


~~~python
import os
import sys
syris_path = os.path.abspath(os.path.join('../../../ufo-kit/syris/'))
if syris_path not in sys.path:
    sys.path.append(syris_path)
~~~

~~~python
import matplotlib.pyplot as plt
import numpy as np
import tifffile

import quantities as q
import syris
from syris.physics import propagate
from syris.bodies.simple import make_sphere
from syris.materials import make_henke

from syris.bodies import simple
~~~

~~~python
syris.init()
~~~

~~~python
os.makedirs('simdata_test_1024')

for distance in range(3):
    os.makedirs('simdata_test_1024/distance_' + str(distance), exist_ok = True)
~~~

~~~python
n = 1024

energies = np.arange(22000,22020) * q.eV
pixel_size = 0.3 * q.um
#distance = 0.02 * q.m
material = make_henke('PMMA', energies)

dists = [0.03 , 0.15, 0.3] 
~~~

~~~python
for i in range(1,40000):
    for j,dist in enumerate(dists):
        
        distance = dist * q.m
        phantom_c = tifffile.imread('/home/diofig/tomograms/users/diogo/CNNs/GenData/projected_phantoms_2/train/{}.tif'.format(str(i).zfill(5)))
        
        phantom = simple.StaticBody(phantom_c * pixel_size, pixel_size, material=material)#, queue = queue1)
        image = propagate([phantom], (n, n), energies, distance, pixel_size).get()
        tifffile.imsave('simdata_test_1024/distance_{d}/prop_{p}.tif'.format(d = j+1, p = str(i).zfill(5)),image.astype(np.float32))
~~~

## Propagating 3D phantoms with Syris

This notebook shows how to propagate 3D phantoms (tiff stacks).
For a range of angles, a projections are taken using tomopy, and propagated using syris.
The propagated projections are then used to perform a tomographic reconstruction.
Finally the resulting tomogram is saved.

On your python script or notebook, add syrus path to sys in order to be able to import the modules.

~~~python
import os
import sys
syris_path = os.path.abspath(os.path.join('../../../ufo-kit/syris/'))
if syris_path not in sys.path:
    sys.path.append(syris_path)
~~~

~~~python
import tomopy
from tomopy.misc import phantom
from tomopy.sim import propagate
from tomopy.sim import project
import tifffile
import numpy as np

import matplotlib.pyplot as plt

import quantities as q
import syris
from syris.physics import propagate
from syris.bodies.simple import make_sphere
from syris.materials import make_henke

from syris.bodies import simple
~~~
Choose a directory to where the files will be saved. 
~~~python
os.makedirs('propagated_3d')
~~~

Start syris
~~~python
syris.init()
~~~
Choose the parameters for propagation
~~~python
n = 512

energies = np.arange(22000,22020) * q.eV
pixel_size = 0.3 * q.um
distance = 0.15 * q.m
material = make_henke('PMMA', energies)
~~~

Choose number of angles and angle range for projections (and tomographic reconstruction).
~~~python
angles = project.angles(500,0,180)
~~~

For each phantom *i* in the range (and in the path), simulate tomographic acquisition, propagate projections, and reconstruct tomogram.
~~~python
for i in range(1,2000):
     
    phantom = tifffile.imread('/home/diofig/tomograms/users/diogo/CNNs/GenData/scripts/phantoms3D/train/{}.tif'.format(str(i).zfill(4)))
    prop_projections = []
    for angle in angles:
        projection = project.project(phantom,angle, pad=False)
        obj = simple.StaticBody(projection[0] * pixel_size, pixel_size, material=material)#, queue = queue1)
        propagated = propagate([obj], (n, n), energies, distance, pixel_size).get()
        prop_projections.append(propagated)
    prop_projections = np.stack(np.asarray(prop_projections),axis = 0)
    propagated_phantom = tomopy.recon(prop_projections,angles,algorithm = 'gridrec')    
    tifffile.imsave('propagated_3d/prop_{p}.tif'.format(p = str(i).zfill(4)),propagated_phantom.astype(np.float32))
~~~

