#!/usr/bin/env Rscript

# Load Rmpi
library(Rmpi)

# Get MPI info
rank <- mpi.comm.rank(0)
size <- mpi.comm.size(0)

# Each process generates one number
my_number <- rank + 1

# Print number
cat(sprintf("%s, process %d: my number is %d\n", Sys.info()["nodename"], rank, my_number))

mpi.finalize()
