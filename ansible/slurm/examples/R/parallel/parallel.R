library(parallel)

is_prime <- function(num)
{
	if(num == 2 | num == 3)
		return(TRUE)
	
	if(num == 1)
		return(FALSE)

	if(num %% 2 == 0)
		return(FALSE)

	root <- floor(sqrt(num))

	for (elt in seq(5,root))
	{
		if(num %% elt == 0)
			return(FALSE)
	}
	return(TRUE)
}

set.seed(2)
sample_numbers <- sample(10000000, 1000000)

num_cores <- as.numeric(Sys.getenv("SLURM_NTASKS", unset = 1))

message(paste("creating cluster with", num_cores, "cores"))

cl <- makeCluster(num_cores)

results <- parSapply(cl, sample_numbers, is_prime)

stopCluster(cl)

print(table(results))
