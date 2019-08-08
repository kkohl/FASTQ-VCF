#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --mem=64GB
#SBATCH --job-name=kwk_trim 
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=kwk263@nyu.edu 
#SBATCH --array=1-13

#load needed modules
module load trimmomatic/0.36

# read sample table
ref=/scratch/kwk263/var_calling/ref/Homo_sapiens.GRCh38.dna.primary_assembly.normalized.fa
table=/home/kwk263/fast-vars/fastq_table.txt
line="$(head -n ${SLURM_ARRAY_TASK_ID} "${table}" | tail -n 1)"
sample="$(printf "%s" "${line}" | cut -f1)"
pair1="$(printf "%s" "${line}" | cut -f2)"
pair2="$(printf "%s" "${line}" | cut -f3)"

cd /scratch/kwk263/var_calling/FASTQs/"${sample}"/

java -jar "${TRIMMOMATIC_JAR}" PE -phred33 "${pair1}" "${pair2}" "{sample}"_forward_paired.fq.gz "{sample}"_forward_unpaired.fq.gz "{sample}"_reverse_paired.fq.gz "{sample}"_reverse_unpaired.fq.gz ILLUMINACLIP:/scratch/courses/BI7653/hw3.2018/concatenated_adapters.fa:2:30:10 MINLEN:75
