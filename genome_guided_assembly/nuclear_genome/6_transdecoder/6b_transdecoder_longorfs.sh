#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --mem=1G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/6_transdecoder/logs/6b_transdecoder_longorfs.%j.log

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
readonly gene_trans_map=${input_dir}/merged.wf_nuc_align.gene_transcript_map.tsv

#### Print version information
echo "#### VERSION ####"
echo "$(TransDecoder.LongOrfs --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

TransDecoder.LongOrfs \
    -t ${transcriptome_fa} \
    --gene_trans_map ${gene_trans_map} \
    -m 50 \
    -S \
    --output_dir ${output_dir}

echo "Completed with exit status ${?}"
