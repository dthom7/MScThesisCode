#!/bin/bash

#SBATCH --time=12:00:00
#SBATCH --mem=4G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/6_transdecoder/logs/6e_uniref90_search/6e_uniref90_search.%A_%a.log
#SBATCH --cpus-per-task=16
#SBATCH --array=1-1000

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables
readonly nthreads=16

#### Load modules
module load gcc/9.3.0
module load blast+/2.14.0

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/6_transdecoder
readonly output_dir=${base_dir}/output/split_uniref90_results
readonly input_dir=${base_dir}/output/step1_fasta_split

#### Input
readonly pep_input=${input_dir}/longest_orfs.part_$(printf %03d ${SLURM_ARRAY_TASK_ID}).pep
readonly db=/home/jd2thomp/scratch/databases/uniref90/uniref90

#### Output
readonly output_file=${output_dir}/uniref90_search.outfmt6.${SLURM_ARRAY_TASK_ID}

#### Print version information
echo "#### VERSION ####"
echo "$(blastp -version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

blastp \
    -query ${pep_input} \
    -db ${db} \
    -max_target_seqs 1 \
    -outfmt 6 \
    -evalue 1e-5 \
    -num_threads ${nthreads} \
    > ${output_file}

echo "Run complete with exit status ${?}"
