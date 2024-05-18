#!/bin/bash
#for B1_element in Al Sc Y Au In La Ce Pr Nd Sm Gd Dy
for A_element in Be  #Li Na K Rb Cs  #Ru Rh W Os Ir  #Hg Tl La  #Cr Mn Mo  #Ta Pt Au Pb Bi  #Mg Al Ca Sc Ti V Cu Zn Ga Ge Sr Y Zr Nb Pd Ag Cd In Sn Sb Ba Hf # Ta Pt Au Hg Tl Pb Bi Po La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu

do

#mkdir ./${A_element}_based/

for B_element in H

do
	
for X_element in  Li Na K Rb Cs Cr Mn Mo Ru Rh W Os Ir Mg Al Ca Sc Ti V Cu Zn Ga Ge Sr Y Zr Nb Pd Ag Cd In Sn Sb Ba Hf Ta Pt Au Hg Tl Pb Bi La
do
	name=${A_element}${B_element}${X_element}3

	cp -r ./template/scf ./${A_element}_based/${A_element}${B_element}${X_element}3
	cd ./${A_element}_based/${A_element}${B_element}${X_element}3/scf
	sbatch ./job.sh
	cd $OLDPWD

done

done

done
