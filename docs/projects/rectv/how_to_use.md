# 4D tomographic reconstruction by time domain decomposition

[rectv_gpu on GitHub](https://github.com/math-vrn/rectv_gpu)

## How to use

In order to use the rectv environment

 * the enviroment needs to be activated
 * working directory is needed
 * data can be downaloded from `tomobank` or MAX IV storage
 * a SLURM script may be useful
 * ImageJ can be used for data visualization

```bash
# 
# load modules and activate the environment
module purge
module add Anaconda3 CUDA
source activate rectv
```

### Working directory

Use `/scratch` at MAX IV.

```bash
mkdir /scratch/tmp/$USER
```
### Reconstruction script

```bash
wget https://raw.githubusercontent.com/math-vrn/rectv_gpu/master/tomopy_rectv.py -O tomopy_rectv.py
```

### SLURM script

```bash
wget https://raw.githubusercontent.com/tomograms/tomograms-doc/master/docs/projects/rectv/utils/j_rectv_maxiv.sh -O j_rectv.sh
```

Start new job:

```bash
sbatch j_rectv.sh
```

### Visualizing results (TIFF) with ImageJ

```bash
# visualise data with ImageJ
module add  ImageJ

java -jar $EBROOTIMAGEJ/ij.jar -Dij1.plugins.dir=$EBROOTIMAGE/plugins
```

 * Load an image sequence

