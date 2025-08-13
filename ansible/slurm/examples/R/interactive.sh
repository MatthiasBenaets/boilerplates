# interactive shell on just 1 node but multiple cpu cores
srun --pty -N1 -c2 bash -c "module load R/4.3.0; R"
