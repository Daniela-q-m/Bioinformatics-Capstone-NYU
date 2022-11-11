#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --mem=4GB
#SBATCH --job-name=test
module purge
singularity exec \
        --overlay /scratch/dq2033-share/pVAC/overlay-15GB-500K.ext3:ro \
        /scratch/work/public/singularity/ubuntu-20.04.4.sif \
        /bin/bash -c "
export PATH=/ext3/bin:\${PATH}
which gtfToGenePred
which python

agfusion batch \
-f /scratch/dq2033-share/star_fusion_outdir/star-fusion.fusion_predictions.tsv \
-a starfusion \
-db agfusion.homo_sapiens.87.db \ #the genome build
-o /scratch/dq2033-share/fusion_antigen \
--middlestar \ #The --middlestar flag is required in order to use the ouput with pVACfuse. indicates the fusion position in the fusion peptide seq
--noncanonical #used to annotate the fusion with informations from all possible transcripts



#pvac fuse: locating fusion neoantigens and creating MHC class I and MHC class II prediction
#__________________________________________________________
pvacfuse run \
/scratch/dq2033-share/fusion_antigen \ #inputfile, ie the entire agfusion output directory
test_run1 \ #The name of the sample being processed. This will be used as a prefix for output files
HLA-A*02:01,HLA-B*35:01,DRB1*11:01 \ #Name of the allele to use for epitope prediction, can use multiple alleles
MHCflurry MHCnuggetsI MHCnuggetsII NNalign NetMHC PickPocket SMM SMMPMBEC SMMalign \ #epitope prediction algorithms to use, can use multiple
/scratch/dq2033-share/pvac_fuse_results \ #directory for results
-e1 8,9,10 \ #flag for Length of MHC Class I subpeptides(neopeptides)
-e2 15 #flag for Length of MHC Class II subpeptides(neopeptides)

#summarry of this code:
#running agFusion to create input file. pVACfuse accepts a output directory from AGFusion as input. The code below is 
#annotating the output from the STAR-Fusion caller.
#__________________________________________________________
