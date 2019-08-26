## Training MS-DN for tomographic data

This Jupyter Notebook is used to train a MS-DN to retrieve phase from tomographic data.
The propagated 3D phantoms are used as input for the network, and the original phantoms (ground truth) used as targets.
For each tomographic slice in the target, a number *N* of slices from the input are used.
This number can be defined by bellow. 
 


~~~python
# Import code
import msdnet
import glob
~~~

~~~python
# Define dilations in [1,10] as in paper.
dilations = msdnet.dilations.IncrementDilations(10)
~~~
Create main network object for regression, with 100 layers,
 [1,10] dilations, 5 input channels (5 slices), 1 output channel, using
 the GPU (set gpu=False to use CPU)
~~~python
n = msdnet.network.MSDNet(100, dilations, 5, 1, gpu=True)

# Initialize network parameters
n.initialize()
~~~

~~~python
# Define training data
# First, create lists of input files (propagated tomograms) and target files (original phantoms)
flsin = sorted(glob.glob('tomo_train/propagated_phantoms/*.tiff'))
flstg = sorted(glob.glob('tomo_train/phantoms_3D/*.tiff'))
# Create list of datapoints (i.e. input/target pairs)
dats = []
for i in range(len(flsin)):
    # Create datapoint with file names
    d = msdnet.data.ImageFileDataPoint(flsin[i],flstg[i])
    # Add datapoint to list
    dats.append(d)
~~~


Convert input slices to input slabs (i.e. multiple slices as input). Note that this shall match the 
input value used then instantiating the `msdnet.network.MSDNet`. Then numeric argument in ` msdnet.data.convert_to_slabs`  
correstponds to the number of slices above and bellow the targed slice. In the case bellow 5 = 2 + 1 + 2.
~~~python
dats = msdnet.data.convert_to_slabs(dats, 2, flip=True)
# Augment data by rotating and flipping
dats_augm = [msdnet.data.RotateAndFlipDataPoint(d) for d in dats]
    

# Normalize input and output of network to zero mean and unit variance using
# training data images
n.normalizeinout(dats)

# Use image batches of a single image
bprov = msdnet.data.BatchProvider(dats,1)

# Define validation data (not using augmentation)
flsin = sorted(glob.glob('propagated_phantoms/*.tiff'))
flstg = sorted(glob.glob('tomo_train/phantoms_3D/*.tiff'))
datsv = []
for i in range(len(flsin)):
    d = msdnet.data.ImageFileDataPoint(flsin[i],flstg[i])
    datsv.append(d)

# Convert input slices to input slabs (i.e. multiple slices as input)
datsv = msdnet.data.convert_to_slabs(datsv, 2, flip=False)

# Validate with Mean-Squared Error
val = msdnet.validate.MSEValidation(datsv)

# Use ADAM training algorithms
t = msdnet.train.AdamAlgorithm(n)

# Log error metrics to console
consolelog = msdnet.loggers.ConsoleLogger()
# Log error metrics to file
filelog = msdnet.loggers.FileLogger('log_tomo_regr.txt')
# Log typical, worst, and best images to image files
imagelog = msdnet.loggers.ImageLogger('log_tomo_regr', onlyifbetter=True, chan_in=2)
~~~

Train network until program is stopped manually
Network parameters are saved in regr_params.h5
Validation is run after every len(datsv) (=256)
training steps.
~~~python
msdnet.train.train(n, t, val, bprov, 'tomo_regr_params.h5',loggers=[consolelog,filelog,imagelog], val_every=len(datsv))
~~~