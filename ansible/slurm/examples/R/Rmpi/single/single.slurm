#!/bin/bash
#SBATCH --ntasks=4
#SBATCH --time=00:01:00
#SBATCH --output=output/slurm-%j.out
echo "Job ID: $SLURM_JOB_ID"
echo "Nodes allocated: $SLURM_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "Tasks per node: $SLURM_TASKS_PER_NODE"
echo "Number of tasks: $SLURM_NTASKS"
echo "CPUs per task: $SLURM_CPUS_PER_TASK"

cd $SLURM_SUBMIT_DIR

module load R/4.4.0

mpirun -np 6 Rscript single.R $SLURM_SUBMIT_DIR
