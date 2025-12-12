############################################# Head of all Scripts ####################################
# The following directories and files are expected to run the RNAseq pipe
refDir=/nfs/turbo/lsa-wittkopp/Lab/Taslima/DBs/Yeast/SGD/Ensembl/ #Reference directory where the reference genome file will be
ref=Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa # Name of reference genome file
gtf=Saccharomyces_cerevisiae.R64-1-1.115.gtf
outDir=/scratch/wittkopp_root/wittkopp0/tahaque/Data/Yeast/NatF1HybridExp/ # output directory. It must be created before running the script
met=/nfs/turbo/lsa-wittkopp/Lab/Taslima/Pipes/RNASeq/Yeast_ASE_Meta.tab # Full path of meta file
TMP=/scratch/wittkopp_root/wittkopp0/tahaque/TMP



LC_ALL=C

################## step 2: RUN QUAL FILTER #########################

if [ -e fastqc.param ]; then rm fastqc.param; fi

#Raw : takes about 5 minutes to run for 120 files
#Example name: 10-3932-III_S1_L001_R1_001.fastq.gz
#for f in `ls $outDir/raw/*R1_001.fastq.gz`
#for f in `ls $outDir/QualFiltered/*R1_001.fastq.gz`
#do
#    BASE=$(basename $f)
#    NAME=${BASE%_R1_001.fastq.gz}

#    IN2="${outDir}/raw/${NAME}_R2_001.fastq.gz"
#    ODIR="${outDir}/QualStat/"
#    echo "fastqc --noextract $f -o $ODIR threads=2" >>fastqc.param
#    echo "fastqc --noextract $IN2 -o $ODIR threads=2" >>fastqc.param
#done

#Check after Quality filter and adapter trimming
for f in `ls $outDir/QualFiltered/*R*.fastq`
do
    BASE=$(basename $f)
    NAME=${BASE%.fastq}
    ODIR="${outDir}/QualStatFiltered/"
    echo "fastqc --noextract $f -o $ODIR threads=2" >>fastqc.param
done


