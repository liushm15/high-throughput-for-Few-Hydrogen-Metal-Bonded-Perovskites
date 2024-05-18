#!/bin/bash
#for A_element in Mg Al Ca Sc Ti V Cu Zn Ga Ge Sr Y Zr Nb Pd Ag Cd In Sn Sb Ba Hf
for A_element in Compounds 
do

	mkdir ./${A_element}/ase
	cp  minima.py pbs read.py POSCAR_ase plt.py get.py ./${A_element}/ase
	cd ./${A_element}/ase
	cp ../CONTCAR ./
	n=`sed -n '3p' CONTCAR | awk '{print $1}'`
	m=`echo $n | awk '{printf("%.5f",$1*1.414)}'`
	elements=`sed -n '6p' CONTCAR`
	sed -i "3s/A_axis/${m}/g" ./POSCAR_ase
	sed -i "4s/A_axis/${m}/g" ./POSCAR_ase
	sed -i "5s/C_axis/${n}/g" ./POSCAR_ase
	sed -i "6s/elements/${elements}/g" ./POSCAR_ase
#	(echo "4";echo "401";echo "2";echo "2 1 1") | vaspkit > super.log
	sed -i "11a name=${A_element}" ./pbs
#	ln -s ./SC211.vasp ./POSCAR.vasp
	sbatch ./pbs
	cd $OLDPWD

done


