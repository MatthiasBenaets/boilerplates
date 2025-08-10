#!/bin/bash
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --output=output/slurm-%j.out

export $SLURM_SUBMIT_DIR
export $SLURM_PROCID
export $SLURMD_NODENAME
cd $SLURM_SUBMIT_DIR
srun Rscript file.R

