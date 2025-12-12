# The following directories and files are expected to run the RNAseq pipe
refDir=/nfs/turbo/lsa-wittkopp/Lab/Taslima/DBs/Yeast/SGD/Ensembl/ #Reference directory where the reference genome file will be
ref=Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa # Name of reference genome file
gtf=Saccharomyces_cerevisiae.R64-1-1.115.gtf
outDir=/scratch/wittkopp_root/wittkopp0/tahaque/Data/Yeast/NatF1HybridExp/ # output directory. It must be created before running the script
met=/nfs/turbo/lsa-wittkopp/Lab/Taslima/Pipes/RNASeq/Yeast_ASE_Meta.tab # Full path of meta file
TMP=/scratch/wittkopp_root/wittkopp0/tahaque/TMP

LC_ALL=C

LOG=logs/
#################################### Step 1-1: Decomp ############################################

if [ -e decomp.param ]; then rm decomp.param; fi

if [ ! -d $LOG ]; then 
    echo "Log directory doesn't exist. Making $LOG"
    mkdir $LOG
fi

for f in `ls $outDir/raw/*R*_001.fastq.gz`
do
    BASE=$(basename $f)
    NAME=${BASE%.gz}
    OFIL="${outDir}/raw/${NAME}"
    OLOG="${LOG}/${NAME}.log"
    echo "gunzip $f -k --stdout > $OFIL 2> $OLOG" >> decomp.param
done


