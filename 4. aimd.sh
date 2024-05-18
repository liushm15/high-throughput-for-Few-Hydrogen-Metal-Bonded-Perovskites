#!/bin/bash
#for A_element in Mg Al Ca Sc Ti V Cu Zn Ga Ge Sr Y Zr Nb Pd Ag Cd In Sn Sb Ba Hf
for A_element in Ta  #Nb Al Mg Cu Ca Sc

do

	cp ./template/AIMD/aimd.py ./${A_element}_based/
	cp ./template/AIMD/md.sh ./${A_element}_based/
	cp -rf ./template/AIMD ./${A_element}_based/
	cd ./${A_element}_based/
	python3 aimd.py
	compound=`cat compounds.txt | head -n 1`
	sed -i "3s/Compounds/${compound}/g" ./md.sh
	bash ./md.sh
	cd $OLDPWD


done
