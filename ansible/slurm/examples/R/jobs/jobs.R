#!/usr/bin/env Rscript

outfile <- paste0(Sys.getenv("SLURM_SUBMIT_DIR"), "/results/result", Sys.getenv("SLURM_PROCID"), ".txt")

writeLines(c(
  "Hello from R!",
  Sys.getenv("SLURMD_NODENAME"),
  paste("Current time is:", Sys.time())
), con = outfile)

cat("File written successfully.\n")
