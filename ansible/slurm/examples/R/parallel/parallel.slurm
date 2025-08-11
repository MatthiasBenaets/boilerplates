#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=2
#SBATCH --time=00:10:00
#SBATCH --output=output/parallel_%j.out

cd $SLURM_SUBMIT_DIR

module load R/4.4.0

Rscript parallel.R
