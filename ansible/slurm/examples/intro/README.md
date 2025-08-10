# Intro to Slurm

- The `hello.sh` script will use `srun` to run a command on different nodes.
- `hello.slurm` is a file uses for the `sbatch` command. At the top the `#SBATCH` settings are specified. Since it's only a single command, it will only utilize the minimal required cores to finish the job.
- `hello2.slurm` is similar to `hello.slurm`, but it uses the `srun` command to have the job run on all the specified cores.
