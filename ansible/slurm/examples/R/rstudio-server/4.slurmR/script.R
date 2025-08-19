library(slurmR)

# Create a cluster with 4 workers
cl <- makeSlurmCluster(4)

# Do some parallel computation
result <- parSapply(cl, 1:10, function(x) mean(runif(100)))

# Stop the cluster when done
stopCluster(cl)
