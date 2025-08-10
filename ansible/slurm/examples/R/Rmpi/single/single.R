#!/usr/bin/env Rscript

library(Rmpi)

rank <- mpi.comm.rank(0)
size <- mpi.comm.size(0)
pid <- Sys.getpid()

my_number <- rank + pid  # Just for example


cat(sprintf("Process %d %s: my number is %d\n", rank, Sys.info()["nodename"], my_number))

if (rank == 0) {
  # Master process: receive numbers from all other processes
  numbers <- numeric(size)
  numbers[1] <- my_number  # master's own number
  
  for (i in 1:(size-1)) {
    # Receive number from any source (the worker ranks)
    received <- mpi.recv.Robj(source=mpi.any.source(), tag=1, comm=0)
    numbers[i+1] <- received
  }
  
  total <- sum(numbers)

  args <- commandArgs(trailingOnly = TRUE)
  outfile <- paste0(args[1], "/result.txt")
  writeLines(c(
    sprintf("Numbers from all processes: %s", paste(numbers, collapse=", ")),
    sprintf("Sum of all numbers: %d", total),
    sprintf("Process %d finished", rank)
  ), con = outfile)

  #cat(sprintf("\n=== RESULT ===\n"))
  #cat(sprintf("Sum of all numbers: %d\n", total))
  
} else {
  # Workers send their number to the master (rank 0)
  mpi.send.Robj(obj = my_number, dest = 0, tag=1, comm=0)
}

invisible(mpi.barrier())  # synchronize all processes

if (rank == 0) {
  cat(sprintf("Process %d finished\n", rank))
}

invisible(mpi.finalize())
