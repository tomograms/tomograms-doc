## Training MS-DN for singe or multidistance phase retrieval

~~~python
# Import code
import msdnet
import glob
~~~

~~~python
dilations = msdnet.dilations.IncrementDilations(12)
~~~
Create main network object for regression using
the GPU (set gpu=False to use CPU). 

> **In the parameter `num_of_inputs_channels`
> add the number of distances used for phase retrieval.**

> ***When using multi channels input, the images shall be stacked in the same tifffile.***



~~~python
num_of_layers = 200
num_of_inputs_channels = 1
num_of_output_channesl = 1

n = msdnet.network.MSDNet(250, dilations, num_of_inputs_channels, num_of_output_channesl, gpu= True)
~~~
Initialize network parameters
~~~python
n.initialize()
~~~

Define the training data.

~~~python
lsin = sorted(glob.glob('/home/diofig//tomograms/users/diogo/CNNs/GenData/scripts/simdata_1024/simdata_X_train_1024/distance_2/prop_1????.tif'))
flstg = sorted(glob.glob('/home/diofig//tomograms/users/diogo/CNNs/GenData/scripts/simdata_1024/simdata_y_train_1024/1????.tif'))
# Create list of datapoints (i.e. input/target pairs)
dats = []
for i in range(len(flsin)):
    # Create datapoint with file names
    d = msdnet.data.ImageFileDataPoint(flsin[i],flstg[i])
    # Augment data by rotating and flipping
    d_augm = msdnet.data.RotateAndFlipDataPoint(d)
    # Add augmented datapoint to list
    dats.append(d_augm)
# Note: The above can also be achieved using a utility function for such 'simple' cases:
# dats = msdnet.utils.load_simple_data('train/noisy/*.tiff', 'train/noiseless/*.tiff', augment=True)
~~~

~~~python
n.normalizeinout(dats)

# Use image batches of a single image
bprov = msdnet.data.BatchProvider(dats,1)

# Define validation data (not using augmentation)
flsin = sorted(glob.glob('/home/diofig/tomograms/users/diogo/CNNs/GenData/scripts/simdata_1024/simdata_X_validate_1024/distance_2/prop_35???.tif'))
flstg = sorted(glob.glob('/home/diofig/tomograms/users/diogo/CNNs/GenData/scripts/simdata_1024/simdata_y_validate_1024/35???.tif'))
datsv = []
for i in range(len(flsin)):
    d = msdnet.data.ImageFileDataPoint(flsin[i],flstg[i])
    datsv.append(d)
# Note: The above can also be achieved using a utility function for such 'simple' cases:
# datsv = msdnet.utils.load_simple_data('val/noisy/*.tiff', 'val/noiseless/*.tiff', augment=False)

# Validate with Mean-Squared Error
val = msdnet.validate.MSEValidation(datsv)

# Use ADAM training algorithms
t = msdnet.train.AdamAlgorithm(n)

# Log error metrics to console
consolelog = msdnet.loggers.ConsoleLogger()
# Log error metrics to file
filelog = msdnet.loggers.FileLogger('log_regr.txt')
# Log typical, worst, and best images to image files
imagelog = msdnet.loggers.ImageLogger('log_regr', onlyifbetter=True)


msdnet.train.train(n, t, val, bprov, 'regr_params.h5',loggers=[consolelog,filelog,imagelog], val_every=len(datsv))
~~~

Train network until program is stopped manually.
The network parameters are saved in **regr_params.h5**
Validation is run after every len(datsv) (=25) training steps.
~~~python
msdnet.train.train(n, t, val, bprov, 'regr_params.h5',loggers=[consolelog,filelog,imagelog], val_every=len(datsv))
~~~