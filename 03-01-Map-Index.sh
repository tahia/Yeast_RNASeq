############################################# Head of all Scripts ####################################
# The following directories and files are expected to run the RNAseq pipe
refDir=/nfs/turbo/lsa-wittkopp/Lab/Taslima/DBs/Yeast/SGD/Ensembl/ #Reference directory where the reference genome file will be
ref=Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa # Name of reference genome file
gtf=Saccharomyces_cerevisiae.R64-1-1.115.gtf
outDir=/scratch/wittkopp_root/wittkopp0/tahaque/Data/Yeast/NatF1HybridExp/ # output directory. It must be created before running the script
met=/nfs/turbo/lsa-wittkopp/Lab/Taslima/Pipes/RNASeq/Yeast_ASE_Meta.tab # Full path of meta file
TMP=/scratch/wittkopp_root/wittkopp0/tahaque/TMP

LC_ALL=C

############### Step 3-01: RUN MAP Index ########################################

#before maping do index for bwa mem, samtool index and picard dict.If you have all three index in your reference
# directory , then ignore this step and run 3-02

if [ -e buildgenome.param ]; then rm buildgenome.param; fi 

#echo "bwa index $refDir/$ref" >>index.param
#echo "picard-tools  CreateSequenceDictionary R=$refDir/$ref O=$refDir/${ref%.fa}.dict " >>\
#    index.param
#echo "samtools faidx $refDir/$ref" >>index.param
 echo  "STAR --runThreadN 8 --runMode genomeGenerate --genomeDir $refDir/STAR --genomeFastaFiles $refDir/$ref \
--sjdbGTFfile $refDir/$gtf --genomeSAindexNbases 10"  >buildgenome.param

#sbatch -J index -N 1 -n 3 -p development --ntasks-per-node=3 -t 02:00:00 slurm.sh index.param



