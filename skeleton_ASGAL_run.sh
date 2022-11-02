#download ASGAL software in Singulatiry container. Note, this is only run once
git clone --recursive https://github.com/AlgoLab/galig.git
cd galig
make prerequisites
make

#inputs for asgal:
#a reference chromosome (in FASTA format)
#a gene annotation (in GTF format)
#an RNA-Seq sample (in FASTA or FASTQ format, it can be gzipped)

#use ASGAL
./asgal -g [genome].fa -a [annotation].gtf -s [sample].fa -o outputFolder

#build the splicing graph of the input gene and to align the input sample
./bin/SpliceAwareAligner -g [reference] -a [annotation] -s [sample] -o outputFolder/output.mem

#analyze the events output file. This will detect the possible presence of alternative splicing events
#events detected are Exon Skipping, Alternative acceptor (3’) site, Alternative donor (5’) site, and Intron Retention
python3 ./scripts/detectEvents.py -g [reference] -a [annotation] -m output.mem -o outputFolder/output.events.csv


#the output .csv file will be loaded into IGV to make a Sashimi Plot. Building code for this in python