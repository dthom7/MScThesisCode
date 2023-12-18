#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --mem=1G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/qc/2_fastp/logs/2c_fastqc_paired.%A_%a.out
#SBATCH --array=0-67

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables

#### Load modules
module load fastqc/0.12.0

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/qc/2_fastp
readonly input_dir=${base_dir}/output/paired
readonly output_dir=${input_dir}/fastqc

#### Input
readonly fastq_files=(${input_dir}/*.fq.gz)
readonly nebnext_adapters=/home/jd2thomp/scratch/microplastics_v2/qc/2_fastp/input/nebnext_adapters.tsv

#### Array handling
echo "fastq_files length: ${#fastq_files[@]}"

readonly fq=${fastq_files[${SLURM_ARRAY_TASK_ID}]}
echo "fastq file: ${fq}"

#### Print version information
echo "#### VERSION ####"
echo "$(fastqc --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

fastqc \
    -o ${output_dir} \
    -a ${nebnext_adapters} \
    --svg \
    ${fq}

echo "Completed with exit status ${?}"
