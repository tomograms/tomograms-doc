## Resume training for MS-DNet

~~~python
import msdnet
import glob
~~~

~~~python
flsin = sorted(glob.glob('/home/diofig//tomograms/users/diogo/CNNs/GenData/scripts/simdata_1024/simdata_X_train_1024/distance_2/prop_?????.tif'))
flstg = sorted(glob.glob('/home/diofig//tomograms/users/diogo/CNNs/GenData/scripts/simdata_1024/simdata_y_train_1024/?????.tif'))
# Create list of datapoints (i.e. input/target pairs)
dats = []
for i in range(len(flsin)):
    # Create datapoint with file names
    d = msdnet.data.ImageFileDataPoint(flsin[i],flstg[i])
    # Augment data by rotating and flipping
    d_augm = msdnet.data.RotateAndFlipDataPoint(d)
    # Add augmented datapoint to list
    dats.append(d_augm)
~~~

~~~python
n.normalizeinout(dats)
~~~

~~~python
# Use image batches of a single image
bprov = msdnet.data.BatchProvider(dats,1)

# Define validation data (not using augmentation)
flsin = sorted(glob.glob('/home/diofig/tomograms/users/diogo/CNNs/GenData/scripts/simdata_1024/simdata_X_validate_1024/distance_2/prop_3????.tif'))
flstg = sorted(glob.glob('/home/diofig/tomograms/users/diogo/CNNs/GenData/scripts/simdata_1024/simdata_y_validate_1024/3????.tif'))
datsv = []
for i in range(len(flsin)):
    d = msdnet.data.ImageFileDataPoint(flsin[i],flstg[i])
    datsv.append(d)
# Note: The above can also be achieved using a utility function for such 'simple' cases:
# datsv = msdnet.utils.load_simple_data('val/noisy/*.tiff', 'val/noiseless/*.tiff', augment=False)

~~~

**Load network, training algorithm, and validation object from checkpoint of previous training**
~~~python

n, t, val = msdnet.train.restore_training('regr_params.checkpoint', msdnet.network.MSDNet, msdnet.train.AdamAlgorithm, msdnet.validate.MSEValidation, datsv, gpu=True)
~~~

~~~python
# Log error metrics to console
consolelog = msdnet.loggers.ConsoleLogger()
# Log error metrics to file
filelog = msdnet.loggers.FileLogger('log_regr.txt')
# Log typical, worst, and best images to image files
imagelog = msdnet.loggers.ImageLogger('log_regr', onlyifbetter=True)
~~~
Train network until program is stopped manually
Network parameters are saved in regr_params.h5
Validation is run after every len(datsv) (=25)
 training steps.
~~~python
msdnet.train.train(n, t, val, bprov, 'regr_params.h5',loggers=[consolelog,filelog,imagelog], val_every=len(datsv))
~~~
