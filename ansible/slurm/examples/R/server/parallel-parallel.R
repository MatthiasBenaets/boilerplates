# All jobs will be send to the SLURM controller at once, they will then be handled by the compute nodes
library(batchtools)

# Register the SLURM backend using your template
reg <- makeRegistry(file.dir = "bt_registry", make.default = TRUE)
reg$cluster.functions <- makeClusterFunctionsSlurm("slurm.tmpl")

# Your function (same as you'd use in future_lapply)
f <- function(x) {
  Sys.sleep(2)
  paste("Value:", x)
}

# Map the function over inputs
batchMap(f, x = 1:20)

# Submit all jobs immediately
submitJobs()

# Wait until they’re all done
waitForJobs()

# Collect results
res <- reduceResultsList()
print(res)

# Remove registry
removeRegistry(reg = reg)
