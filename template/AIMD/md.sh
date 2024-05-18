#!/bin/bash
#for A_element in Mg Al Ca Sc Ti V Cu Zn Ga Ge Sr Y Zr Nb Pd Ag Cd In Sn Sb Ba Hf
for A_element in Compounds 
do

	cp -r ./AIMD ./${A_element}/
	cd ./${A_element}/AIMD
	cp ../CONTCAR ./POSCAR
	(echo "4";echo "401";echo "1";echo "3 3 3") | vaspkit > super.log
	cp SC333.vasp POSCAR
	cp ../POTCAR ./
	sbatch ./job.sh
	cd $OLDPWD

done


