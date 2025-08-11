whatis("Description: R programming language version 4.3.0")

-- Set the R_HOME and R_LIBS_USER environment variables
setenv("R_HOME", "/opt/apps/R/4.3.0/lib/R")
setenv("R_LIBS_USER", "/opt/apps/R/4.3.0/library")

-- Add the R binary to the user's PATH
prepend_path("PATH", "/opt/apps/R/4.3.0/bin")
