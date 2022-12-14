#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --mem=4GB
#SBATCH --job-name=test

#inputs for asgal:
#a reference chromosome (in FASTA format)
#a gene annotation (in GTF format)
#an RNA-Seq sample (in FASTA or FASTQ format, it can be gzipped)

#use ASGAL
./asgal -g /scratch/dq2033-share/genome_38.fa -a /scratch/dq2033-share/annotation.gtf -s /scratch/dq2033-share/test_sample.fa -o outputFolder

#build the splicing graph of the input gene and to align the input sample
./bin/SpliceAwareAligner -g /scratch/dq2033-share/genome_38.fa -a /scratch/dq2033-share/annotation.gtf -s /scratch/dq2033-share/test_sample.fa -o outputFolder/output.mem

#analyze the events output file. This will detect the possible presence of alternative splicing events
#events detected are Exon Skipping, Alternative acceptor (3’) site, Alternative donor (5’) site, and Intron Retention
python3 ./scripts/detectEvents.py -g /scratch/dq2033-share/genome_38.fa -a /scratch/dq2033-share/annotation.gtf -m output.mem -o outputFolder #for output.events.csv


#the output .csv file will be loaded into IGV to make a Sashimi Plot. Building code for this in python

#download ASGAL software in Singulatiry container. Note, this is only run once
git clone --recursive https://github.com/AlgoLab/galig.git
cd galig
make prerequisites
make
