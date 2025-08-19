# All jobs will be send to the SLURM controller in a sequence, they will then be handled by the compute nodes
library(future)
library(future.batchtools)
library(future.apply)

plan(batchtools_slurm, template = "~/slurm.tmpl")

# Dummy test function
f <- function(x) {
  paste("Value:", x)
}

# Submit jobs to SLURM
res <- future_lapply(1:20, f)

print(res)
