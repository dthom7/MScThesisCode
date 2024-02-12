#!/bin/bash

#SBATCH --time=4:00:00
#SBATCH --mem=2G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/6_transdecoder/logs/6c_pfam_search.%j.log
#SBATCH --cpus-per-task=16

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables
readonly nthreads=16

#### Load modules
module load hmmer/3.3.2

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/6_transdecoder
readonly out_dir=${base_dir}/output

#### Input
readonly db=/home/jd2thomp/scratch/databases/pfam/Pfam-A.hmm
readonly pep_in=${out_dir}/merged.wf_nuc_align.fa.transdecoder_dir/longest_orfs.pep

#### Output
readonly domtblout=${out_dir}/pfam_search.domtblout
readonly out_file=${out_dir}/pfam_search.out

#### Print version information
echo "#### VERSION ####"
echo "$(hmmsearch -h)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}
hmmsearch \
    -E 1e-5 \
    --cpu ${nthreads} \
    --domtblout ${domtblout} \
    ${db} \
    ${pep_in} \
    > ${out_file}

echo "Completed with exit status ${?}"
