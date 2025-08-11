#!/bin/bash
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --output=output/slurm-%j.out

export $SLURM_SUBMIT_DIR
export $SLURM_PROCID
export $SLURMD_NODENAME
cd $SLURM_SUBMIT_DIR

module load R/4.4.0

srun Rscript file.R

