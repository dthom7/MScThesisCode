#!/bin/bash

#SBATCH --time=72:00:00
#SBATCH --mem=128G
#SBATCH --cpus-per-task=8
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/8_transrate/logs/8b_transrate.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables
readonly nthreads=8

#### Load modules
module load transrate/1.0.3

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/8_transrate
readonly input_dir=${base_dir}/input
readonly output_dir=${base_dir}/output

#### Input
readonly transcriptome_fa=${input_dir}/merged.wf_nuc_align.fa
readonly R1_fastqs_tmp=$(ls ${input_dir}/*.R1.fq.gz | tr '\n' ',')
readonly R1_fastqs=${R1_fastqs_tmp::-1}
readonly R2_fastqs_tmp=$(ls ${input_dir}/*.R2.fq.gz | tr '\n' ',')
readonly R2_fastqs=${R2_fastqs_tmp::-1}

#### Print version information
echo "#### VERSION ####"
echo "$(transrate --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

transrate \
    --assembly ${transcriptome_fa} \
    --left ${R1_fastqs} \
    --right ${R2_fastqs} \
    --threads ${nthreads} \
    --output ${output_dir}

echo "Completed with exit status ${?}"
