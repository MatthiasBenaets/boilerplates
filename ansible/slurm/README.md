# Slurm cluster

Sets up controller and nodes for a slurm cluster
Will install: munge, slurm, openmpi

Don't forget to update inventory.ini file and the config/slurm.conf file depending on the amount of nodes

1. share ssh keys between controller and each node, and each node to controller
2. update hostname
3. update /etc/hosts
4. set up controller
5. set up nodes

Tested on Ubuntu Server Minimal 24.04
