#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --mem=4GB
#SBATCH --job-name=test

module purge #wriiten by Charlee Cobb - 10/06/2022
singularity exec \
        --overlay /scratch/dq2033-share/INTEGRATE-Neo/overlay-15GB-500K.ext3:ro \
        /scratch/work/public/singularity/ubuntu-20.04.4.sif \
        /bin/bash -c "
export PATH=/ext3/bin:\${PATH}
which gtfToGenePred
which python
python /ext3/bin/integrate-neo.py\
        -1 /ext3/INTEGRATE-Neo/Examples/example1/rd1.fq\
        -2 /ext3/INTEGRATE-Neo/Examples/example1/rd2.fq \
        -f /ext3/INTEGRATE-Neo/Examples/example1/fusions.bedpe\
        -r /ext3/bin/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa\
        -g /ext3/bin/Homo_sapiens.GRCh38.86.genePred -k"
