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

cp INCAR_3 INCAR

date "+01 Today's date is: %D. The time execution %T" >> time.info
mpirun -hosts=jjshi13 -np 16 /opt/software/vasp/vasp.5.4.4.pl2/vasp.5.4.4.pl2/bin/vasp_std  > log
date "+02 Today's date is: %D. The time finish %T" >> time.info

cp log log_1
cp CONTCAR POSCAR
cp INCAR_1 INCAR

date "+01 Today's date is: %D. The time execution %T" >> time.info
mpirun -hosts=jjshi13 -np 16 /opt/software/vasp/vasp.5.4.4.pl2/vasp.5.4.4.pl2/bin/vasp_std  > log
date "+02 Today's date is: %D. The time finish %T" >> time.info


i=0
until ((i > 2))
do
reached=$(grep "reached required accuracy" log)
if [ -z "$reached" ]; then
	echo "Please exam the results and determine if you can continue to claculate" >> $name.log
	continue=$(grep "please rerun with smaller EDIFF, or copy CONTCAR" log)
	if [ -z "$continue" ]; then
		echo "Your calculation has been stoped and please exam the structure carefully" >> $name.log
		((i=i+3))
	else
		echo "Please copy CONTCAR to POSCAR and continue" >> $name.log
		rm log
		cp ./CONTCAR ./POSCAR
		cp ../../template/INCAR_2 ./INCAR
		mpirun -hosts=jjshi13 -np 16 /opt/software/vasp/vasp.5.4.4.pl2/vasp.5.4.4.pl2/bin/vasp_std  > log
		((i++))
	fi
fi
done
