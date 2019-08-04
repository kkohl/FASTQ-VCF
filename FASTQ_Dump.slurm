#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --mem=8GB
#SBATCH --job-name=kwk_fastq_dump 
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=kwk263@nyu.edu
#SBATCH --array=1-13

# State slurm job ID
echo The array index is: "${SLURM_ARRAY_TASK_ID}"

## go to correct directory
mkdir /scratch/kwk263/var_calling/FASTQs/
cd /scratch/kwk263/var_calling/FASTQs/



# read sample table
table=/home/kwk263/fast-vars/sample_ftp_table.txt
line="$(head -n ${SLURM_ARRAY_TASK_ID} "${table}" | tail -n 1)"
sample="$(printf "%s" "${line}" | cut -f1)"
pair1="$(printf "%s" "${line}" | cut -f2)"
pair2="$(printf "%s" "${line}" | cut -f3)"

# create directory for each sample to store FASTQ files
mkdir /scratch/kwk263/var_calling/FASTQs/"${sample}"
cd /scratch/kwk263/var_calling/FASTQs/"${sample}"

# use wget
wget "${pair1}"
wget "${pair2}"
