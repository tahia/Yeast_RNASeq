############################################# Head of all Scripts ####################################
# The following directories and files are expected to run for SNP calling
refDir=/nfs/turbo/lsa-wittkopp/Lab/Taslima/DBs/Yeast/SGD/Ensembl/ #Reference directory where the reference genome file will be
ref=Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa # Name of reference genome file
gtf=Saccharomyces_cerevisiae.R64-1-1.115.gtf
outDir=/scratch/wittkopp_root/wittkopp0/tahaque/Data/Yeast/NatF1HybridExp/ # output directory. It must be created before running the script
met=/nfs/turbo/lsa-wittkopp/Lab/Taslima/Pipes/RNASeq/Yeast_ASE_Meta.tab # Full path of meta file
TMP=/scratch/wittkopp_root/wittkopp0/tahaque/TMP

# Sample of meta file, ignore the "#" before each line. you can use any kind of tab delim file and change Step 1 accordingly.
#FH.1.06 1       AGBTU   8829.1.113057.GGCTAC
#FH.2.06 1       AGBTB   8829.1.113057.GATCAG
#FH.4.06 1       BHOSB   10980.5.187926.GAGCTCA-TTGAGCT
#FH.5.06 1       BHOSC   10980.5.187926.ATAGCGG-ACCGCTA
#FH.7.06 1       YPGT    8577.7.104714.ACGATA

# load required module in ARC
module load launcher
ml Bioinformatics
ml gcc/10.3.0-k2osx5y
ml bwa/0.7.15-uuhpya
ml fastx_toolkit
ml bwa
ml fastqc/0.11.9-p6ckgle
ml bbtools/38.96

ml fastx_toolkit
ml bwa
ml picard
ml samtools
ml gatk/3.5.0 

############################ Step 00: Create Path #####################################################
#I expect the output directory is the top directory that already exists & which already have 
#a directory "raw" where all the raw sequense files will be. Othe directories will be
#created here. So remove anything from there except that "raw" folder.Make sure that the files are decompressed.
#The Structure is like this
# outDir -
# 	-- raw
#       -- QualFiltered
#       -- Mapped
#       -- MapFiltered
#       -- AllCount
 
#Or use the following if you want to remove by this script
LC_ALL=C
#rm -r "${outDir}/"[A-Z]*
mkdir "${outDir}/QualFiltered" "${outDir}/Mapped" "${outDir}/MapFiltered" "${outDir}/AllCount"  "${outDir}/QualStat" "${outDir}/QualStatFiltered"

