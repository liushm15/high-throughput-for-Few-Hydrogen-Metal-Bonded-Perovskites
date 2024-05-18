from ase import Atoms, Atom
from ase.calculators.vasp import Vasp
from ase.optimize.minimahopping import MinimaHopping
from ase.io import read, write
from ase.spacegroup.symmetrize import FixSymmetry
from ase.spacegroup import symmetrize
import numpy as np

atoms =  read("POSCAR_ase")

kpt=[3,3,5]

calc1 = Vasp(prec='Normal', xc='PBE', lreal=False,ncore=4)

calc2 = Vasp(istart=0,
            icharg=2,
            prec='Accurate',
            encut=400,
            ismear=1,
            sigma=0.2,
            xc='PBE',
            lreal='Auto',
            kpts=kpt,
            ispin=1,
            isif=3,
            ediff=1E-03,
            ediffg = -0.1,
            lwave=False,
            lcharg=False,
            ibrion=2,
            ncore=4,
            nsw=500
        )


atoms.set_calculator(calc1)

hop = MinimaHopping(atoms=atoms,calc1=calc1,calc2=calc2,Ediff0=2.5,T0=500.,fmax=0.2)
hop(totalsteps=4)


