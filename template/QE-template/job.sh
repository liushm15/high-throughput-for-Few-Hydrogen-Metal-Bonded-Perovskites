#!/bin/bash
#SBATCH -J liushm
#SBATCH --output=err.out
#SBATCH -N 1
#SBATCH --ntasks-per-node=16
#SBATCH --time=300:00:00

#srun --nodes=1 hostname

bash -c 'source /opt/intel/oneapi/setvars.sh; exec bash'
source /opt/code/env/intel-oneapi.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/software/elpa-2020.11.001_bugfix/lib/


ulimit -s unlimited
ulimit -m unlimited
ulimit -c unlimited
ulimit -d unlimited

qedir=/opt/software/q-e-qe-7.0/bin



Element_1=`cat input | head -2 | tail -1 | awk '{print $1}'`
UPF_1=`cat input | head -2 | tail -1 | awk '{print $2}'`
MASS_1=`cat input | head -2 | tail -1 | awk '{print $3}'`

Element_2=`cat input | head -3 | tail -1 | awk '{print $1}'`
UPF_2=`cat input | head -3 | tail -1 | awk '{print $2}'`
MASS_2=`cat input | head -3 | tail -1 | awk '{print $3}'`

Element_3=`cat input | head -4 | tail -1 | awk '{print $1}'`
UPF_3=`cat input | head -4 | tail -1 | awk '{print $2}'`
MASS_3=`cat input | head -4 | tail -1 | awk '{print $3}'`

sed -i "3s/MASS_1/${MASS_1}/g" ./phonon/ph.in
sed -i "4s/MASS_2/${MASS_2}/g" ./phonon/ph.in
sed -i "5s/MASS_3/${MASS_3}/g" ./phonon/ph.in

sed -i "3s/MASS_1/${MASS_1}/g" ./phonon/matdyn.in
sed -i "4s/MASS_2/${MASS_2}/g" ./phonon/matdyn.in
sed -i "5s/MASS_3/${MASS_3}/g" ./phonon/matdyn.in

sed -i "3s/MASS_1/${MASS_1}/g" ./phonon/matdyn-1.in
sed -i "4s/MASS_2/${MASS_2}/g" ./phonon/matdyn-1.in
sed -i "5s/MASS_3/${MASS_3}/g" ./phonon/matdyn-1.in

sed -i "43s/MASS_1/${MASS_1}/g" ./relax/vc-relax.in 
sed -i "43s/UPF_1/${UPF_1}/g" ./relax/vc-relax.in
sed -i "43s/Element_1/${Element_1}/g" ./relax/vc-relax.in

sed -i "44s/MASS_2/${MASS_2}/g" ./relax/vc-relax.in
sed -i "44s/UPF_2/${UPF_2}/g" ./relax/vc-relax.in
sed -i "44s/Element_2/${Element_2}/g" ./relax/vc-relax.in

sed -i "45s/MASS_3/${MASS_3}/g" ./relax/vc-relax.in
sed -i "45s/UPF_3/${UPF_3}/g" ./relax/vc-relax.in
sed -i "45s/Element_3/${Element_3}/g" ./relax/vc-relax.in

sed -i "53s/Element_1/${Element_1}/g" ./relax/vc-relax.in
sed -i "54s/Element_2/${Element_2}/g" ./relax/vc-relax.in
sed -i "55s/Element_2/${Element_2}/g" ./relax/vc-relax.in
sed -i "56s/Element_2/${Element_2}/g" ./relax/vc-relax.in
sed -i "57s/Element_3/${Element_3}/g" ./relax/vc-relax.in

sed -i "44s/MASS_1/${MASS_1}/g" ./scf/scf.in
sed -i "44s/UPF_1/${UPF_1}/g" ./scf/scf.in
sed -i "44s/Element_1/${Element_1}/g" ./scf/scf.in

sed -i "45s/MASS_2/${MASS_2}/g" ./scf/scf.in
sed -i "45s/UPF_2/${UPF_2}/g" ./scf/scf.in
sed -i "45s/Element_2/${Element_2}/g" ./scf/scf.in

sed -i "46s/MASS_3/${MASS_3}/g" ./scf/scf.in
sed -i "46s/UPF_3/${UPF_3}/g" ./scf/scf.in
sed -i "46s/Element_3/${Element_3}/g" ./scf/scf.in

sed -i "44s/MASS_1/${MASS_1}/g" ./scf-1/scf.in
sed -i "44s/UPF_1/${UPF_1}/g" ./scf-1/scf.in
sed -i "44s/Element_1/${Element_1}/g" ./scf-1/scf.in

sed -i "45s/MASS_2/${MASS_2}/g" ./scf-1/scf.in
sed -i "45s/UPF_2/${UPF_2}/g" ./scf-1/scf.in
sed -i "45s/Element_2/${Element_2}/g" ./scf-1/scf.in

sed -i "46s/MASS_3/${MASS_3}/g" ./scf-1/scf.in
sed -i "46s/UPF_3/${UPF_3}/g" ./scf-1/scf.in
sed -i "46s/Element_3/${Element_3}/g" ./scf-1/scf.in

cp ../../pseudo/${UPF_1} ./pseudo
cp ../../pseudo/${UPF_2} ./pseudo
cp ../../pseudo/${UPF_3} ./pseudo


cd ./relax/
date "+01 Today's date is: %D. The time execution %T" >> time.info
mpirun -np 16 $qedir/pw.x -nk 4 -input vc-relax.in > vc-relax.out
date "+02 Today's date is: %D. The time finish %T" >> time.info


grep -A 10 "CELL_PARAMETERS" vc-relax.out | tail -11 >> ../scf-1/scf.in

grep -A 10 "CELL_PARAMETERS" vc-relax.out | tail -11 >> ../scf/scf.in

cd ../scf/
date "+01 Today's date is: %D. The time execution %T" >> time.info
mpirun -np 16 $qedir/pw.x -nk 4 -input scf.in > scf.out
date "+02 Today's date is: %D. The time finish %T" >> time.info


cd ../scf-1/

date "+01 Today's date is: %D. The time execution %T" >> time.info
mpirun -np 16 $qedir/pw.x -nk 4 -input scf.in > scf.out
date "+02 Today's date is: %D. The time finish %T" >> time.info


cd ../phonon/
date "+01 Today's date is: %D. The time execution %T" >> time.info
mpirun -np 16 $qedir/ph.x -nk 4 -input ph.in > ph.out
mpirun -np 16 $qedir/q2r.x  -input q2r.in > q2r.out
mpirun -np 16 $qedir/matdyn.x -input matdyn.in > matdyn.out
mpirun -np 16 $qedir/matdyn.x -input matdyn-1.in > matdyn-1.out
date "+02 Today's date is: %D. The time finish %T" >> time.info

grep "THz" AlZr3B.dyn* >> log
grep "-" AlZr3B_band.freq >> log
$qedir/lambda.x < lambda.in > lambda.out

