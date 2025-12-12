#!/bin/bash
#SBATCH --job-name=RNASeq_Qual
#SBATCH -o Job.o%j
#SBATCH -e Job.e%j
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
##SBATCH --array=1-14
##SBATCH --ntasks-per-node=14
#SBATCH --mem-per-cpu=2g 
#SBATCH --time=00-10:00:00 #--time=<dd-hh:mm:ss>
#SBATCH --account=wittkopp0
#SBATCH --partition=standard


module load launcher
ml Bioinformatics
ml gcc/10.3.0-k2osx5y
ml bwa/0.7.15-uuhpya
ml fastx_toolkit
ml fastqc/0.11.9-p6ckgle
ml bbtools/38.96
ml trimmomatic/0.36
ml cutadapt/1.18
ml picard-tools/2.8.1
ml star/2.7.11a-hdp2onj
#ml picard-tools/3.0.0
ml samtools/1.13-fwwss5n
ml gatk/3.7
ml vcftools/0.1.15
ml subread
#ml picard
#ml samtools
#ml gatk/3.8.0
#ml sratoolkit

CMD=$1

export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE=$CMD

$LAUNCHER_DIR/paramrun

echo "DONE";
date;

