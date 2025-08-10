#!/bin/sh
#SBATCH --nodes=2
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=2
#SBATCH --time=00:01:00
#SBATCH --output=/home/matthias/cloud/hello_%j.out

sleep 5
echo "Hello from $(hostname)"
