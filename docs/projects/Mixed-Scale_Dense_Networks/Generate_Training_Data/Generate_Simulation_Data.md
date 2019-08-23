### Generating Simulation Data

This page describes how to generate simulation data to *teach* neural networks to retrieve phase information, from 2D projections, and 3D reconstructed tomograms.


#### 2D Data

The procedure is split into the following steps, corresponding to different notebooks.

1) Generating random models (descriptions) of 3D phantoms to be used with [tomophantom](https://www.sciencedirect.com/science/article/pii/S2352711018300335).

2) Building the phantoms and saving their projections as tiff images.  

3) Propagating the projections using [syris](https://syris.readthedocs.io/en/latest/).
 

#### 3D Data

The procedure is split into the following steps, corresponding to different notebooks.

1) Generating random models (descriptions) of 3D phantoms to be used with [tomophantom](https://www.sciencedirect.com/science/article/pii/S2352711018300335).

2) Building the phantoms, i.e., generating the tiff stacks.  

3) Simulating tomographic acquisition and reconstruction to obtain propagated 3D phantoms using [syris](https://syris.readthedocs.io/en/latest/).
 
