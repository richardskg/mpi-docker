## MPI Examples

Some simple examples of using slurm on the docker cluster.

### ping_pong

This code comes from mpitutorials (see the header in ping_pong.c) The code has been modified slightly to show which servers are running the code.

To use:

* Start the container as described in the main README

* On the slurmctld:
*   cd data/Examples
*   make

*   Then you can run the examples e.g:
*   sbatch ping.sh
