#!/bin/bash

#SBATCH --time=16:00:00
#SBATCH --mem=6G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/9_uniref90_searches/logs/9e_uniref90_search_transcripts.%A_%a.log
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
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/9_uniref90_searches
readonly output_dir=${base_dir}/output/split_uniref90_results_transcripts
readonly input_dir=${base_dir}/output/transcripts_fasta_split

#### Input
readonly transcript_input=${input_dir}/merged.wf_nuc_align.part_$(printf %03d ${SLURM_ARRAY_TASK_ID}).fa
readonly db=/home/jd2thomp/scratch/databases/uniref90/uniref90

#### Output
readonly output_file=${output_dir}/uniref90_search_transcripts.outfmt6.${SLURM_ARRAY_TASK_ID}

#### Print version information
echo "#### VERSION ####"
echo "$(blastp -version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

blastx \
    -query ${transcript_input} \
    -db ${db} \
    -max_target_seqs 1 \
    -outfmt 6 \
    -evalue 1e-5 \
    -num_threads ${nthreads} \
    > ${output_file}

echo "Run complete with exit status ${?}"
