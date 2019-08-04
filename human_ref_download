#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --mem=64GB
#SBATCH --job-name=ref_download
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=kwk263@nyu.edu


# create and move to appropriate directory
mkdir /scratch/kwk263/var_calling/ref
cd /scratch/kwk263/var_calling/ref

# load needed modules
module load picard/2.8.2
module load samtools/intel/1.6 
module load bwa/intel/0.7.15

# download reference genome GRCh38
wget ftp://ftp.ensembl.org/pub/release-97/fasta/homo_sapiens/dna//Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
