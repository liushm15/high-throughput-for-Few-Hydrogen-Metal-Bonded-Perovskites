#!/bin/bash
for A in  RhHIr3
do
        cp -rf ./template/QE-template/ ./${A}
        cd ./${A}
        sed -i "3s/NAME/${A}/g" ./qe.py
        python3 qe.py
        sbatch ./job.sh
        cd $OLDPWD
done

