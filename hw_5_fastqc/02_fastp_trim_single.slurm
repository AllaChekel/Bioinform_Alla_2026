#!/bin/bash
#SBATCH --partition=AMD9554-common
#SBATCH --job-name=fastp_trim
#SBATCH --output=logs/fastp_trim_%j.out
#SBATCH --error=logs/fastp_trim_%j.err
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G

cd $HOME/bioinf_hw_5_fastqc

source $HOME/miniforge3/etc/profile.d/conda.sh
conda activate qc_env

mkdir -p data/trimmed
mkdir -p results/fastp

echo "fastp version:"
fastp --version

for fq in data/raw/*.fastq.gz
do
    sample=$(basename "$fq" .fastq.gz)

    echo "Processing sample: $sample"

    fastp \
      -i "$fq" \
      -o "data/trimmed/${sample}_trimmed.fastq.gz" \
      --cut_right \
      --cut_window_size 5 \
      --cut_mean_quality 20 \
      --length_required 36 \
      --thread ${SLURM_CPUS_PER_TASK} \
      --html "results/fastp/${sample}_fastp.html" \
      --json "results/fastp/${sample}_fastp.json"
done

echo "Trimming finished."
