#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --mem=80GB
#SBATCH --job-name=kwk_fasta_prep
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=kwk263@nyu.edu

#load needed modules
module load picard/2.8.2
module load samtools/intel/1.6 
module load bwa/intel/0.7.15

# move to correct directory
cd /scratch/kwk263/var_calling/ref

# unzip references FASTA
gunzip -c Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz > Homo_sapiens.GRCh38.dna.primary_assembly.fa

#N Normalize FASTA file
java -jar "${PICARD_JAR}" NormalizeFasta \
	TRUNCATE_SEQUENCE_NAMES_AT_WHITESPACE=true \
	I=Homo_sapiens.GRCh38.dna.primary_assembly.fa \
	O=Homo_sapiens.GRCh38.dna.primary_assembly.normalized.fa
  
# index reference  
bwa index -a bwtsw Homo_sapiens.GRCh38.dna.primary_assembly.normalized.fa
samtools faidx Homo_sapiens.GRCh38.dna.primary_assembly.normalized.fa

java -jar "${PICARD_JAR}" CreateSequenceDictionary \
    REFERENCE=Homo_sapiens.GRCh38.dna.primary_assembly.normalized.fa \ 
    OUTPUT=Homo_sapiens.GRCh38.dna.primary_assembly.normalized.dict
