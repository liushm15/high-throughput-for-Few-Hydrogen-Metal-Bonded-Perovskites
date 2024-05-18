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

python3 minima.py > log

grep ene hop.log > energy.dat
grep "Recorded minima" hop.log > structure.dat
python3 read.py

echo -e "$name \c" >> ../../result-hopping.txt
cat hopping.txt | awk '{print}' >> ../../result-hopping.txt
