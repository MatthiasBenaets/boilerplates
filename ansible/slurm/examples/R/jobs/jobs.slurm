#!/bin/bash
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --output=output/slurm-%j.out

cd $SLURM_SUBMIT_DIR

module load R/4.4.0

srun Rscript file.R
