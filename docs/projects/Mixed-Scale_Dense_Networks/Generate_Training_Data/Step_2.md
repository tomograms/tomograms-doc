## Build Phantoms and project them and save as tiff


#### Conda enviornment for this script

```bash
conda create --name envname 
```

~~~python
import os
import numpy as np
import matplotlib.pyplot as plt
import tifffile

from tomophantom import TomoP3D
~~~

~~~python
path = '/home/diofig/tomograms/users/diogo/CNNs/GenData/PhantLib/Phantom3DLibrary2.dat'
~~~
Define the image size.
~~~python
N = 1024
~~~

Create the directories to where the files will be saved.
~~~python
s.makedirs('../projected_phantoms',exist_ok=True)
os.makedirs('../projected_phantoms/train',exist_ok=True)
os.makedirs('../projected_phantoms/validate',exist_ok=True)
os.makedirs('../projected_phantoms/test',exist_ok=True)
~~~

Generate the phantoms from models *a* to *b* from the *Phantom3DLibrary2.dat* library.
At this step you may:

- Project the 3D phantom onto one plane for its projected thickness, by keeping the line `phantom =  np.sum(phantom,axis = 0)` in the blocks bellow.

- Save the 3D phantom as a tiff stack by commenting out the line  `phantom =  np.sum(phantom,axis = 0)` in the blocks bellow.


~~~python
for model in range(0,10000):
    phantom =  TomoP3D.Model(model,N,path)
    phantom =  np.sum(phantom,axis = 0) # To save the 3D phantom comment out this line
    tifffile.imsave('../projected_phantoms/train/{:05d}.tif'.format(model),phantom.astype(np.float32))
~~~

~~~python
for model in range(10001,12000):
    phantom =  TomoP3D.Model(model,N,path)
    phantom =  np.sum(phantom,axis = 0) # To save the 3D phantom comment out this line
    tifffile.imsave('../projected_phantoms/validate/{:05d}.tif'.format(model),phantom.astype(np.float32))
~~~

~~~python
for model in range(12001,12100):
    phantom =  TomoP3D.Model(model,N,path)
    phantom =  np.sum(phantom,axis = 0) # To save the 3D phantom comment out this line
    tifffile.imsave('../projected_phantoms/test/{:05d}.tif'.format(model),phantom.astype(np.float32))
~~~