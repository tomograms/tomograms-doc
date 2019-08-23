
## Using a trained network to reconstruct phase

This notebook ...

~~~python
# Import code
import msdnet
import glob
import tifffile
import os

# Make folder for output
os.makedirs('results2', exist_ok=True)

# Load network from file
n = msdnet.network.MSDNet.from_file('/home/diofig/tomograms/users/diogo/CNNs/trained_networks/trained2_1dist/regr_params.h5', gpu=True)

# Process all test images
flsin = sorted(glob.glob('/home/diofig/tomograms/users/diogo/ufo-kit/syris/simdata/distance_4/dist_500*.tif'))
for i in range(len(flsin)):
    # Create datapoint with only input image
    d = msdnet.data.ImageFileDataPoint(flsin[i])
    # Compute network output
    output = n.forward(d.input)
    # Save network output to file
    tifffile.imsave('results2/regr_{:05d}.tiff'.format(i), output[0])
~~~