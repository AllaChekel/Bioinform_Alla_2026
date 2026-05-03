#!/bin/bash
#SBATCH --partition=AMD9554-common
#SBATCH --job-name=fastqc_trimmed
#SBATCH --output=logs/fastqc_trimmed_%j.out
#SBATCH --error=logs/fastqc_trimmed_%j.err
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G

cd $HOME/bioinf_hw_5_fastqc

source $HOME/miniforge3/etc/profile.d/conda.sh
conda activate qc_env

mkdir -p results/fastqc_trimmed
mkdir -p results/multiqc_trimmed

echo "FastQC version:"
fastqc --version

echo "MultiQC version:"
multiqc --version

echo "Running FastQC for trimmed FASTQ files..."
fastqc \
  -t ${SLURM_CPUS_PER_TASK} \
  -o results/fastqc_trimmed \
  data/trimmed/*_trimmed.fastq.gz

echo "Running MultiQC for trimmed FastQC reports..."
multiqc \
  results/fastqc_trimmed \
  -o results/multiqc_trimmed \
  -n multiqc_trimmed_report.html

echo "Trimmed quality control is finished."
