## Quantim hackathon (Mar 21-22, 2019)

### scikit-image

#### (Option A) Basic terminal

```bash
source /lunarc/nobackup/users/zdemat/pub/envs/sourceme_for_skimage
```

##### (Option B) Anaconda

##### Creating environment

```bash
module purge
module add Anaconda3/5.2.0

# create new environment (name=lhack2-an3-5.2)
#    with python3.6 tifffile, scikit-image, jupyter and spyder
conda create --override-channels --channel conda-forge \
             -n lhack2-an3-5.2 python=3.6 tifffile scikit-image jupyter spyder
```

##### Using the environment

```bash
module purge
module add Anaconda3/5.2.0

conda activate lhack2-an3-5.2
```

##### Addding new software

```bash
module purge
module add Anaconda3/5.2.0

source activate lhack2-an3-5.2

(lhack2-an3-5.2) conda search --channel conda-forge software
(lhack2-an3-5.2) conda install --channel conda-forge software
```

##### Deactivating environment

```bash
(lhack2-an3-5.2) # close terminal or
(lhack2-an3-5.2) conda deactivate
```

### spam

Only basic terminal option available.

```bash
source /lunarc/nobackup/users/zdemat/pub/envs/sourceme_for_spam

DICregularGrid --help
```

Reference:
- [spam documentation](https://ttk.gricad-pages.univ-grenoble-alpes.fr/spam/)

