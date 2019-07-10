## Using Anaconda for Tomography & Imaging projects

### Creating Ananconda enviroment

The plan is to use Anaconda. Create a new enviroment (e.g. name=lhack-an3-5.2) in order to not interfere with your other software (only once at the event beginning). You can reuse the enveroment later or delete it.

```bash
# load Anaconda module (optional, required on Aurora)
module purge
module load Anaconda3/5.2.0

# create new environment (name=lhack-an3-5.2) with tifffile and spyder
conda create --override-channels --channel conda-forge \
             -n lhack-an3-5.2 python=3.6 tifffile spyder
```

### Using Anaconda environment in an interactive node

```bash
# skip this line if you want to run directly in the frontend
# in case adjust project number (-A), partition type (-p) and requred memory (--mem)
#    lu: -A lu2018-2-48 -p lu --mem=220GB
#  lvis: -A lvis2019-5-1 -p lvis --mem=56GB
#  snic: -A snic2017-1-485 -p snic --mem=50GB # (allocation project ended)
# maxiv: --mem=210GB
interactive -A lu2018-2-48 -p lu --mem=210GB -t 12:00:00 --exclusive

module purge
module load Anaconda3/5.2.0

source activate lhack2-an3-5.2
```

Note: You have to use `source` cmd at Aurora. You can use `conda` cmd instead on your computer.

