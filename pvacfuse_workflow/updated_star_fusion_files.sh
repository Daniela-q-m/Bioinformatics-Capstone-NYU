#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --mem=4GB
#SBATCH --job-name=test
module purge

set -ve

if [ -z ${CTAT_GENOME_LIB} ]; then
    echo "Error, must have CTAT_GENOME_LIB env var set"
    exit 1
fi

VERSION=`cat VERSION.txt`

# run STAR-Fusion
cd ../ && singularity exec --overlay /scratch/dq2033-share ${CTAT_GENOME_LIB}:/ctat_genome_lib Docker/star-fusion_1.10.0.sif\ #was .smig
/scratch/dq2033-sharesrc/STAR-Fusion/STAR-Fusion\
--left_fq /scratch/dq2033-share/reads_1.fq.gz\
--right_fq /scratch/dq2033-share/reads_2.fq.gz\
--genome_lib_dir /ctat_genome_lib\
-O /scratch/dq2033-share/StarFusionOut\
--FusionInspector inspect --examine_coding_effect --denovo_reconstruct #not sure if this is denovo..

