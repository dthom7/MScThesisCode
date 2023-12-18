#!/bin/bash

#SBATCH --time=01:00:00
#SBATCH --mem=2G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie/logs/5d_generate_fasta.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Load modules
readonly gffread=/home/jd2thomp/programs/gffread-0.12.7.Linux_x86_64/gffread

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie
readonly input_dir=${base_dir}/output/merge
readonly output_dir=${base_dir}/output/fasta

#### Input
readonly genome_fasta=/home/jd2thomp/projects/def-bkatzenb/jd2thomp/genomes/woodfrog_nuclear/samtools_index/GCA_028564925.1_aRanSyl1.merge_genomic.fna
readonly transcripts_gtf=${input_dir}/merged.wf_nuc_align.gtf

#### Output
readonly output_file=${output_dir}/merged.wf_nuc_align.fa

#### Print version information
echo "#### VERSION ####"
echo "$(${gffread} --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

${gffread} \
    -g ${genome_fasta} \
    -w ${output_file} \
    ${transcripts_gtf}

echo "Completed with exit status ${?}"
