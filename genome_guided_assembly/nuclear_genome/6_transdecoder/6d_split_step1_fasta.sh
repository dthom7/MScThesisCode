#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --mem=1G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/6_transdecoder/logs/6d_split_step1_fasta.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables

#### Load modules
module load seqkit/2.3.1

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/6_transdecoder
readonly output_dir=${base_dir}/output/step1_fasta_split

#### Input
readonly pep_input=${base_dir}/output/merged.wf_nuc_align.fa.transdecoder_dir/longest_orfs.pep

#### Print version information
echo "#### VERSION ####"
echo "$(seqkit version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

mkdir -p ${output_dir}
cd ${output_dir}

seqkit split2 -p 1000 --out-dir . ${pep_input}

echo "Run complete with exit status ${?}"
