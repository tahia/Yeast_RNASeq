############################################# Head of all Scripts ####################################
# The following directories and files are required to run for the RNASeq pipe
refDir=/nfs/turbo/lsa-wittkopp/Lab/Taslima/DBs/Yeast/SGD/Ensembl/ #Reference directory where the reference genome file will be
ref=Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa # Name of reference genome file
gtf=Saccharomyces_cerevisiae.R64-1-1.115.gtf
outDir=/scratch/wittkopp_root/wittkopp0/tahaque/Data/Yeast/NatF1HybridExp/ # output directory. It must be created before running the script
met=/nfs/turbo/lsa-wittkopp/Lab/Taslima/Pipes/RNASeq/Yeast_ASE_Meta.tab # Full path of meta file
TMP=/scratch/wittkopp_root/wittkopp0/tahaque/TMP
OFIL=$outDir/Counts/ASE_Yeast_Hybrid_V2.tab


LC_ALL=C

################## step 2: RUN QUAL FILTER #########################

if [ -e count.param ]; then rm count.param; fi 
# Took ~ 4 minues for 60 samples using  FeatureCounts with 24 cpus

LOG="logs"
OLOG=$LOG/FeatureCounts.log

# Remove if the output file exists
if [ -e $OFIL ]; then rm $OFIL; fi


for f in `ls $outDir/Mapped/*_L001Aligned.sortedByCoord.out.bam`
do
    BASE=$(basename $f)
    NAME=${BASE%_L001Aligned.sortedByCoord.out.bam}
    IN+="${f} "
done

echo "featureCounts -a $refDir/$gtf -o $OFIL -t gene -g gene_id --readExtension5 0  --readExtension3 0 -s 0 -Q 0 -d 50 -T 24 -M -p $IN  > $OLOG " >> count.param


