### Generate random phantoms (their parametric description).
 
 This notebooks generates parameters for [tomophantom]() objects and saves them to a .dat file. This information will be later used to generate the 
 simulation phantoms.

#### Conda enviornment

The block bellow shows how to create an conda environment for this notebook. 

```bash
conda create --name myenv python=...
```

#### Jupyter Notebook

Import the necessary libraries.
~~~python
import os
import numpy as np
import matplotlib.pyplot as plt
import tifffile
import random

from tomophantom import TomoP3D
~~~

Define the path and name of the `.dat` file that will contain the phantoms model description. If the file exists, the new models will be appended.
~~~python
path = '/home/diofig/tomograms/users/diogo/CNNs/GenData/PhantLib/Phantom3DLibrary2.dat'
~~~

Generate the models:
~~~python
number_of_phantoms = 100000


#components = ['gaussian','paraboloid', 'ellipsoid', 'cone', 'cuboid', 'elliptical_cylinder']
# the unused components are not uniform in density.

components = [ 'ellipsoid', 'cuboid', 'elliptical_cylinder']

for n in range(1,number_of_phantoms):
    num_of_components = random.randint(1,20)

    objects = [] 
    component_subset = random.choices(components,k = random.randint(1,3))
    for i in range(num_of_components):
        obj = random.choice(component_subset)
        upper_lim_half_width = random.choice([0.5,1])
        obj += ' {c0} {x0} {y0} {x0} {a} {b} {c} {alpha} {beta} {gamma}'.format(c0 = 1, #round(random.uniform(0.1,1),2),
                                                                               x0 = round(random.uniform(-1, 1),2),
                                                                               y0 = round(random.uniform(-1, 1),2),
                                                                               z0 = round(random.uniform(-1, 1),2),
                                                                               a = round(random.uniform(0.01,upper_lim_half_width),3),
                                                                               b = round(random.uniform(0.01,upper_lim_half_width),3),
                                                                               c = round(random.uniform(0.01,upper_lim_half_width),3),
                                                                               alpha = round(random.uniform(-180, 180),2),
                                                                               beta = round(random.uniform(-180, 180),2),
                                                                               gamma = round(random.uniform(-180, 180),2)) 
        objects.append(obj)
    
    phantom_string = '''#----------------------------------------------------
# random phantom number {num}
Model : {num};
Components : {comp};
TimeSteps : 1;
'''.format(num = n, comp = num_of_components)

    for obj in objects:
        phantom_string += 'Object : ' + obj + '\n'
        
    with open(path,'a') as file:
        file.write(phantom_string)
~~~

Plot six of the generated phantoms (slices)!
~~~python
N = 128 #size of the phantom, side of the cube (pixels).


fig, ax = plt.subplots(nrows = 3, ncols = 3, figsize = (14,14))

for row in ax:
    for col in row:
        rand_model = random.randint(1, number_of_phantoms-1)
        phantom =  TomoP3D.Model(rand_model, N, path)[64,:,:]
        #phantom =  np.sum(phantom,axis = 0)  #Uncomment this line and comment out the above for projections insted of slices
        col.title.set_text('phantom model no ' + str(rand_model))
        col.imshow(phantom, cmap = 'gray')
~~~

