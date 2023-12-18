#!/bin/bash

#SBATCH --time=2:00:00
#SBATCH --mem=1G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/qc/0_raw_reads_fastqc/logs/0b_raw_reads_fastqc.%A_%a.out
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
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/qc/0_raw_reads_fastqc
readonly input_dir=${base_dir}/input
readonly output_dir=${base_dir}/output

#### Input
readonly fastq_files=(${input_dir}/*.fastq.gz)
readonly nebnext_adapters=${input_dir}/nebnext_adapters.tsv

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
