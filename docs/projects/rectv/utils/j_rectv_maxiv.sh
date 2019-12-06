#!/bin/bash
#
# job time, change for what your job requires
#SBATCH -t 0-06:00:00
#
# job name
#SBATCH -J rectv
#
# pickup V100 gpu node
#SBATCH -p v100
#
# Optional: take the full node if you want all 4 cards
#SBATCH --exclusive
#
# minimum 4 control threads and 160 GB maximum memory requested 
#SBATCH --mincpus=4
#SBATCH --mem 160GB
#
# filenames stdout and stderr - customise, include %j
#SBATCH -o process_rectv_%j.out
#SBATCH -e process_rectv_%j.err

# treat undefined variables as errors
set -u

# write this script to stdout-file - useful for scripting errors
cat $0

# load the modules required for you program - customise for your program
module purge
module add Anaconda3 CUDA
source activate rectv

module list
conda list >&2

# run the program
# customise for your program name and add arguments if required

# prepare
#wdir=/local/slurmtmp.$SLURM_JOB_ID
wdir=/scratch/tmp/$USER

cd $wdir

if [ $? -ne 0 ]; then
  echo "ERROR: Could not change to ${wdir}. Exiting job!"
  exit 1
fi

# get the reconstruction script
#wget https://raw.githubusercontent.com/math-vrn/rectv_gpu/master/tomopy_rectv.py -O tomopy_rectv.py

# input data file
export datafile=/data/staff/tomograms/test-data/rectv/dk_MCFG_1_p_s1_.h5

echo "Input data file: ${datafile}"
echo "Working directory: ${wdir}"

echo "Copying input data to working directory. This may take a while ..."
cp $datafile .
echo "Copying data DONE."

# run
python tomopy_rectv.py $(basename -- $datafile) --type subset --nsino 0.75 --binning 2 --tv True --frame 95

du -h $wdir
echo "WARNING: See disk usage. Consider cleaning up your results."

# Note:
#  for setting up the sw environment see https://tomograms.readthedocs.io/en/latest/projects/rectv/setup/
#
# Usage:
#  sbatch j_rectv.sh

