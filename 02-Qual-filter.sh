############################################# Head of all Scripts ####################################
# The following directories and files are required to run for the RNASeq pipe
refDir=/nfs/turbo/lsa-wittkopp/Lab/Taslima/DBs/Yeast/SGD/Ensembl/ #Reference directory where the reference genome file will be
ref=Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa # Name of reference genome file
gtf=Saccharomyces_cerevisiae.R64-1-1.115.gtf
outDir=/scratch/wittkopp_root/wittkopp0/tahaque/Data/Yeast/NatF1HybridExp/ # output directory. It must be created before running the script
met=/nfs/turbo/lsa-wittkopp/Lab/Taslima/Pipes/RNASeq/Yeast_ASE_Meta.tab # Full path of meta file
TMP=/scratch/wittkopp_root/wittkopp0/tahaque/TMP



LC_ALL=C

################## step 2: RUN QUAL FILTER #########################

if [ -e fastq.param ]; then rm fastq.param; fi 
# Took ~ 5 minues for 120 files running parallelly with 2 threads using Trimmomatic
# Took ~ 30 minues for 120 decompressed files running parallelly with 2 threads using cutadapt 

LOG="logs"
for f in `ls $outDir/raw/*R1_001.fastq`
do
    BASE=$(basename $f)
    NAME=${BASE%_R1_001.fastq}
    IN2="${outDir}/raw/${NAME}_R2_001.fastq"
    OFIL1="${outDir}/QualFiltered/${NAME}_R1.fastq"
    OFIL2="${outDir}/QualFiltered/${NAME}_R2.fastq"
    OFILS="${outDir}/QualFiltered/${NAME}_st.fastq"    
    OFILS1="${outDir}/QualFiltered/${NAME}_st1.fastq"    
    OFILS2="${outDir}/QualFiltered/${NAME}_st2.fastq"    
    OLOG="${LOG}/${NAME}.log"
    #Trimmomatic
    #echo "TrimmomaticPE -phred33 -threads 2 $f $IN2\
    #$OFIL1 $OFILS1 $OFIL2 $OFILS2  ILLUMINACLIP:/nfs/turbo/lsa-wittkopp/Lab/Taslima/Pipes/RNASeq/adapter/TruSeq2-PE.fa:2:30:10 \
    #SLIDINGWINDOW:4:15 MINLEN:30 >> $OLOG" >> fastq.param
    echo "cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -a \"A{50}\" -a \"G{50}\" -G \"T{50}\" -A \"G{50}\" --pair-filter=any -m 50 -o $OFIL1 -p $OFIL2 $f $IN2 " >>fastq.param
done

# Now Run the job.To be safe side assign for 12 hrs.
#Core=`wc -l fastq.param |cut -f1 -d ' '`
#if (( $Core % 8 == 0)); then Node="$(($Core/8))"; 
#	else  Node="$((($Core/8)+1))"; 
#fi

#echo $Core
## Change time (-t) and partition (-p) as per your need and in slurm file change your allocation name
#sbatch -J filterqual --mail-user=taslima@utexas.edu -N $Node -n $Core --ntasks-per-node=8 -p normal -t 08:00:00 slurm.sh fastq.param


