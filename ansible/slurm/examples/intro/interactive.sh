# Interactive shell on a single node
#srun --pty --nodes=1 --cpus-per-task=2 /bin/bash -i
srun --pty --nodes=1 --ntasks=2 /bin/bash -i
