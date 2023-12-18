#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --mem=1G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/9_uniref90_searches/logs/9b_split_input_fastas.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables

#### Load modules
module load seqkit/2.3.1

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/9_uniref90_searches
readonly input_dir=${base_dir}/input
readonly output_dir=${base_dir}/output
readonly transcripts_output_dir=${output_dir}/transcripts_fasta_split
readonly pep_output_dir=${output_dir}/peptides_fasta_split

#### Input
readonly transcripts_input=${input_dir}/merged.wf_nuc_align.fa
readonly pep_input=${input_dir}/merged.wf_nuc_align.fa.transdecoder.pep

#### Print version information
echo "#### VERSION ####"
echo "$(seqkit version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}
mkdir -p ${transcripts_output_dir}
mkdir -p ${pep_output_dir}

seqkit split2 \
    -p 1000 \
    --out-dir ${transcripts_output_dir} \
    ${transcripts_input}
echo "Transcripts fasta split with exit status ${?}"

seqkit split2 \
    -p 1000 \
    --out-dir ${pep_output_dir} \
    ${pep_input}
echo "Peptide fasta split with exit status ${?}"

echo "Run complete with exit status ${?}"
