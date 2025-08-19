#!/bin/bash -l
#
#SBATCH --array=0-{{{max_node}}}{{{job_array_task_limit}}}
#SBATCH --cpus-per-task={{{cpus_per_node}}}
#SBATCH --job-name={{{jobname}}}
#SBATCH --output=slurm_%a.out
{{#flags}}
#SBATCH --{{{name}}}
{{/flags}}
{{#options}}
#SBATCH --{{{name}}}={{{value}}}
{{/options}}
module load R
{{{rscript}}} --vanilla slurm_run.R
