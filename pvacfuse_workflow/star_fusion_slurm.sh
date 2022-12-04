#running star-fusion to obtain tsv file.
#note, this is run in the shared folder, /scratch/dq2033-share
#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --mem=16GB
#SBATCH --job-name=test
module purge
module load 
STAR-Fusion  --left_fq reads_1.fq \
             --right_fq reads_2.fq \
             --output_dir star_fusion_outdir/star-fusion.fusion_predictions.tsv

# written by Charlee Cobb - 11/07/2022
