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

(echo "1";echo "103") | vaspkit >> potcar.log


date "+01 Today's date is: %D. The time execution %T" >> time.info
mpirun -hosts=jjshi13 -np 16 /opt/software/vasp/vasp.5.4.4.pl2/vasp.5.4.4.pl2/bin/vasp_std  > log
date "+02 Today's date is: %D. The time finish %T" >> time.info



echo -e "$name \c" >> /home/jjshi/Data2/Liushm/fcc/${B}_based/summary.txt
grep 'TOTEN' ./OUTCAR | tail -1  | awk '{print}' >> /home/jjshi/Data2/Liushm/fcc/${B}_based/summary.txt

