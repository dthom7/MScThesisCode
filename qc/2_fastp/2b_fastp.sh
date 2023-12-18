#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --mem=6G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/qc/2_fastp/logs/2b_fastp.%A_%a.out
#SBATCH --cpus-per-task=8
#SBATCH --array=0-33

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables
readonly nthreads=8

#### Load modules
module load fastp/0.23.4

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/qc/2_fastp
readonly input_dir=${base_dir}/input
readonly output_dir=${base_dir}/output

#### Input
readonly R1_files=(${input_dir}/*_R1_001.cor.fq.gz)
readonly R2_files=(${input_dir}/*_R2_001.cor.fq.gz)
readonly adapter_fasta=${input_dir}/nebnext_adapters.fasta

#### Array handling
echo "R1_files length: ${#R1_files[@]}"
echo "R2_files length: ${#R2_files[@]}"

readonly R1=${R1_files[${SLURM_ARRAY_TASK_ID}]}
readonly R2=${R2_files[${SLURM_ARRAY_TASK_ID}]}
readonly sample_id_tmp=$(basename ${R1} _R1_001.cor.fq.gz)
readonly sample_id=${sample_id_tmp:8}
echo "R1 file: ${R1}"
echo "R2 file: ${R2}"
echo "sample id: ${sample_id}"

#### Output
readonly R1_out=${output_dir}/paired/${sample_id}.cor.trim.R1.fq.gz
readonly R2_out=${output_dir}/paired/${sample_id}.cor.trim.R2.fq.gz
readonly R1_up=${output_dir}/unpaired/${sample_id}.cor.trim.unpaired.R1.fq.gz
readonly R2_up=${output_dir}/unpaired/${sample_id}.cor.trim.unpaired.R2.fq.gz
readonly html_report=${output_dir}/reports/${sample_id}.html
readonly json_report=${output_dir}/reports/${sample_id}.json

#### Print version information
echo "#### VERSION ####"
echo "$(fastp --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

fastp \
    -i ${R1} \
    -I ${R2} \
    -o ${R1_out} \
    -O ${R2_out} \
    -h ${html_report} \
    -j ${json_report} \
    --unpaired1 ${R1_up} \
    --unpaired2 ${R2_up} \
    --dont_overwrite \
    -q 20 \
    -u 10 \
    -n 0 \
    -l 36 \
    --adapter_fasta ${adapter_fasta} \
    --cut_mean_quality 20 \
    --cut_front \
    --cut_front_window_size 1 \
    --cut_tail \
    --cut_tail_window_size 1 \
    --cut_right \
    --cut_right_window_size 4 \
    --trim_poly_g \
    --trim_poly_x \
    --thread ${nthreads}

echo "Completed with exit status ${?}"
