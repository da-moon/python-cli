## common variables
# choose between TRACE DEBUG INFO 
# TRACE is the lowest log level
# INFO is the highest log level
# it can also be empty
Log_LEVEL := 
# execution environment. In case docker is installed on your machine,
# setting this to 'true' will execute all 'make target' commands
# in the container
DOCKER_ENV := false
# docker image used as execution environment
docker_image:=
# name of execution container
container_name:=
# where to mount repository's root in the container.
mount_point:=
## metaheuristics and optimaztion problem variables
# the root directory for search agent's CSV output.
# if empty, it won't export search agent's output and store it
# in file
EXPORT_ROOT:=
# create scatter plot of search agent values
PLOT:=false
