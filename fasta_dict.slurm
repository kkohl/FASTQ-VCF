#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --mem=80GB
#SBATCH --job-name=kwk_fasta_dict
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=kwk263@nyu.edu

#load needed modules
module load picard/2.17.11


# move to correct directory
cd /scratch/kwk263/var_calling/ref

# Create FASTA dictionary
java -jar ${PICARD_JAR} CreateSequenceDictionary \REFERENCE=Homo_sapiens.GRCh38.dna.primary_assembly.normalized.fa \OUTPUT=Homo_sapiens.GRCh38.dna.primary_assembly.normalized.dict
