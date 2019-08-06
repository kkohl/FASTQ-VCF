#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --mem=120GB
#SBATCH --job-name=kwk_align #SBATCH --mail-type=FAIL
#SBATCH --mail-user=kwk263@nyu.edu 
#SBATCH --array=1-13

#load needed modules
module load picard/2.17.11
module load samtools/intel/1.6 
module load bwa/intel/0.7.15


# read sample table
table=/home/kwk263/fast-vars/sample_ftp_table.txt
line="$(head -n ${SLURM_ARRAY_TASK_ID} "${table}" | tail -n 1)"
sample="$(printf "%s" "${line}" | cut -f1)"
pair1="$(printf "%s" "${line}" | cut -f2)"
pair2="$(printf "%s" "${line}" | cut -f3)"



# move to correct directory
mkdir /scratch/kwk263/var_calling/
cd /scratch/kwk263/var_calling/ref
