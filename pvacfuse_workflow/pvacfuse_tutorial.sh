#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --mem=4GB
#SBATCH --job-name=test
module purge

singularity exec \
        --overlay /scratch/dq2033-share/INTEGRATE-Neo/overlay-15GB-500K.ext3:ro \
        /scratch/work/public/singularity/ubuntu-20.04.4.sif \
        /bin/bash -c "

source /ext3/env.sh
which python
which pvactools

./home/cac9995/bin/pvactools pvacfuse run \
/scratch/dq2033-share/pVACtools/pvactools/tools/pvacfuse/example_data/agfusion/ \
Test \
HLA-A*02:01,HLA-B*35:01,DRB1*11:01 \
MHCflurry MHCnuggetsI MHCnuggetsII NNalign NetMHC PickPocket SMM SMMPMBEC SMMalign \
/scratch/dq2033-share/pVacfuse_out \
-e1 8,9,10 \
-e2 15"

#written by Charlee Cobb - 11/12/2022
