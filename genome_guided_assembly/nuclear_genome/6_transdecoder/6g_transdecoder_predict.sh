#!/bin/bash

#SBATCH --time=8:00:00
#SBATCH --mem=8G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/6_transdecoder/logs/6g_transdecoder_predict.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables

#### Load modules
module load gcc/9.3.0
module load transdecoder/5.7.1

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/6_transdecoder
readonly input_dir=${base_dir}/input
readonly output_dir=${base_dir}/output

#### Input
readonly transcriptome_fa=${input_dir}/merged.wf_nuc_align.fa
readonly uniref90_search=${output_dir}/uniref90_search.outfmt6
readonly pfam_search=${output_dir}/pfam_search.domtblout

#### Print version information
echo "#### VERSION ####"
echo "$(TransDecoder.Predict --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

TransDecoder.Predict \
    -t ${transcriptome_fa} \
    --retain_pfam_hits ${pfam_search} \
    --retain_blastp_hits ${uniref90_search} \
    --output_dir ${output_dir}

echo "Completed with exit status ${?}"
