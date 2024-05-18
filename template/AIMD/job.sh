#!/bin/bash
#SBATCH -J liushm
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --output=err.out
#SBATCH --time=300:00:00

bash -c 'source /opt/intel/oneapi/setvars.sh; exec bash'
source /opt/code/env/intel-oneapi.sh

ulimit -s unlimited
ulimit -m unlimited
ulimit -c unlimited
ulimit -d unlimited



date "+01 Today's date is: %D. The time execution %T" >> time.info

mpirun -hosts=jjshi13 -np 16 /opt/software/vasp/vasp.6.3.0/bin/vasp_gam > log

date "+02 Today's date is: %D. The time finish %T" >> time.info


