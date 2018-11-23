# Tomograms

Common platform for tomographic reconstructions and image processing

## Events

### Quantim hackathon (Nov 26-27, 2018)

### Lunarc Aurora

- [Download ThinLinc client](https://www.cendio.com/thinlinc/download)
- ThinLinc or ssh to: `aurora.lunarc.lu.se`
- [Lunarc Documentation](http://lunarc-documentation.readthedocs.io) 

### Useful hints

#### Creating Ananconda enviroment

The plan is to use Anaconda. Create a new enviroment (e.g. name=lhack-an3-5.2) in order to not interfere with your other software (only once at the hackathon beginning).

```bash
module purge
module load Anaconda3/5.2.0

# create new environment (name=lhack-an3-5.2) with tifffile and spyder
conda create --override-channels --channel conda-forge \
             -n lhack-an3-5.2 python=3.6 tifffile spyder
```

#### Using Anaconda environment in an interactive node

```bash
# skip this line if you want to run directly in the frontend
# in case adjust project number (-A), partition type (-p) and requred memory (--mem)
#    lu: -A lu2018-2-48 -p lu --mem=220GB
#  snic: -A snic2017-1-485 -p snic --mem=50GB
# maxiv: --mem=220GB
interactive -A lu2018-2-48 -p lu --mem=220GB -t 12:00:00 --exclusive

module purge
module load Anaconda3/5.2.0

source activate lhack-an3-5.2
```

#### Getting exclusive node with jupyter-notebook

instructions come soon (Zdenek)

## References
1. [Lunarc Documentation](http://lunarc-documentation.readthedocs.io)
2. [Tomopedia](https://tomopedia.github.io/)
3. [Tomobank](https://tomobank.readthedocs.io)
