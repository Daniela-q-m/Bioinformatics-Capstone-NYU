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
singularity exec -e --overlay /scratch/dq2033-share -B /scratch/dq2033-share/tutorial_star_fusion \
        star-fusion-v$version.simg \ #need to update to .smig.........
        STAR-Fusion \
        --left_fq /scratch/dq2033-share/reads_1.fq.gz\
        --right_fq /scratch/dq2033-share/reads_2.fq.gz\
        --genome_lib_dir /scratch/dq2033-share/tutorial_star_fusion\
        -O /scratch/dq2033-share/StarFusionOut\
        --FusionInspector inspect --examine_coding_effect --denovo_reconstruct #not sure if this is denovo..

# written by Charlee Cobb 11/20/2022
