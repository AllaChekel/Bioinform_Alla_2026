#!/bin/bash
#SBATCH --partition=AMD9554-common
#SBATCH --job-name=fastqc_raw
#SBATCH --output=logs/fastqc_raw_%j.out
#SBATCH --error=logs/fastqc_raw_%j.err
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G

cd $HOME/bioinf_hw_5_fastqc

source $HOME/miniforge3/etc/profile.d/conda.sh
conda activate qc_env

mkdir -p results/fastqc_raw
mkdir -p results/multiqc_raw

echo "FastQC version:"
fastqc --version

echo "MultiQC version:"
multiqc --version

echo "Running FastQC for raw FASTQ files..."
fastqc \
  -t ${SLURM_CPUS_PER_TASK} \
  -o results/fastqc_raw \
  data/raw/*.fastq.gz

echo "Running MultiQC for raw FastQC reports..."
multiqc \
  results/fastqc_raw \
  -o results/multiqc_raw \
  -n multiqc_raw_report.html

echo "Raw quality control is finished."
