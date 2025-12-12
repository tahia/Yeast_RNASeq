############################################# Head of all Scripts ####################################
# The following directories and files are expected to run the RNAseq pipe
refDir=/nfs/turbo/lsa-wittkopp/Lab/Taslima/DBs/Yeast/SGD/Ensembl/ #Reference directory where the reference genome file will be
ref=Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa # Name of reference genome file
gtf=Saccharomyces_cerevisiae.R64-1-1.115.gtf
outDir=/scratch/wittkopp_root/wittkopp0/tahaque/Data/Yeast/NatF1HybridExp/ # output directory. It must be created before running the script
met=/nfs/turbo/lsa-wittkopp/Lab/Taslima/Pipes/RNASeq/Yeast_ASE_Meta.tab # Full path of meta file
TMP=/scratch/wittkopp_root/wittkopp0/tahaque/TMP


LC_ALL=C

############### Step 3-2: RUN MAP ########################################

#Took ~2 hrs with 4 threads for each task running parallely
#Make sure to have ~4G of RAM per CPU else it will choke while sorting BAM
# MApping version 1  has the following params:
#STAR --runThreadN 4 --runMode alignReads --genomeDir $refDir/STAR \
#--quantMode GeneCounts \
#--sjdbGTFfeatureExon gene \
#--readFilesIn $f $ff \
#--outFilterType BySJout \
#--outSAMmapqUnique 255 \
#--alignSJoverhangMin 8 \
#--alignSJDBoverhangMin 1 \
#--outFilterMismatchNmax 8 \
#--outFilterMismatchNoverReadLmax 0.04 \
#--alignIntronMin 20 \
#--outSAMtype BAM SortedByCoordinate \
#--outFileNamePrefix $OFIL \
#--outTmpDir $TMP/$NAME \
#--limitBAMsortRAM 2000000000

#V2: Caludal et al. 2024 Pan-transcriptome
# echo "STAR --runThreadN 4 --runMode alignReads --genomeDir $refDir/STAR \
#--outReadsUnmapped Fastx \
#--quantMode GeneCounts \
#--sjdbGTFfeatureExon gene \
#--readFilesIn $f $ff \
#--outFilterType BySJout \
#--outFilterMultimapNmax 20 \
#--alignSJoverhangMin 8 \
#--alignSJDBoverhangMin 1 \
#--outFilterMismatchNmax 4 \
#--alignIntronMin 20 \
#--alignIntronMax 2000 \
#--outSAMtype BAM SortedByCoordinate \
#--outFileNamePrefix $OFIL \
#--outTmpDir $TMP/$NAME \
#--limitBAMsortRAM 2000000000 

if [ -e star.param ]; then rm star.param; fi
for f in `ls $outDir/QualFiltered/*_R1.fastq`
do
    BASE=$(basename $f)
    NAME=${BASE%_R1.fastq}
    OFIL="${outDir}/Mapped/${NAME}"
    ff=${f%_R1.fastq}_R2.fastq
    st1=${f%_R1.fastq}_st1.fastq
    st2=${f%_R1.fastq}_st2.fastq
    #echo "$ff"
    echo "STAR --runThreadN 4 --runMode alignReads --genomeDir $refDir/STAR \
--outReadsUnmapped Fastx \
--quantMode GeneCounts \
--sjdbGTFfeatureExon gene \
--readFilesIn $f $ff \
--outFilterType BySJout \
--outFilterMultimapNmax 20 \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 1 \
--outFilterMismatchNmax 4 \
--alignIntronMin 20 \
--alignIntronMax 2000 \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix $OFIL \
--outTmpDir $TMP/$NAME \
--limitBAMsortRAM 2000000000 " >> star.param 
done

# Now Run the job.To be same side assign for 12 hrs.
#Core=`wc -l bwa-mem.param |cut -f1 -d ' '`
#if (( $Core % 3 == 0)); then Node="$(($Core/3))";
#        else  Node="$((($Core/3)+1))";
#fi

#echo "$Node $Core"
## Change time (-t) and partition (-p) as per your need and in slurm file change your allocation name
#sbatch -J map -N $Node -n $Core -p normal -t 32:00:00 --ntasks-per-node=3 slurm.sh bwa-mem.param

