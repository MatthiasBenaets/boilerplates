library(rslurm)

my_function <- function(x) {
  return(x^2)
}

params <- data.frame(x = 1:10)

slurm_options <- list(
  time = "00:10:00",
  nodes = 2,
  ntasks = 2
)

sjob <- slurm_apply(
  f = my_function,
  params = params,
  jobname = "rslurm-job",
  nodes = slurm_options$nodes,
  slurm_options = slurm_options,
  cpus_per_node=2,
  sh_template = "./submit.sh"
)

status <- get_job_status(sjob)
print(status)

results <- get_slurm_out(sjob, outtype="table")

print(results)

# Clean up temporary files
cleanup_files(sjob)
