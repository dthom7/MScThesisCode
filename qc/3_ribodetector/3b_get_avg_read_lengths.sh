#!/bin/bash

#SBATCH --time=2:00:00
#SBATCH --mem=2G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/qc/3_ribodetector/logs/3b_get_avg_read_lengths.%A_%a.out
#SBATCH --array=0-33

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables

#### Load modules
module load seqkit/2.3.1

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/qc/3_ribodetector
readonly input_dir=${base_dir}/input
readonly output_dir=${base_dir}/output/pre_filter_stats

#### Input
readonly R1_files=(${input_dir}/*.cor.trim.R1.fq.gz)
readonly R2_files=(${input_dir}/*.cor.trim.R2.fq.gz)

#### Array handling
echo "R1_files length: ${#R1_files[@]}"
echo "R2_files length: ${#R2_files[@]}"

readonly R1=${R1_files[${SLURM_ARRAY_TASK_ID}]}
readonly R2=${R2_files[${SLURM_ARRAY_TASK_ID}]}
echo "R1 file: ${R1}"
echo "R2 file: ${R2}"

#### Output
readonly report=${output_dir}/$(basename ${R1} .cor.trim.R1.fq.gz).tsv

#### Print version information
echo "#### VERSION ####"
echo "$(seqkit version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

seqkit stats \
    ${R1} \
    ${R2} \
    -o ${report}

echo "Completed with exit status ${?}"
